<#
.Synopsis
    Builds an HTML table of two-letter codes.

.Link
    https://www.iso.org/iso-3166-country-codes.html

.Link
    https://en.wikipedia.org/wiki/ISO4217

.Link
    https://github.com/olahol/iso-3166-2.json

.Link
    https://github.com/datasets/fips-10-4
#>

#Requires -Version 3
[CmdletBinding()] Param(
[uri] $IsoCountryCodesUrl = 'https://raw.githubusercontent.com/olahol/iso-3166-2.json/master/iso-3166-2.json',
[uri] $FipsCountryCodesUrl = 'https://raw.githubusercontent.com/datasets/fips-10-4/master/data/data.csv',
[uri] $CurrencyCodesUrl = 'https://www.currency-iso.org/dam/downloads/lists/list_one.xml',
[uri] $LanguageCodesUrl = 'http://www.lingoes.net/en/translator/langcode.htm'
)

if(!(Test-Path data -PathType Container)) {mkdir data |Out-Null}
function Save-Data([Parameter(Mandatory=$true)][uri]$Url,[string]$Filename,[int]$MaxAgeInDays=100,[string]$Search,[string]$Replace)
{
    $path = Join-Path data $(if(!$Filename) {$Url.Segments[-1]} else {$Filename})
    if(!(Test-Path $path -PathType Leaf) -or (Get-Item $path).LastWriteTime -lt [datetime]::Today.AddDays(-$MaxAgeInDays))
    {
        Invoke-WebRequest $Url -OutFile $path
        if($Search) {(Get-Content $path -Encoding utf8 -Raw) -replace $Search,$Replace |Out-File $path utf8}
    }
    return $path
}

$icon = @{
    mismatch       = '&#x26A0;'           # WARNING SIGN
    iso_only       = '&#x1F310;'          # GLOBE WITH MERIDIANS
    fips_only      = '&#x1F1FA;&#x1F1F8;' # REGIONAL INDICATOR SYMBOL LETTER U + S
    subregion_only = '&#x1F6C8;'          # CIRCLED INFORMATION SOURCE
    not_a_code     = '&cir;'              # WHITE CIRCLE
    language       = '&#x1F4AC;'          # SPEECH BALLOON
}

$Script:iso,$Script:fips,$Script:currency,$Script:lang,$Script:subregion = @{},@{},@{},@{},@{
    UK = @('UK United Kingdom (NUTS)')
    GB = @('GB See UK for United Kingdom (NUTS)')
    EL = @('EL Greece (NUTS)')
    GR = @('GR See EL for Greece (NUTS)')
}
function Read-Codes
{
    $isodata = Get-Content (Save-Data $IsoCountryCodesUrl iso3166-2.json) -Encoding utf8 |ConvertFrom-Json
    foreach($entry in $isodata.PSObject.Properties)
    {
        $code,$value,$name = $entry.Name,$entry.Value,$entry.Value.name
        [void]$Script:iso.Add($code,$name)
        foreach($division in $value.divisions.PSObject.Properties)
        {
            $subcode = ($division.Name -split '-',2)[1]
            $name = $division.Name + ' ' + $division.Value
            if($Script:subregion.ContainsKey($subcode)) {$Script:subregion[$subcode] += $name}
            else {[void]$Script:subregion.Add($subcode,@($name))}
        }
    }
    if(!$Script:iso.Count) {throw 'No ISO codes read.'}
    Write-Verbose "Read $($Script:iso.Count) ISO codes"
    Import-Csv (Save-Data $FipsCountryCodesUrl fips-10-4.csv) |
        ? region_division -eq 'country' |
        % {[void]$Script:fips.Add($_.region_code.Substring(0,2),$_.region_name)}
    if(!$Script:fips.Count) {throw 'No FIPS codes read.'}
    Write-Verbose "Read $($Script:fips.Count) FIPS codes"
    Select-Xml '//CcyNtry[Ccy]' (Save-Data $CurrencyCodesUrl iso4217.xml -Search '<CcyNm IsFund="true">' -Replace '<CcyNm>') |
        % {
            $c,$n = $_.Node.Ccy.Substring(0,2),($_.Node.Ccy + ' ' + $_.Node.CcyNm)
            if($Script:currency.ContainsKey($c)) {$Script:currency[$c] += $n}
            else {[void]$Script:currency.Add($c,@($n))}
        }
    if(!$Script:currency.Count) {throw 'No currency codes read.'}
    Write-Verbose "Read $($Script:currency.Count) currency codes"
    $langfile = 'data\iso639.xml'
    if(!(Test-Path $langfile -PathType Leaf) -or (Get-Item $langfile).LastWriteTime -lt [datetime]::Today.AddDays(-$MaxAgeInDays))
    {
        [Collections.Generic.HashSet[string]]$knowncode = @()
        Import-Html.ps1 $LanguageCodesUrl |
            ? {!$knowncode.Contains($_.Code)} |
            % {
                $code,$item = $_.Code,"$($icon.language) $($_.Code) $($_.Name -replace '\s+\([^\x29]+\)','')"
                [void]$knowncode.Add($code)
                $code.ToUpper() -split '-' |% {
                    if($Script:lang.ContainsKey($_)) {$Script:lang[$_] += $item}
                    else {$Script:lang.Add($_,@($item))}
                }
            }
        Export-Clixml $langfile -InputObject $Script:lang
    }
    else {$Script:lang = Import-Clixml $langfile}
    Write-Verbose "Read $($Script:lang.Count) language code parts"
}

function Get-CodeIndicator([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{
    if($Script:iso.ContainsKey($code))
    {
        if($Script:fips.ContainsKey($code)) {if($Script:iso[$code] -ne $Script:fips[$code]) {$icon.mismatch}}
        else {$icon.iso_only}
    }
    elseif(!$Script:fips.ContainsKey($code)) {$icon.subregion_only}
    else {$icon.fips_only}
}

$count = @{
    matched    = 0
    mismatched = 0
    iso_only   = 0
    fips_only  = 0
    other_only = 0
}
$forcematch = @('CG','FK','FM','HM','HR','VC','WF')
function Get-CodeDetails([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{Process{
    if($Script:iso.ContainsKey($code))
    {
        $flag = '&#x{0:X};&#x{1:X}; ' -f (0x1F1A5+[int]$code[0]),(0x1F1A5+[int]$code[1])
        if(!$Script:fips.ContainsKey($code)) {$flag + $Script:iso[$code] + ' (ISO)';[void]$count.iso_only++}
        else
        {
            if($Script:iso[$code] -eq $Script:fips[$code] -or $code -in $forcematch)
            {
                $flag + $Script:iso[$code]
                [void]$count.matched++
            }
            else
            {
                $flag + $Script:iso[$code] + ' (ISO)'
                $Script:fips[$code] + ' (FIPS)'
                Write-Verbose "${code}: $($Script:iso[$code]) != $($Script:fips[$code])"
                [void]$count.mismatched++
            }
        }
        if($Script:currency.ContainsKey($code)) {$Script:currency[$code]}
    }
    elseif($Script:fips.ContainsKey($code)) {$Script:fips[$code] + ' (FIPS)';[void]$count.fips_only++}
    elseif($Script:subregion.ContainsKey($code) -or $Script:lang.ContainsKey($code)) {[void]$count.other_only++}
    if($Script:subregion.ContainsKey($code)) {$Script:subregion[$code]}
    if($Script:lang.ContainsKey($code)) {$Script:lang[$code]}
}}

function Format-HtmlTableCell([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{Process{
    [string[]]$details = Get-CodeDetails $code
    if(!$details) {"<td>&cir; $code"}
    else {@"
<td><details><summary>$code $(Get-CodeIndicator $code)</summary><ul>
$($details |% {"<li>$([Net.WebUtility]::HtmlEncode($_) -replace '&amp;(#?\w+;)','&$1')</li>"})
</ul></details></td>
"@}}}

function Format-HtmlTableRow([Parameter(ValueFromPipeline=$true)][char]$letter)
{Process{"<tr>$(0x41..0x5A |% {"$letter$([char]$_)"} |Format-HtmlTableCell)</tr>"}}

function Format-Markdown
{@"
<html><head><title>Two Letter ISO/FIPS/NUTS Country Codes with Currency, Language, and Subregion Codes</title>
<link rel="stylesheet" href="http://webcoder.info/assets/css/style.css">
<style>div.container {margin:0 !important} td {vertical-align:top}</style>
</head><body>

<table style="white-space:nowrap;font-size:9pt">
<caption><h1>ISO/FIPS/NUTS Country Codes with Currency, Language, and Subregion Codes</h1></caption><tbody>
$(0x41..0x5A |% {[char]$_} |Format-HtmlTableRow)
</tbody><tfoot><tr>
<td colspan="20" style="vertical-align:top"><h2>Legend</h2><ul>
<li>$($icon.mismatch) ISO and FIPS codes do not agree, though the code is valid in both</li>
<li>$($icon.iso_only) ISO defines this code, but it is an invalid FIPS code</li>
<li>$($icon.fips_only) FIPS defines this code, but it is an invalid ISO code</li>
<li>$($icon.subregion_only) neither ISO nor FIPS define this as a country code,
    though it is a valid subregion (state/province/&c) ISO code</li>
<li>$($icon.not_a_code) not a valid country in either standard or ISO subregion code</li>
</ul></td><td colspan="6" style="vertical-align:top"><h2>Totals</h2><ul>
<li>&equiv; $($count.matched) matched codes</li>
<li>$($icon.mismatch) $($count.mismatched) mismatched codes</li>
<li>$($icon.iso_only) $($count.iso_only) ISO-only codes</li>
<li>$($icon.iso_only) $($Script:iso.Count) ISO codes total</li>
<li>$($icon.fips_only) $($count.fips_only) FIPS-only codes</li>
<li>$($icon.fips_only) $($Script:fips.Count) FIPS codes total</li>
<li>$($icon.subregion_only) $($count.other_only) other codes only</li>
<li>$($icon.subregion_only) $($Script:subregion.Count) subregion codes total</li>
</ul></td></tr></tfoot></table>

<section class="container">

<p>This table summarizes <a href="https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Decoding_table"><dfn
title="International Organization for Standardization Codes for the representation of names of countries and their subdivisions"
>ISO 3166-1 alpha-2</dfn></a>
and <a href="https://en.wikipedia.org/wiki/FIPS_10-4"><dfn
title="Federal Information Processing Standards for Countries, Dependencies, Areas of Special Sovereignty, and Their Principal Administrative Divisions"
>FIPS PUB 10-4</dfn></a> country codes, with some attention to where they differ. It also annotates the two countries
(<abbr title="United Kingdom">&#x1F1EC;&#x1F1E7;</abbr> & <abbr title="Greece">&#x1F1EC;&#x1F1F7;</abbr>) whose codes
differ between the ISO standard and the <a href="https://en.wikipedia.org/wiki/Nomenclature_of_Territorial_Units_for_Statistics"><dfn
title="Nomenclature of Territorial Units for Statistics">NUTS</dfn></a>.</p>

<p>It includes <a href="https://en.wikipedia.org/wiki/ISO4217"><dfn
title="International Organization for Standardization Current currency & funds code list"
>ISO 4217 alpha-3</dfn></a> currency codes that start with
the ISO 3166-1 alpha-2 code of each currency's country, as well as the
<a href="https://en.wikipedia.org/wiki/ISO_639-1"><dfn
title="International Organization for Standardization Codes for the representation of names of languages"
>ISO 639-1</dfn></a> language codes ending with the ISO 3166-1 alpha-2
codes for the country they apply to (as well as any coincidental match between country and language code).</p>

<p>It also annotates two-letter <a href="https://en.wikipedia.org/wiki/ISO_3166-2"><dfn
title="International Organization for Standardization Country subdivision code">ISO 3166-2</dfn></a> subregion codes
that overlap with country codes.</p>

</section></html>
"@}

Read-Codes
Format-Markdown |Out-File countries.html utf8

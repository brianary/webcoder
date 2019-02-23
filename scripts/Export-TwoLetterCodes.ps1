<#
.Synopsis
    Builds an HTML table of two-letter codes.

.Link
    https://www.iso.org/iso-3166-country-codes.html

.Link
    https://github.com/esosedi/3166
#>

#Requires -Version 3
[CmdletBinding()] Param(
[uri] $CountryCodesUrl = 'https://raw.githubusercontent.com/esosedi/3166/master/data/iso3166-2.json'
)

$Script:iso,$Script:fips,$Script:subregion = @{},@{},@{}
function Read-Codes
{
    $json = 'data\iso3166-2.json'
    if(!(Test-Path $json -PathType Leaf) -or (Get-Item $json).LastWriteTime -lt [datetime]::Today.AddDays(-100))
    {
        if(!($json |Split-Path |Test-Path -PathType Container)) {mkdir data |Out-Null}
        Invoke-WebRequest $CountryCodesUrl -OutFile $json
    }
    Write-Verbose "Reading $json"
    $isodata = Get-Content $json -Encoding utf8 |? {$_ -notlike '*"":*'} |ConvertFrom-Json
    [string[]]$codes = $isodata |Get-Member -MemberType NoteProperty |% Name
    Write-Verbose "Read $($codes.Length) codes"
    $i,$max = 0,($codes.Length/100)
    foreach($entry in ($codes |% {$isodata.$_}))
    {
        Write-Progress "Reading $json" $entry.names.en -CurrentOperation $entry.iso -PercentComplete ($i++/$max)
        $flag = '&#x{0:X};&#x{1:X};' -f (0x1F1A5+[int]$entry.iso[0]),(0x1F1A5+[int]$entry.iso[1])
        $name = $flag + ' ' + $entry.names.en
        [void]$Script:iso.Add($entry.iso,$name)
        if($entry.fips)
        {
            [void]$Script:fips.Add($entry.fips,$name)
        }
        if($entry.regions -and $entry.regions[0].iso -like '[A-Z][A-Z]')
        {
            foreach($region in $entry.regions)
            {
                $name = $entry.iso + '-' + $region.iso + ' ' + $region.names.en
                if($Script:subregion.ContainsKey($region.iso)) {$Script:subregion[$region.iso] += $name}
                else {[void]$Script:subregion.Add($region.iso,@($name))}
            }
        }
    }
    Write-Progress "Reading $json" -Completed
    if(!$Script:iso.Count) {throw "No codes read."}
    Write-Verbose "Read $($Script:iso.Count) ISO and $($Script:fips.Count) FIPS codes"
}

$icon = @{
    mismatch       = '&#x26A0;'           # WARNING SIGN
    iso_only       = '&#x1F310;'          # GLOBE WITH MERIDIANS
    fips_only      = '&#x1F1FA;&#x1F1F8;' # REGIONAL INDICATOR SYMBOL LETTER U + S
    subregion_only = '&#x1F6C8;'          # CIRCLED INFORMATION SOURCE
    not_a_code     = '&cir;'              # WHITE CIRCLE
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

$Script:matched,$Script:mismatched,$Script:iso_only,$Script:fips_only,$Script:subregion_only = 0,0,0,0,0
function Get-CodeDetails([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{Process{
    if($Script:iso.ContainsKey($code))
    {
        if(!$Script:fips.ContainsKey($code))
        {
            $Script:iso[$code] + ' (ISO)'
            [void]$Script:iso_only++
        }
        else
        {
            if($Script:iso[$code] -eq $Script:fips[$code])
            {
                $Script:iso[$code]
                [void]$Script:matched++
            }
            else
            {
                $Script:iso[$code] + ' (ISO)'
                $Script:fips[$code] + ' (FIPS)'
                [void]$Script:mismatched++
            }
        }
    }
    elseif($Script:fips.ContainsKey($code))
    {
        $Script:fips[$code] + ' (FIPS)'
        [void]$Script:fips_only++
    }
    elseif($Script:subregion.ContainsKey($code))
    {
        [void]$Script:subregion_only++
    }
    if($Script:subregion.ContainsKey($code))
    {
        $Script:subregion[$code]
    }
}}

function Format-HtmlTableCell([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{Process{
    [string[]]$details = Get-CodeDetails $code
    if(!$details) {"<td>&cir; $code"}
    else {@"
<td><details><summary>$code $(Get-CodeIndicator $code)</summary><ul>
$($details |% {"<li>$([Net.WebUtility]::HtmlEncode($_) -replace '&amp;(#?\w+;)','&$1')</li>"})
</ul></details></td>
"@
}}}

function Format-HtmlTableRow([Parameter(ValueFromPipeline=$true)][char]$letter)
{Process{"<tr>$(0x41..0x5A |% {"$letter$([char]$_)"} |Format-HtmlTableCell)</tr>"}}

function Format-Markdown
{@"
Two Letter Country Codes
========================

This summarizes [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Decoding_table)
and [FIPS PUB 10-4](https://en.wikipedia.org/wiki/FIPS_10-4) country codes,
with some attention to where they differ.

It also annotates [ISO 3166-2 subregion codes](https://en.wikipedia.org/wiki/ISO_3166-2)
that overlap with country codes.

<table style="white-space:nowrap;font-size:9pt">
<caption>ISO/FIPS Country Codes</caption><tbody>
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
<li>&equiv; $matched matched codes</li>
<li>$($icon.mismatch) $mismatched mismatched codes</li>
<li>$($icon.iso_only) $iso_only ISO-only codes</li>
<li>$($icon.iso_only) $($Script:iso.Count) ISO codes total</li>
<li>$($icon.fips_only) $fips_only FIPS-only codes</li>
<li>$($icon.fips_only) $($Script:fips.Count) FIPS codes total</li>
<li>$($icon.subregion_only) $subregion_only subregion-only codes</li>
<li>$($icon.subregion_only) $($Script:subregion.Count) subregion codes total</li>
</ul></td></tr></tfoot></table>

<style>div.container {margin:0 !important}</style>
"@}

Read-Codes
Format-Markdown |Out-File countries.md utf8

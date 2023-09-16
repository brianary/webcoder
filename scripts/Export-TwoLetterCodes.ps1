<#
.SYNOPSIS
Builds an HTML table of two-letter codes.

.LINK
https://en.wikipedia.org/wiki/Country_code

.LINK
https://en.wikipedia.org/wiki/Comparison_of_alphabetic_country_codes

.LINK
https://en.wikipedia.org/wiki/FIPS_10-4

.LINK
https://en.wikipedia.org/wiki/Nomenclature_of_Territorial_Units_for_Statistics

.LINK
https://www.iso.org/iso-3166-country-codes.html

.LINK
https://nsgreg.nga.mil/genc/

.LINK
https://irs.gov/countrycodes

.LINK
https://en.wikipedia.org/wiki/ISO4217

.LINK
https://github.com/olahol/iso-3166-2.json

.LINK
https://github.com/datasets/fips-10-4

.LINK
https://github.com/datasets/currency-codes

.LINK
https://github.com/datasets/language-codes
#>

#Requires -Version 7
#Requires -Modules SelectHtml
[CmdletBinding()] Param(
[uri] $IrsCountryCodesUrl = 'https://irs.gov/countrycodes',
[uri] $GencCountryCodesUrl = 'https://nsgreg.nga.mil/registries/browseQuery?registryType=genc&browseType=&registerField=IE4&itemTypeField=ggp&correlationTypeField=all&filterField=char2Code&showField=all&entryTypeField=active&statusField=valid&dayField=16&monthField=9&yearField=2023&tzOffset=420&draw=1&columns%5B0%5D%5Bdata%5D=char2Code&columns%5B0%5D%5Bname%5D=&columns%5B0%5D%5Bsearchable%5D=true&columns%5B0%5D%5Borderable%5D=true&columns%5B0%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B0%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B1%5D%5Bdata%5D=char3Code&columns%5B1%5D%5Bname%5D=&columns%5B1%5D%5Bsearchable%5D=true&columns%5B1%5D%5Borderable%5D=true&columns%5B1%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B1%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B2%5D%5Bdata%5D=numeric3Code&columns%5B2%5D%5Bname%5D=&columns%5B2%5D%5Bsearchable%5D=true&columns%5B2%5D%5Borderable%5D=true&columns%5B2%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B2%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B3%5D%5Bdata%5D=plainName&columns%5B3%5D%5Bname%5D=&columns%5B3%5D%5Bsearchable%5D=true&columns%5B3%5D%5Borderable%5D=true&columns%5B3%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B3%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B4%5D%5Bdata%5D=usRecognition&columns%5B4%5D%5Bname%5D=&columns%5B4%5D%5Bsearchable%5D=true&columns%5B4%5D%5Borderable%5D=true&columns%5B4%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B4%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B5%5D%5Bdata%5D=gencStatus&columns%5B5%5D%5Bname%5D=&columns%5B5%5D%5Bsearchable%5D=true&columns%5B5%5D%5Borderable%5D=true&columns%5B5%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B5%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B6%5D%5Bdata%5D=entryStatus&columns%5B6%5D%5Bname%5D=&columns%5B6%5D%5Bsearchable%5D=true&columns%5B6%5D%5Borderable%5D=true&columns%5B6%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B6%5D%5Bsearch%5D%5Bregex%5D=false&order%5B0%5D%5Bcolumn%5D=3&order%5B0%5D%5Bdir%5D=asc&start=0&length=500&search%5Bvalue%5D=&search%5Bregex%5D=false&_=1694898352438',
[uri] $FipsCountryCodesUrl = 'https://raw.githubusercontent.com/datasets/fips-10-4/master/data/data.csv',
[uri] $IsoCountryCodesUrl = 'https://restcountries.com/v3.1/all',
[uri] $CurrencyCodesUrl = 'https://raw.githubusercontent.com/datasets/currency-codes/master/data/codes-all.csv',
[uri] $LanguageCodesUrl = 'https://raw.githubusercontent.com/datasets/language-codes/master/data/language-codes.csv'
)

function Save-Data([Parameter(Mandatory=$true)][uri]$Url,[string]$Filename,[int]$MaxAgeInDays=100,[string]$Search,[string]$Replace)
{
    $path = !$Filename ? $Url.Segments[-1] : $Filename
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
    us_only        = '&#x1F1FA;&#x1F1F8;' # REGIONAL INDICATOR SYMBOL LETTER U + S
    not_a_code     = '&cir;'              # WHITE CIRCLE
    language       = '&#x1F4AC;'          # SPEECH BALLOON
}
$Script:us,$Script:fips,$Script:gec,$Script:irs,$Script:genc,$Script:iso,$Script:currency,$Script:lang = @{},@{},@{},@{},@{},@{},@{},@{}

function Read-FipsCountries
{
    $regionfile = Save-Data $FipsCountryCodesUrl fips-10-4.csv
    $countryfile = 'fips-countries.csv'
    if(!(Test-Path $countryfile -Type Leaf) -or ((Get-Item $regionfile).LastWriteTime -gt (Get-Item $countryfile).LastWriteTime))
    {
        Import-Csv $regionfile |
            Where-Object region_division -eq 'country' |
            ForEach-Object {[pscustomobject]@{CountryCode=$_.region_code.Substring(0,2);CountryName=$_.region_name}} |
            Sort-Object CountryCode |
            Export-Csv $countryfile -UseQuotes AsNeeded

    }
    Import-Csv $countryfile |
        ForEach-Object {$Script:fips[$_.CountryCode] = $_.CountryName; $us[$_.CountryCode] = $_.CountryName + ' (FIPS)'}
    if(!$Script:fips.Count) {throw 'No FIPS codes read.'}
    Write-Info.ps1 "Read $($Script:fips.Count) FIPS codes" -fg Green
}

function Read-GecCountries
{
    Import-Csv gec-countries.csv |ForEach-Object {$gec[$_.CountryCode] = $_.CountryName; $us[$_.CountryCode] = $_.CountryName + ' (GEC)'}
    if(!$Script:gec.Count) {throw 'No GEC country codes read.'}
    Write-Info.ps1 "Read $($Script:gec.Count) GEC country codes" -fg Green
}

function Read-IrsCountries
{
    $irshtml = "$(Save-Data $IrsCountryCodesUrl irs-countries.html |Resolve-Path)"
    $irsfile = 'irs-countries.csv'
    if(!(Test-Path $irsfile -Type Leaf) -or ((Get-Item $irshtml).LastWriteTime -gt (Get-Item $irsfile).LastWriteTime))
    {
        Select-Html //table -Path $irshtml |
            Sort-Object CountryCode |
            ForEach-Object {[pscustomobject]@{
                CountryCode = $_.CountryCode
                CountryName = $_.CountryName -replace '&amp;','&'
            }} |
            Export-Csv $irsfile -UseQuotes AsNeeded
    }
    Import-Csv $irsfile |ForEach-Object {$irs[$_.CountryCode] = $_.CountryName; $us[$_.CountryCode] = $_.CountryName + ' (IRS MeF)'}
    if(!$Script:irs.Count) {throw 'No IRS country codes read.'}
    Write-Info.ps1 "Read $($Script:irs.Count) IRS country codes" -fg Green
}

function Read-GencCountries
{
    $gencraw = "$(Save-Data $GencCountryCodesUrl genc.json |Resolve-Path)"
    $gencfile = 'genc-countries.csv'
    if(!(Test-Path $gencfile -Type Leaf) -or ((Get-Item $gencraw).LastWriteTime -gt (Get-Item $gencfile).LastWriteTime))
    {
        Get-Content $gencraw |
            ConvertFrom-Json |
            Select-Object -ExpandProperty data |
            Where-Object {![string]::IsNullOrWhiteSpace($_.char2Code)} |
            Sort-Object char2Code |
            ForEach-Object {[pscustomobject]@{
                CountryCode = $_.char2Code
                CountryName = $_.plainName
            }} |
            Export-Csv $gencfile -UseQuotes AsNeeded
    }
    Import-Csv $gencfile |ForEach-Object {$genc[$_.CountryCode] = $_.CountryName}
    if(!$Script:genc.Count) {throw 'No GENC country codes read.'}
    Write-Info.ps1 "Read $($Script:genc.Count) GENC country codes" -fg Green
}

function Read-IsoCountries
{
    $isoraw = "$(Save-Data $IsoCountryCodesUrl iso3166-1.json |Resolve-Path)"
    $isofile = 'iso3166-1a2.csv'
    if(!(Test-Path $isofile -Type Leaf) -or ((Get-Item $isoraw).LastWriteTime -gt (Get-Item $isofile).LastWriteTime))
    {
        Get-Content $isoraw -Encoding utf8 |
            ConvertFrom-Json |
            Where-Object {$_.status -eq 'officially-assigned'} |
            Sort-Object cca2 |
            ForEach-Object {[pscustomobject]@{CountryCode=$_.cca2;CountryName=$_.name.official}} |
            Export-Csv $isofile -UseQuotes AsNeeded

    }
    Import-Csv $isofile |
        ForEach-Object {[void]$Script:iso.Add($_.CountryCode, $_.CountryName)}
    if(!$Script:iso.Count) {throw 'No ISO country codes read.'}
    Write-Info.ps1 "Read $($Script:iso.Count) ISO country codes" -fg Green
}

function Read-IsoCurrencies
{
    Import-Csv (Save-Data $CurrencyCodesUrl iso4217.csv) |
        Where-Object {![string]::IsNullOrWhiteSpace($_.AlphabeticCode)} |
        ForEach-Object {
            $c,$n = $_.AlphabeticCode.Substring(0,2),"$($_.AlphabeticCode) $($_.Currency) ($($_.Entity))"
            if($Script:currency.ContainsKey($c)) {$Script:currency[$c] += $n}
            else {[void]$Script:currency.Add($c,@($n))}
        }
    if(!$Script:currency.Count) {throw 'No currency codes read.'}
    Write-Info.ps1 "Read $($Script:currency.Count) currency codes" -fg Green
}

function Read-IsoLanguages
{
    Import-Csv (Save-Data $LanguageCodesUrl language-codes.csv) |
        ForEach-Object {$Script:lang[$_.alpha2] = "$($icon.language) $($_.alpha2) $($_.English)"}
    Write-Info.ps1 "Read $($Script:lang.Count) language codes" -fg Green
}

function Get-CodeIndicator([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{
    if($Script:iso.ContainsKey($code))
    {
        if($Script:fips.ContainsKey($code)) {if($Script:iso[$code] -ne $Script:irs[$code]) {$icon.mismatch}}
        else {$icon.iso_only}
    }
    elseif($Script:us.ContainsKey($code)) {$icon.us_only}
}

Set-Variable flagAMinusA 0x1F1A5 -Option Constant
$count = @{
    matched    = 0
    mismatched = 0
    iso_only   = 0
    us_only  = 0
    other_only = 0
}
$forcematch = @('CG','FK','FM','HM','HR','VC','WF')
filter Get-CodeDetails([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{
    if($Script:iso.ContainsKey($code))
    {
        $flag = '&#x{0:X};&#x{1:X}; ' -f ($flagAMinusA+[int]$code[0]),($flagAMinusA+[int]$code[1])
        if(!$Script:us.ContainsKey($code)) {$flag + $Script:iso[$code] + ' (ISO)';[void]$count.iso_only++}
        else
        {
            $uscountry =
                if($Script:irs.ContainsKey($code)) {$Script:irs[$code]}
                elseif($Script:gec.ContainsKey($code)) {$Script:gec[$code]}
                elseif($Script:fips.ContainsKey($code)) {$Script:fips[$code]}
                else {$null}
            if($Script:iso[$code] -eq $uscountry -or $code -in $forcematch)
            {
                $flag + $Script:iso[$code]
                [void]$count.matched++
            }
            else
            {
                $flag + $Script:iso[$code] + ' (ISO)'
                $Script:us[$code]
                Write-Verbose "${code}: $($Script:iso[$code]) != $($Script:fips[$code])"
                [void]$count.mismatched++
            }
        }
        if($Script:currency.ContainsKey($code)) {$Script:currency[$code]}
    }
    elseif($Script:us.ContainsKey($code)) {$Script:us[$code];[void]$count.us_only++}
    if($Script:lang.ContainsKey($code)) {$Script:lang[$code]}
}

filter Format-HtmlTableCell([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{
    [string[]]$details = Get-CodeDetails $code
    if(!$details) {"<td>&cir; $code"}
    else {@"
<td><details><summary>$code $(Get-CodeIndicator $code)</summary><ul>
$($details |ForEach-Object {"<li>$([Net.WebUtility]::HtmlEncode($_) -replace '&amp;(#?\w+;)','&$1')</li>"})
</ul></details></td>
"@}}

filter Format-HtmlTableRow([Parameter(ValueFromPipeline=$true)][char]$letter)
{"<tr>$(0x41..0x5A |ForEach-Object {"$letter$([char]$_)"} |Format-HtmlTableCell)</tr>"}

function Format-HtmlCountries
{@"
<html><head><title>Two Letter ISO/FIPS/NUTS Country Codes with Currency, Language, and Subregion Codes</title>
<link rel="stylesheet" href="http://webcoder.info/assets/css/style.css">
<style>body {background: #FFF} div.container {margin:0 !important} td {vertical-align:top}</style>
</head><body>

<table style="white-space:nowrap;font-size:9pt">
<caption><h1>ISO/FIPS/NUTS Country Codes with Currency, Language, and Subregion Codes</h1></caption><tbody>
$(0x41..0x5A |ForEach-Object {[char]$_} |Format-HtmlTableRow)
</tbody><tfoot><tr>
<td colspan="20" style="vertical-align:top"><h2>Legend</h2><ul>
<li>$($icon.mismatch) International and US codes do not agree, though the code is valid in both</li>
<li>$($icon.iso_only) International code only</li>
<li>$($icon.us_only) US code only</li>
<li>$($icon.not_a_code) not a valid country in either standard or ISO subregion code</li>
</ul></td><td colspan="6" style="vertical-align:top"><h2>Totals</h2><ul>
<li>&equiv; $($count.matched) matched codes</li>
<li>$($icon.mismatch) $($count.mismatched) mismatched codes</li>
<li>$($icon.iso_only) $($count.iso_only) ISO-only codes</li>
<li>$($icon.iso_only) $($Script:iso.Count) ISO codes total</li>
<li>$($icon.us_only) $($count.us_only) FIPS-only codes</li>
<li>$($icon.us_only) $($Script:fips.Count) FIPS codes total</li>
</ul></td></tr></tfoot></table>

<section class="container">

<div><img src="int-country-codes-timeline.svg" alt="🌐 International Country Codes Timeline" style="max-width:100%" /></div>

<div><img src="us-country-codes-timeline.svg" alt="🇺🇸 US Country Codes Timeline" style="max-width:100%" /></div>

</section></html>
"@}

if(!(Test-Path data -Type Container)) {New-Item data -Type Directory |Out-Null}
Split-Path $PSScriptRoot |Join-Path -ChildPath data |Push-Location
try
{
    Read-FipsCountries
    Read-IrsCountries
    Read-GencCountries
    Read-IsoCountries
    Read-IsoCurrencies
    Read-IsoLanguages
}
finally
{
    Pop-Location
}
Format-HtmlCountries |Out-File countries.html utf8

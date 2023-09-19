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

function Initialize-ReadHashes
{
    Set-Variable code @{
        us       = @{}
        fips     = @{}
        gec      = @{}
        irs      = @{}
        genc     = @{}
        iso      = @{}
        isoshort = @{}
        currency = @{}
        lang     = @{}
    } -Scope Script -Option Constant
    Set-Variable name @{
        us   = @{
            'Curaçao' = 'UC'
            'DR Congo' = 'CG'
            'Falkland Islands' = 'FK'
            'Gambia' = 'GA'
            'Isle of Man' = 'IM'
            'Ivory Coast' = 'IV'
            'Myanmar' = 'BM'
            'North Korea' = 'KN'
            'North Macedonia' = 'MK'
            'Papua New Guinea' = 'PP'
            'Republic of the Congo' = 'CF'
            'Saint Helena, Ascension and Tristan da Cunha' = 'SH'
            'São Tomé and Príncipe' = 'TP'
            'South Korea' = 'KS'
            'United Kingdom' = 'UK'
            'Vatican City' = 'VT'
            'Yemen' = 'YM'
        }
        genc = @{}
        iso  = @{
            'Congo (Brazzaville)' = 'CG'
            'Congo (Kinshasa)' = 'CD'
            'Cote D''Ivoire (Ivory Coast)' = 'CI'
            'Falkland Islands (Islas Malvinas)' = 'FK'
            'Holy See' = 'VA'
            'Korea, Democratic People''s Republic of (North)' = 'KP'
            'Korea, Republic of (South)' = 'KR'
            'Macedonia' = 'MK'
            'Man, Isle of' = 'IM'
            'Papua-New Guinea' = 'PG'
            'Sao Tome and Principe' = 'ST'
            'St. Helena' = 'SH'
            'The Gambia' = 'GM'
            'United Kingdom (England, Northern Ireland, Scotland, and Wales)' = 'GB'
            'Yemen (Aden)' = 'YE'
        }
    } -Scope Script -Option Constant
}

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
        ForEach-Object {
            $code.fips[$_.CountryCode] = $_.CountryName
            $code.us[$_.CountryCode] = $_.CountryName + ' (FIPS)'
            $name.us[$_.CountryName] = $_.CountryCode
            if($_.CountryName -match '\bSt\b') {$name.us[$_.CountryName -replace '\bSt\b\.?','Saint'] = $_.CountryCode}
        }
    if(!$code.fips.Count) {throw 'No FIPS country codes read.'}
    Write-Info.ps1 "Read $($code.fips.Count) FIPS country codes" -fg Green
}

function Read-GecCountries
{
    Import-Csv gec-countries.csv |
        ForEach-Object {
            $code.gec[$_.CountryCode] = $_.CountryName
            $code.us[$_.CountryCode] = $_.CountryName + ' (GEC)'
            $name.us[$_.CountryName] = $_.CountryCode
            if($_.CountryName -match '\bSt\b') {$name.us[$_.CountryName -replace '\bSt\b\.?','Saint'] = $_.CountryCode}
        }
    if(!$code.gec.Count) {throw 'No GEC country codes read.'}
    Write-Info.ps1 "Read $($code.gec.Count) GEC country codes" -fg Green
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
    Import-Csv $irsfile |
        ForEach-Object {
            $code.irs[$_.CountryCode] = $_.CountryName
            $code.us[$_.CountryCode] = $_.CountryName + ' (IRS MeF)'
            $name.us[$_.CountryName] = $_.CountryCode
            if($_.CountryName -match '\bSt\b') {$name.us[$_.CountryName -replace '\bSt\b\.?','Saint'] = $_.CountryCode}
        }
    if(!$code.irs.Count) {throw 'No IRS country codes read.'}
    Write-Info.ps1 "Read $($code.irs.Count) IRS country codes" -fg Green
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
    Import-Csv $gencfile |
        ForEach-Object {
            $code.genc[$_.CountryCode] = $_.CountryName
            $name.genc[$_.CountryName] = $_.CountryCode
        }
    if(!$code.genc.Count) {throw 'No GENC country codes read.'}
    Write-Info.ps1 "Read $($code.genc.Count) GENC country codes" -fg Green
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
            ForEach-Object {[pscustomobject]@{
                CountryCode  = $_.cca2
                CountryName  = $_.name.common
                OfficialName = $_.name.official
                AltNames     = $_.altSpellings -join '|'
            }} |
            Export-Csv $isofile -UseQuotes AsNeeded

    }
    Import-Csv $isofile |
        ForEach-Object {
            $cc = $_.CountryCode
            $code.iso[$cc] = $_.OfficialName
            $code.isoshort[$cc] = $_.CountryName
            $name.iso[$_.CountryName] = $cc
            $name.iso[$_.OfficialName] = $cc
            if($_.CountryName -match '\bSaint\b') {$name.iso[$_.CountryName -replace '\bSaint\b','St.'] = $cc}
            if($_.CountryName -like '* and *') {$name.iso[$_.CountryName -replace ' and ',' & '] = $cc}
            $_.AltNames -split '\|' |ForEach-Object {$name.iso[$_] = $cc}
        }
    if(!$code.iso.Count) {throw 'No ISO country codes read.'}
    Write-Info.ps1 "Read $($code.iso.Count) ISO country codes" -fg Green
}

function Read-IsoCurrencies
{
    Import-Csv (Save-Data $CurrencyCodesUrl iso4217.csv) |
        Where-Object {![string]::IsNullOrWhiteSpace($_.AlphabeticCode)} |
        ForEach-Object {
            $c,$n = $_.AlphabeticCode.Substring(0,2),"$($_.AlphabeticCode) $($_.Currency) ($($_.Entity))"
            if($code.currency.ContainsKey($c)) {$code.currency[$c] += $n}
            else {[void]$code.currency.Add($c,@($n))}
        }
    if(!$code.currency.Count) {throw 'No currency codes read.'}
    Write-Info.ps1 "Read $($code.currency.Count) currency codes" -fg Green
}

function Read-IsoLanguages
{
    Import-Csv (Save-Data $LanguageCodesUrl language-codes.csv) |
        ForEach-Object {$code.lang[$_.alpha2] = "$($_.alpha2) $($_.English)"}
    Write-Info.ps1 "Read $($code.lang.Count) language codes" -fg Green
}

function Initialize-Export
{
    Set-Variable icon @{
        mismatch       = '&#x26A0;&#xFE0F;'   # WARNING SIGN
        iso_only       = '&#x1F310;'          # GLOBE WITH MERIDIANS
        us_only        = '&#x1F1FA;&#x1F1F8;' # REGIONAL INDICATOR SYMBOL LETTER U + S
        not_a_code     = '&cir;'              # WHITE CIRCLE
        language       = '&#x1F4AC;'          # SPEECH BALLOON
    } -Scope Script -Option Constant
    Set-Variable flagAMinusA 0x1F1A5 -Scope Script -Option Constant
    Set-Variable count @{
        matched    = 0
        mismatched = 0
        iso_only   = 0
        us_only    = 0
        other_only = 0
    } -Scope Script -Option Constant
    Set-Variable us2iso @{
        AT = '(AU)'
        AX = '(GB)'
        BQ = '(US)'
        BS = '(FR)'
        CR = '(AU)'
        DQ = '(US)'
        DX = '(GB)'
        EU = '(FR)'
        FQ = '(US)'
        GO = '(FR)'
        GZ = '(PS)'
        HQ = '(US)'
        IP = '(FR)'
        JN = '(NO)'
        JQ = '(US)'
        JU = '(FR)'
        KQ = '(US)'
        KV = '(XK)'
        LQ = '(US)'
        MQ = '(US)'
        NT = '(NL)'
        PF = '(CN)'
        PG = '(CN)'
        PJ = '(RU)'
        ST = '(GB)'
        SV = '(NO)'
        TB = '(FR)'
        TE = '(FR)'
        WE = '(PS)'
        WQ = '(US)'
    } -Scope Script -Option Constant
    Set-Variable iso2us @{
        AX = '(FI)'
        BL = '(FR)'
        BQ = '(NL)'
        PS = '(GZ/WE)'
        RE = '(FR)'
        SJ = '(JN/SV)'
        UM = '(US)'
        VI = '(US)'
    } -Scope Script -Option Constant
    Set-Variable info @{
        AX = ' <a href="https://en.wikipedia.org/wiki/%C3%85land_Islands_dispute">ℹ️</a>'
        MM = ' <a href="https://en.wikipedia.org/wiki/Names_of_Myanmar">ℹ️</a>'
        PS = ' <a href="https://en.wikipedia.org/wiki/State_of_Palestine">ℹ️</a>'
        UM = ' <a href="https://en.wikipedia.org/wiki/United_States_Minor_Outlying_Islands">ℹ️</a>'
    } -Scope Script -Option Constant
    Set-Variable matched (New-Object Collections.ArrayList) -Scope Script -Option Constant
    Set-Variable convert (New-Object Collections.ArrayList) -Scope Script -Option Constant
}

function Test-Mismatch([Parameter(Position=0,Mandatory=$true)][ValidateNotNullOrEmpty()][string]$value)
{
    if($value -in 'IM','FK','MK','SH','SZ','VC') {return $false}
    $uscountry =
        if($code.irs.ContainsKey($value)) {$code.irs[$value]}
        elseif($code.gec.ContainsKey($value)) {$code.gec[$value]}
        elseif($code.fips.ContainsKey($value)) {$code.fips[$value]}
        else {$code.us[$value]}
    return $uscountry -inotin $code.iso[$value],$code.isoshort[$value]
}

function Get-IsoConversion([Parameter(Position=0,Mandatory=$true)][ValidateNotNullOrEmpty()][string]$value)
{
    $country,$short,$uscode = $code.iso[$value],$code.isoshort[$value],''
    if($name.us.ContainsKey($country)) {$uscode = $name.us[$country]}
    elseif($name.us.ContainsKey($short)) {$uscode = $name.us[$short]}
    else {return [pscustomobject]@{OfficialName=$country; CommonName=$short; UsName=''; UsCode=$iso2us[$value] ?? '??'; IsoCode=$value}}
    return [pscustomobject]@{OfficialName=$country; CommonName=$short; UsName=$code.us[$uscode]; UsCode=$uscode; IsoCode=$value}
}

function Get-UsConversion([Parameter(Position=0,Mandatory=$true)][ValidateNotNullOrEmpty()][string]$value)
{
    $uscountry =
        if($code.irs.ContainsKey($value)) {$code.irs[$value]}
        elseif($code.gec.ContainsKey($value)) {$code.gec[$value]}
        elseif($code.fips.ContainsKey($value)) {$code.fips[$value]}
        else {$code.us[$value]}
    if($name.iso.ContainsKey($uscountry)) {return}
    else {return [pscustomobject]@{OfficialName=''; CommonName=''; UsName=$code.us[$value]; UsCode=$value; IsoCode=$us2iso[$value] ?? '??'}}
}

function Get-CodeIndicator([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$value)
{
    if($code.iso.ContainsKey($value))
    {
        if($code.us.ContainsKey($value))
        {
            if(Test-Mismatch $value) {$icon.mismatch}
        }
        else {$icon.iso_only}
    }
    elseif($code.us.ContainsKey($value)) {$icon.us_only}
}

filter Get-CodeDetails([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$value)
{
    if($code.iso.ContainsKey($value))
    {
        $flag = '&#x{0:X};&#x{1:X}; ' -f ($flagAMinusA+[int]$value[0]),($flagAMinusA+[int]$value[1])
        if(!$code.us.ContainsKey($value))
        {
            $flag + $code.iso[$value] + ' (ISO)'
            Get-IsoConversion $value |Where-Object {$_} |ForEach-Object {[void]$convert.Add($_)}
            $count.iso_only++
        }
        else
        {
            if(Test-Mismatch $value)
            {
                $flag + $code.iso[$value] + ' (ISO)'
                $code.us[$value]
                Write-Verbose "${code}: $($code.iso[$value]) != $($code.us[$value])"
                Get-IsoConversion $value |Where-Object {$_} |ForEach-Object {[void]$convert.Add($_)}
                Get-UsConversion $value |Where-Object {$_} |ForEach-Object {[void]$convert.Add($_)}
                $count.mismatched++
            }
            else
            {
                $flag + $code.iso[$value]
                [void]$matched.Add($value)
                $count.matched++
            }
        }
        if($code.currency.ContainsKey($value)) {$code.currency[$value]}
    }
    elseif($code.us.ContainsKey($value))
    {
        $code.us[$value]
        Get-UsConversion $value |Where-Object {$_} |ForEach-Object {[void]$convert.Add($_)}
        $count.us_only++
    }
    if($code.lang.ContainsKey($value)) {$icon.language + ' ' + $code.lang[$value]}
}

filter Format-HtmlTableCell([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$value)
{
    [string[]]$details = Get-CodeDetails $value
    if(!$details) {"<td>&cir; $value"}
    else {@"
<td><details><summary>$value $(Get-CodeIndicator $value)</summary><ul>
$($details |ForEach-Object {"<li>$([Net.WebUtility]::HtmlEncode($_) -replace '&amp;(#?\w+;)','&$1')</li>"})
</ul></details></td>
"@}}

filter Format-HtmlTableRow([Parameter(ValueFromPipeline=$true)][char]$letter)
{"<tr>$(0x41..0x5A |ForEach-Object {"$letter$([char]$_)"} |Format-HtmlTableCell)</tr>"}

function Test-GencRenamed([string]$value)
{
    if(!$code.iso.ContainsKey($value)) {return $false}
    return !$name.iso.ContainsKey($code.iso[$value])
}

function Format-HtmlCountries
{@"
<html><head><title>Two Letter Country Codes plus currency and language codes</title>
<link rel="stylesheet" href="http://webcoder.info/assets/css/style.css">
<style>body {background: #FFF} div.container {margin:0 !important} td {vertical-align:top}
footer {text-align:center;margin:1em;background:#DDD}</style>
</head><body>

<table style="white-space:nowrap;font-size:9pt">
<caption><h1>Two Letter Country Codes plus currency and language codes</h1></caption><tbody>
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
<li>$($icon.iso_only) $($code.iso.Count) ISO codes total</li>
<li>$($icon.us_only) $($count.us_only) US-only codes</li>
<li>$($icon.us_only) $($code.us.Count) US codes total</li>
</ul></td></tr></tfoot></table>

<table>
<caption><h2>US-ISO conversion ($($convert.Count))</h2></caption>
<thead><tr><th>ISO</th><th>US</th><th>Official Name</th><th>Common Name</th><th>US Name</th></tr></thead>
<tbody>$($convert |ForEach-Object {
    "<tr><td>$($_.IsoCode)</td><td>$($_.UsCode)</td><td>$($_.OfficialName + $info[$_.IsoCode ?? ''])</td><td>$($_.CommonName)</td><td>$($_.UsName)</td></tr>"})</tbody>
<tfoot>
<tr><td colspan="99">Matches: $($matched -join ', ')</td></tr>
<tr><td colspan="99">Diplomatic context: <a href="https://en.wikipedia.org/wiki/List_of_states_with_limited_recognition">Wikipedia: List of states with limited recognition</a></td></tr>
</tfoot>
</table>

<table>
<caption>GENC changes to ISO</caption>
<thead><tr><th>±</th><th>Code</th><th>Name</th><th>ISO Name</th></tr></thead>
<tbody>$($code.genc.Keys |Where-Object {Test-GencRenamed $_} |
    ForEach-Object {"<tr><td>📛</td><td>$_</td><td>$($code.genc[$_])</td><td>$($code.iso[$_])</td></tr>"})</tbody>
<tbody>$($code.genc.Keys |Where-Object {$_ -notin $code.iso.Keys} |
    ForEach-Object {"<tr><td>➕</td><td>$_</td><td colspan='2'>$($code.genc[$_])</td></tr>"})</tbody>
<tbody>$($code.iso.Keys |Where-Object {$_ -notin $code.genc.Keys} |
    ForEach-Object {"<tr><td>➖</td><td>$_</td><td colspan='2'>$($code.iso[$_])</td></tr>"})</tbody>
</table>

<section class="container">

<div><object type="image/svg+xml" data="images/country-code-standards.svg" style="max-width:50%;padding:0 25%">
    <img src="images/country-code-standards.svg" alt="Country Codes, international and domestic, and their derivation"
        style="max-width:50%;padding:0 25%" />
</object></div>

<div><object type="image/svg+xml" data="images/country-code-intl-timeline.svg">
    <img src="images/country-code-intl-timeline.svg" alt="🌐 International Country Codes Timeline"
        style="max-width:100%" />
</object></div>

<div><object type="image/svg+xml" data="images/country-code-us-timeline.svg">
    <img src="images/country-code-us-timeline.svg" alt="🇺🇸 US Country Codes Timeline"
        style="max-width:100%" />
</object></div>

</section>

<footer>Thanks to <a href="https://datahub.io/docs/core-data">datahub.io</a>!</footer>

</html>
"@}

function Invoke-Export
{
    if(!(Test-Path data -Type Container)) {New-Item data -Type Directory |Out-Null}
    Split-Path $PSScriptRoot |Join-Path -ChildPath data |Push-Location
    Initialize-ReadHashes
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
    Initialize-Export
    Format-HtmlCountries |Out-File countries.html utf8
    $count |Out-String |Write-Info.ps1 -fg DarkGray
}

Invoke-Export

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

$iso = @{}
$fips = @{}
$subregion = @{}
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
        [void]$iso.Add($entry.iso,$entry.names.en)
        if($entry.fips)
        {
            [void]$fips.Add($entry.fips,$entry.names.en)
        }
        if($entry.regions -and $entry.regions[0].iso -like '[A-Z][A-Z]')
        {
            foreach($region in $entry.regions)
            {
                $name = $entry.iso + '-' + $region.iso + ' ' + $region.names.en
                if($subregion.ContainsKey($region.iso)) {$subregion[$region.iso] += $name}
                else {[void]$subregion.Add($region.iso,@($name))}
            }
        }
    }
    Write-Progress "Reading $json" -Completed
    if(!$iso.Count) {throw "No codes read."}
    Write-Verbose "Read $($iso.Count) ISO and $($fips.Count) FIPS codes"
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
    if($iso.ContainsKey($code))
    {
        if($fips.ContainsKey($code)) {if($iso[$code] -ne $fips[$code]) {$icon.mismatch}}
        else {$icon.iso_only}
    }
    elseif(!$fips.ContainsKey($code)) {$icon.subregion_only}
    else {$icon.fips_only}
}

function Get-CodeDetails([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{
    if($iso.ContainsKey($code))
    {
        if(!$fips.ContainsKey($code)) {$iso[$code] + ' (ISO)'}
        else
        {
            if($iso[$code] -eq $fips[$code]) {$iso[$code]}
            else
            {
                $iso[$code] + ' (ISO)'
                $fips[$code] + ' (FIPS)'
            }
        }
    }
    elseif($fips.ContainsKey($code))
    {
        $fips[$code] + ' (FIPS)'
    }
    if($subregion.ContainsKey($code)) {$subregion[$code]}
}

function Format-HtmlTableCell([Parameter(ValueFromPipeline=$true)][ValidatePattern('(?-i)\A[A-Z]{2}\z')][string]$code)
{Process{
    [string[]]$details = Get-CodeDetails $code
    if(!$details) {"<td>&cir; $code"}
    else {@"
<td><details><summary>$code $(Get-CodeIndicator $code)</summary><ul>
$($details |% {"<li>$([Net.WebUtility]::HtmlEncode($_))</li>"})
</ul></details></td>
"@
}}}

function Format-HtmlTableRow([Parameter(ValueFromPipeline=$true)][char]$letter)
{Process{"<tr>$(0x41..0x5A |% {"$letter$([char]$_)"} |Format-HtmlTableCell)</tr>"}}

function Format-Markdown
{@"
Two Letter Country Codes
========================

<table style="min-width:150em;white-space:nowrap;font-size:9pt;margin:0 -8% 1em"><caption>ISO/FIPS Country Codes</caption>
$(0x41..0x5A |% {[char]$_} |Format-HtmlTableRow)
</table>

<!-- ... -->

Legend
------
- $($icon.mismatch) ISO and FIPS codes do not agree, though the code is valid in both
- $($icon.iso_only) ISO defines this code, but it is an invalid FIPS code
- $($icon.fips_only) FIPS defines this code, but it is an invalid ISO code
- $($icon.subregion_only) neither ISO nor FIPS define this as a country code,
  though it is a valid subregion (state/province/&c) ISO code
- $($icon.not_a_code) not a valid country in either standard or ISO subregion code

"@}

Read-Codes
Format-Markdown |Out-File countries.md utf8

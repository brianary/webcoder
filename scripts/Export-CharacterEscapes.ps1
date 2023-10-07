<#
.SYNOPSIS
Exports TSV files that show the effect of various markup escaping methods on characters from the Basic Multilingual Plane.

.LINK
https://www.unicode.org/versions/Unicode5.2.0/ch05.pdf#G10213

.LINK
https://en.wikibooks.org/wiki/Unicode/Character_reference/0000-0FFF

.LINK
https://en.wikipedia.org/wiki/List_of_Unicode_characters#Control_codes
#>

#Requires -Version 7
[CmdletBinding()] Param()

filter Format-VisibleChar
{
    [CmdletBinding()][OutputType([char])] Param(
    [Parameter(ValueFromPipeline)][int] $Value
    )
    if(0x0020 -ge $Value) {return [char](0x2400+$Value)}
    elseif(0x0085 -eq $Value) {return [char]0x2424}
    elseif(0x2028 -eq $Value) {return @(('[LS]').GetEnumerator())}
    elseif(0x2029 -eq $Value) {return @(('[PS]').GetEnumerator())}
    else {return [char]$Value}
}

filter Format-VisibleString
{
    [CmdletBinding()][OutputType([string])] Param(
    [Parameter(ValueFromPipeline)][string] $Value
    )
    $Local:OFS = ''
    return "$($Value.GetEnumerator() |Format-VisibleChar)"
}

function Export-PscEscapes
{
    [CmdletBinding()][OutputType([void])] Param(
    [Parameter(Position=0,Mandatory=$true)][string] $Path
    )
    if((Test-Path $Path -Type Leaf)) {Remove-Item $Path}
    [char]::MinValue..[char]::MaxValue |
        ForEach-Progress 'Escaping chars (PSC)' {'U+{0:X4}' -f [int]$_} |
        ForEach-Object {[pscustomobject]@{
            Codepoint  = 'U+{0:X4}' -f [int]$_
            Escape     = [Security.SecurityElement]::Escape("$_") |Format-VisibleString
            Encode     = [Text.Encodings.Web.HtmlEncoder]::Default.Encode("$_") |Format-VisibleString
            HtmlEncode = [Web.HttpUtility]::HtmlEncode("$_") |Format-VisibleString
        }} |Export-Csv $Path -Delimiter "`t" -Encoding utf8BOM
    Import-Csv $Path -Delimiter "`t" |Out-GridView -Title 'PSC Escapes'
}

function Export-WpsEscapes
{
    [CmdletBinding()][OutputType([void])] Param(
    [Parameter(Position=0,Mandatory=$true)][string] $Path
    )
    if((Test-Path $Path -Type Leaf)) {Remove-Item $Path}
    Invoke-WindowsPowerShell.ps1 {
        Add-Type -AN System.Web
        . ([scriptblock]::Create($args[1]))
        [char]::MinValue..[char]::MaxValue |
            ForEach-Progress.ps1 'Escaping chars (WPS)' {'U+{0:X4}' -f $_} {[char]$_} |
            ForEach-Object {[pscustomobject]@{
                Codepoint           = 'U+{0:X4}' -f [int]$_
                HtmlEncode          = [Web.Security.AntiXss.AntiXssEncoder]::HtmlEncode("$_", $false) |Format-VisibleString
                XmlAttributeEncode  = [Web.Security.AntiXss.AntiXssEncoder]::XmlAttributeEncode("$_") |Format-VisibleString
                XmlEncode           = [Web.Security.AntiXss.AntiXssEncoder]::XmlEncode("$_") |Format-VisibleString
            }} |Export-Csv ($args[0]) -Delimiter "`t" -Encoding utf8
    } -BlockArgs $Path,@"
filter Format-VisibleChar {$(Get-Content function:Format-VisibleChar)}
filter Format-VisibleString {$(Get-Content function:Format-VisibleString)}
"@
    Import-Csv $Path -Delimiter "`t" |Out-GridView -Title 'WPS Escapes'
}

function Export-Escapes
{
    [CmdletBinding()] Param()
    Export-PscEscapes "$PSScriptRoot/../data/bmp-enc.tsv"
    Export-WpsEscapes "$PSScriptRoot/../data/bmp-axss.tsv"
}

Export-Escapes

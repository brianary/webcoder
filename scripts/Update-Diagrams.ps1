<#
.SYNOPSIS
Updates Mermaid diagrams.
#>

#Requires -Version 3
[CmdletBinding()] Param(
[switch] $Force
)

Use-Command.ps1 mmdc "$env:APPDATA\npm\mmdc.ps1" -npm @mermaid-js/mermaid-cli
Split-Path $PSScriptRoot |Join-Path -ChildPath images |Push-Location
try
{
    Get-Item *.mmd |
        Add-Member -MemberType ScriptProperty -Name svg -Value {[io.path]::ChangeExtension($_.FullName, 'svg')} -PassThru |
        Where-Object {$Force -or !(Test-Path $_.svg -Type Leaf) -or ($_.LastWriteTime -gt (Get-Item $_.svg).LastWriteTime)} |
        ForEach-Object {Write-Info.ps1 "Writing $($_.svg)" -fg DarkCyan; mmdc -i $_.FullName -o $_.svg}
}
finally
{
    Pop-Location
}

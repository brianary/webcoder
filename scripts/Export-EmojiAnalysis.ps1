<#
.SYNOPSIS
Examines the official list of emoji and methods of matching them.
#>

#Requires -Version 7
[CmdletBinding()] Param(
[uri] $EmojiSequences = 'https://www.unicode.org/Public/emoji/15.0/emoji-sequences.txt'
)

$filename = $EmojiSequences.Segments[-1]
function Save-Data
{
    if(!(Test-Path $filename -Type Leaf))
    {
        $http = Invoke-WebRequest $EmojiSequences -OutFile $filename -PassThru
        Write-Information "Downloaded $EmojiSequences to $(Join-Path $PWD $filename)"
        [datetime] $lastmod = "$($http.Headers['Last-Modified'])"
        (Get-Item $filename).LastWriteTime = $lastmod
    }
    else
    {
        $http = Invoke-WebRequest $EmojiSequences -Method Head
        [datetime] $lastmod = "$($http.Headers['Last-Modified'])"
        if((Get-Item $filename).LastWriteTime -lt $lastmod)
        {
            Invoke-WebRequest $EmojiSequences -OutFile $filename
            Write-Information "Updated $EmojiSequences to $(Join-Path $PWD $filename)"
            (Get-Item $filename).LastWriteTime = $lastmod
        }
    }
}

function Get-SimpleBasicEmoji
{
    (Get-Content $filename) -like '*; Basic_Emoji*' |
        Select-String '^([0-9A-F]{4,5}(?:\.\.[0-9A-F]{4,5})?)\s+;' |
        ForEach-Object {$_.Matches.Groups[1].Value} |
        ForEach-Object {
            if($_ -notlike '*..*') {[Convert]::ToInt32($_,16)}
            else
            {
                $a,$b = $_ -split '\.\.',2
                [Convert]::ToInt32($a,16) .. [Convert]::ToInt32($b,16)
            }
        }
}

function Get-CompositeBasicEmoji
{
    (Get-Content $filename) -like '*; Basic_Emoji*' |
        Select-String '^([0-9A-F]{4,5})\sFE0F\s+;' |
        ForEach-Object {[Convert]::ToInt32($_.Matches.Groups[1].Value,16)}
}

Split-Path $PSScriptRoot |Join-Path -ChildPath data |Push-Location
#Save-Data
#Get-SimpleBasicEmoji
#Get-CompositeBasicEmoji
Pop-Location

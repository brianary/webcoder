<#
.SYNOPSIS
Examines the official list of emoji and methods of matching them.

.DESCRIPTION
We're focusing on how to quickly match Basic_Emoji, ignoring Emoji_Keycap_Sequence,
RGI_Emoji_Flag_Sequence, RGI_Emoji_Tag_Sequence, and RGI_Emoji_Modifier_Sequence.
#>

#Requires -Version 7
[CmdletBinding()] Param(
[uri] $EmojiSequences = 'https://www.unicode.org/Public/emoji/15.0/emoji-sequences.txt',
[string] $DataFile = ($PSScriptRoot |Split-Path |Join-Path -ChildPath data -AdditionalChildPath $EmojiSequences.Segments[-1]),
[string] $OutFile = ($PSScriptRoot |Split-Path |Join-Path -ChildPath emoji-analysis.md)
)

function Save-Data
{
    if(!(Test-Path $DataFile -Type Leaf))
    {
        $http = Invoke-WebRequest $EmojiSequences -OutFile $DataFile -PassThru
        Write-Information "Downloaded $EmojiSequences to $(Join-Path $PWD $DataFile)"
        [datetime] $lastmod = "$($http.Headers['Last-Modified'])"
        (Get-Item $DataFile).LastWriteTime = $lastmod
    }
    else
    {
        $http = Invoke-WebRequest $EmojiSequences -Method Head
        [datetime] $lastmod = "$($http.Headers['Last-Modified'])"
        if((Get-Item $DataFile).LastWriteTime -lt $lastmod)
        {
            Invoke-WebRequest $EmojiSequences -OutFile $DataFile
            Write-Information "Updated $EmojiSequences to $(Join-Path $PWD $DataFile)"
            (Get-Item $DataFile).LastWriteTime = $lastmod
        }
    }
}

function Get-SimpleBasicEmoji
{
    [OutputType([int])] Param()
    (Get-Content $DataFile) -like '*; Basic_Emoji*' |
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
    [OutputType([int])] Param()
    (Get-Content $DataFile) -like '*; Basic_Emoji*' |
        Select-String '^([0-9A-F]{4,5})\sFE0F\s+;' |
        ForEach-Object {[Convert]::ToInt32($_.Matches.Groups[1].Value,16)}
}

filter Find-UnicodeCategoryClasses
{
    Param([Parameter(ValueFromPipeline)][int]$Value)
    @('Lu','Ll','Lt','Lm','Lo','L','Mn','Mc','Me','M','Nd','Nl','No','N','Pc','Pd','Ps','Pe','Pi',
        'Pf','Po','P','Sm','Sc','Sk','So','S','Zs','Zl','Zp','Z','Cc','Cf','Cs','Co','Cn','C') |
        Where-Object {[char]::ConvertFromUtf32($Value) -cmatch "\p{$_}"}
}

function ConvertTo-MarkdownCharacterChart
{
    Param([Parameter(ValueFromPipeline)][int]$Value)
    End
    {
        '| code point | char | text | emoji | name |'
        '|------------|:----:|:----:|:-----:|------|'
        $input |
            ForEach-Object {'| U+{0:X4} | &#x{0:X4}; | &#x{0:X4};&#xFE0E; | &#x{0:X4};&#xFE0F; | {1} |' -f
                $_,(Get-UnicodeName.ps1 $_)}
    }
}

function ConvertTo-MarkdownCategoryCounts
{
    Param([Parameter(ValueFromPipeline)][int]$Value)
    End
    {
        '| count | category |'
        '|------:|----------|'
        $input |
            Find-UnicodeCategoryClasses |
            Group-Object -NoElement |
            Sort-Object Count -Descending |
            ForEach-Object {"| $($_.Count) | $($_.Name) |"}
    }
}

function Export-EmojiAnalysis
{
    $Local:OFS=[Environment]::NewLine
    $simple = Get-SimpleBasicEmoji
    $composite = Get-CompositeBasicEmoji
    @"
Emoji Match Analysis
====================

Emoji category matches
----------------------

The matching Unicode categories for ``Basic_Emoji`` from [$($EmojiSequences.Segments[-1])]($EmojiSequences).
(Ignoring ``Emoji_Keycap_Sequence``, ``RGI_Emoji_Flag_Sequence``, ``RGI_Emoji_Tag_Sequence``, and ``RGI_Emoji_Modifier_Sequence``.)

### Simple emoji

Characters with a colorful rendering by default, but can be monochromatic with variation selector 15.

<details><summary>Simple emoji list</summary>

$($simple |ConvertTo-MarkdownCharacterChart |Out-String |ConvertFrom-Markdown |Select-Object -ExpandProperty Html |
    ForEach-Object {$_ -replace '<tbody>','<tbody style="max-height: 20em; overflow: scroll;">'})

</details>

$($simple |ConvertTo-MarkdownCategoryCounts)

### Composite emoji

Characters with a monochromatic rendering by default, but can be colorful with variation selector 16.

<details><summary>Composite emoji list</summary>

$($composite |ConvertTo-MarkdownCharacterChart |Out-String |ConvertFrom-Markdown |Select-Object -ExpandProperty Html |
    ForEach-Object {$_ -replace '<tbody>','<tbody style="max-height: 20em; overflow: scroll;">'})

</details>

$($composite |ConvertTo-MarkdownCategoryCounts)
"@ |Out-File $OutFile utf8
}

Export-EmojiAnalysis

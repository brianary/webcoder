PowerShell Encoding
===================

In versions prior to [PowerShell Core 6's cleanup][PSC6enc], PowerShell encoding was kind of a mess.

[PSC6enc]: https://docs.microsoft.com/powershell/scripting/whats-new/what-s-new-in-powershell-core-60#default-encoding-is-utf-8-without-a-bom "Default encoding is UTF-8 without a BOM"

Using PowerShell 5.1.14409.1012 with version 3.1 of Microsoft.PowerShell.Management and Microsoft.PowerShell.Utility,
let's list all the cmdlets that have an "Encoding" parameter, plus the type and default of that parameter:

```powershell
gcm |
    ? {$_.Parameters -and $_.Parameters.ContainsKey('Encoding')} |
    % {[pscustomobject]@{
        CommandName  = $_.Name
        EncodingType = ([type]$_.Parameters.Encoding.ParameterType).Name # for brevity
        Default      = (help $_.Name -par encoding |sls 'the default') -replace
            'The default(?: value)? is | is the default|Specifies.*\. |[ .]','' -join ''
    }} |
    sort CommandName |
    ft -auto
```

```text
CommandName      EncodingType                     Default
-----------      ------------                     -------
Add-Content      FileSystemCmdletProviderEncoding
Export-Clixml    String                           Unicode
Export-Csv       String                           ASCII
Export-PSSession String                           UTF-8
Format-Hex       String                           Unicode
Get-Content      FileSystemCmdletProviderEncoding
Import-Csv       String                           ASCII
Out-File         String                           Unicode
Select-String    String                           UTF8
Send-MailMessage Encoding                         ASCII
Set-Content      FileSystemCmdletProviderEncoding ASCII
```

This script uses **Get-Help** and parses the text description of the parameter defaults.

Those defaults are definitely not… harmonius:
ASCII, utf-8, "ANSI"/"OEM" (depending on your locale), and "Unicode" (which is really utf-16).
`Default` encoding, as described in **Out-File** and **Select-String**'s **Encoding** parameter help aren't
actually the default of any cmdlets.

> Default uses the encoding of the system's current ANSI code page.

Not even the types of these parameters are in agreement!
Some string names, some **System.Text.Encoding** objects (which can be converted from a name), but also an enumeration.

To get the values available for that enumeration, use
[**Get-EnumValues.ps1**](https://github.com/brianary/scripts/blob/master/Get-EnumValues.ps1):

```powershell
Get-EnumValues.ps1 Microsoft.Powershell.Commands.FileSystemCmdletProviderEncoding
```

```text
Value Name
----- ----
    0 Unknown
    1 String
    2 Unicode
    3 Byte
    4 BigEndianUnicode
    5 UTF8
    6 UTF7
    7 UTF32
    8 Ascii
    9 Default
   10 Oem
   11 BigEndianUTF32
```

The new PowerShell Core uses the [`Encoding`][] type for all these cmdlet parameters, with a default value of the new `UTF8NoBOM`.

[`Encoding`]: https://docs.microsoft.com/dotnet/api/system.text.encoding "Represents a character encoding."

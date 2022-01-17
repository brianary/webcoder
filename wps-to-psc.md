Windows PowerShell (WPS) to PowerShell Core (PSC)
=================================================

There are certain gaps when moving from Windows PowerShell (5.x) to the new cross-platform PowerShell Core (6+),
due to features that relied on Windows-specific infrastructure. Here are a few notable things that are no longer
supported, with some possible workarounds (which will mostly still work only on Windows, because they were
Windows-specific features to start with).

WPS is `powershell.exe`, and is entirely independent of PSC, which is `pwsh.exe`. You can still use both, but
future development efforts will be focused on PSC.

`New-WebServiceProxy`
---------------------

In WPS, you could create a proxy class with only a WSDL URL that described a SOAP service, and you'd have access
to that web service's calls as methods on that class.

In PSC, you'll have to use `Invoke-RestMethod` for each call, manually creating the SOAP envelope and serializing
the parameters into it before sending it as the request body (be sure to XML-encode any strings!).
You can often see [what the SOAP envelope looks like][soap] from the WSDL.

```powershell
$response = Invoke-RestMethod https://www.w3schools.com/xml/tempconvert.asmx `
    -Method Post `
    -ContentType 'text/xml; charset=utf-8' `
    -Headers @{SOAPAction='https://www.w3schools.com/xml/FahrenheitToCelsius'} `
    -Body @"
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FahrenheitToCelsius xmlns="https://www.w3schools.com/xml/">
      <Fahrenheit>$degrees</Fahrenheit>
    </FahrenheitToCelsius>
  </soap:Body>
</soap:Envelope>
"@
```

then deserializing the response body:

```powershell
$value = Select-Xml '/soap:Envelope/soap:Body/*/*/text()' $response `
    -Namespace @{soap='http://schemas.xmlsoap.org/soap/envelope/'} |
    foreach {$_.Node.Value}
# additional parsing of $value may be necessary, depending on the SOAP method
```

This process obviously becomes more work depending on the parameter and response data structures.

See [SOAP support in all platforms · Issue #9838 · PowerShell/PowerShell][issue9838]

[soap]: https://www.w3schools.com/xml/tempconvert.asmx?op=FahrenheitToCelsius "FahrenheitToCelsius"
[issue9838]: https://github.com/PowerShell/PowerShell/issues/9838

`Get-WmiObject`
---------------

Windows Management Instrumentation (WMI) allows querying system details like hardware info, but it uses
an old Windows-specific protocol that has been supplanted by the newer Common Information Model (CIM).
PSC no longer supports WMI, in favor of CIM.

### WMI in WPS

```powershell
Get-WmiObject Win32_PhysicalMemory |
    foreach {"$($_.BankLabel) $($_.Tag) $($_.Capacity / 1GB)GB"}
```

```txt
BANK 0 Physical Memory 0 16GB
BANK 0 Physical Memory 1 16GB
```

### CIM in PSC

```powershell
Get-CimInstance CIM_PhysicalMemory |
    foreach {"$($_.BankLabel) $($_.Tag) $($_.Capacity / 1GB)GB"}
```

```txt
BANK 0 Physical Memory 0 16GB
BANK 0 Physical Memory 1 16GB
```

Many WMI "classes" have direct analogs, a few do not.

### Some examples of WMI to CIM classes

| WMI class             | CIM class           |
| --------------------- | ------------------- |
| Win32_ComputerSystem  | CIM_ComputerSystem  |
| Win32_OperatingSystem | CIM_OperatingSystem |
| Win32_Processor       | CIM_Processor       |
| Win32_StorageVolume   | CIM_StorageVolume   |
| Win32_Share           | *(none)*            |

Use `Get-CimClass` for a list of available classes.

See [about_WMI_Cmdlets][], [CimCmdlets module][], and [Should I use CIM or WMI with Windows PowerShell?][cim-vs-wmi]

[about_WMI_Cmdlets]: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_wmi_cmdlets "Provides background information about Windows Management Instrumentation (WMI) and Windows PowerShell."
[CimCmdlets module]: https://docs.microsoft.com/powershell/module/cimcmdlets/ "Contains cmdlets that interact with Common Information Model (CIM) Servers like the Windows Management Instrumentation (WMI) service."
[cim-vs-wmi]: https://devblogs.microsoft.com/scripting/should-i-use-cim-or-wmi-with-windows-powershell/ "Richard Siddaway explains the differences between the CIM cmdlets and the WMI cmdlets, and details use cases."

`Set-Clipboard -AsHtml`
-----------------------

In WPS, you could copy content as formatted HTML, so you could paste it anywhere that accepted formatted text
like emails, messenger applications, documents, &c. This was really nice when paired with `ConvertTo-Html`.

This required some Windows-specific features, so it has been removed in PSC.

Maybe the easiest workaround is to set the clipboard text in PSC with `Set-Clipboard`, and then call WPS from PSC:

```powershell
powershell.exe -NoProfile -NonInteractive -Command "Get-Clipboard |Set-Clipboard -AsHtml"
```

or, more concisely:

```powershell
powershell -nop -noni -c "gcb |scb -ash"
```

`Invoke-WebRequest -UseBasicParsing:$false`
-------------------------------------------

In WPS, the default behavior of `Invoke-WebRequest` was to parse the response using a hosted version of Internet Explorer,
unless `-UseBasicParsing` was specified (`-UseBasicParsing:$false` explicitly disables this behavior). Arguably this default
was backwards: you'd expect this extra overhead to be enabled upon request.

This featuer was convenient because parsing HTML is much trickier than XML (XHTML sought to combine the two for convenience,
but added a lot more syntax overhead that HTML5 was in part a reaction against), and having access to the full DOM of parsed
HTML also allowed for sophisticated querying.

PSC has discontinued support for this feature entirely, even though the parameter still exists for (misleading)
backwards-compatibility.

One simple potential workaround is to use the `HTMLFile` COM component, which is just another way to get at the Internet
Explorer DOM.

```powershell
$dom = New-Object -ComObject HTMLFile
$dom.write(([Text.Encoding]::Unicode.GetBytes($html)))
```

👉 Note: The `HTMLFile` COM component (ActiveX control) tends to ignore any invisible content, and can fail to parse
complex content entirely. You may need to manually strip `<script>` elements, for example.

ANSI colors and `Out-String`
----------------------------

![PSC ANSI color headers](images/psc-ansi-color-headers.png)

By default PSC now displays colorful headers using standard ANSI terminal escape sequences.
The new [`$PSStyle`][] object controls these colors and styles.

However, these ANSI escape sequences can sometimes produce unwanted results:

```powershell
@"
Power* Processes
================
$(Get-Process power* |Out-String)
"@ |Out-File power-proc.txt

```

### _power-proc.txt_

```txt
Power* Processes
================

␛[32;1m NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName␛[0m
␛[32;1m ------    -----      -----     ------      --  -- -----------␛[0m
     27     6.01       5.10      24.22    9168   1 PowerToys
     10    17.17       0.97      11.52   11040   1 PowerToys.AlwaysOnTop
     50    28.09       6.53       1.19   11060   1 PowerToys.Awake
     50    39.95      15.74       4.75   11084   1 PowerToys.ColorPickerUI
     17    59.24       7.35       5.02   11116   1 PowerToys.FancyZones
      9    14.40       1.03       3.97   11156   1 PowerToys.KeyboardManagerEngine
    104   197.88      82.94      17.06   11204   1 PowerToys.PowerLauncher
```

Unless this file is intended purely for output directly to the terminal, you probably don't want those ANSI
escape codes there.

Perhaps the best way to disable ANSI codes is with the [`NO_COLOR`][] environment variable, which can be set
for the scope of the running process, is cross-platform, and applies to several external apps as well.
You can also use the `TERM` environment variable:

```powershell
$env:NO_COLOR = $true
$env:TERM = 'xterm-mono' # equivalent for PowerShell, but may differ for external programs
```

PSC supports other ways of suppressing ANSI codes by directly setting `$PSStyle.OutputRendering = 'PlainText'`,
but `$PSStyle` doesn't seem to be scoped as locally (it's a global singleton), so this could potentially affect
parallel processes in your session. You'd also want to save the previous value and restore it when you're done,
which adds extra steps, and also doesn't work well with parallel processes.

See [about_ANSI_Terminals: Disabling ANSI output][disable-ansi]

[`$PSStyle`]: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_ansi_terminals#psstyle "A global singleton variable for controlling ANSI terminal colors and styles."
[disable-ansi]: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_ansi_terminals#disabling-ansi-output "Support for ANSI escape sequences can be turned off using the TERM or NO_COLOR environment variables."
[`NO_COLOR`]: https://no-color.org/ "An informal standard to suppress color output."

`Write-Progress` and `$PSStyle`
-------------------------------

The new default style for `Write-Progress` in PSC is compact and inline ("Minimal"):

![PSC progress default (Minimal) view](images/psc-progress.png)

To use the banner across the top of the terminal, WPS-style, you have to set the view:

```powershell
$PSStyle.Progress.View = 'Classic'
```

![PSC progress Classic view](images/psc-progress-classic.png)

See [about_ANSI_Terminals][], under `$PSStyle.Progress`

[about_ANSI_Terminals]: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_ansi_terminals "PowerShell has many features that support the use of ANSI escape sequences to control the rendering of output in the terminal application that is hosting PowerShell."

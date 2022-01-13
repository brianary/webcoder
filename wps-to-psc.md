Windows PowerShell to PowerShell Core
=====================================

There are certain gaps when moving from Windows PowerShell (5.x) to the new cross-platform PowerShell Core (6+),
due to features that relied on Windows-specific infrastructure. Here are a few notable things that are no longer
supported, with some possible workarounds.

Windows PowerShell (WPS) is `powershell.exe`, and is entirely independent of PowerShell Core (PSC), which is
`pwsh.exe`. You can still use both, but future development efforts will be focused on PSC.

`New-WebServiceProxy`
---------------------

In WPS, you could create a proxy class with only a WSDL URL that described a SOAP service, and you'd have access
to that web service's calls as methods on that class.

In PSC, you'll have to use `Invoke-WebRequest` for each call, manually creating the SOAP envelope and serializing
the parameters into it before sending it as the request body, then deserializing the response body.

You can often see [what the SOAP envelope looks like][soap] from the WSDL.

See [SOAP support in all platforms · Issue #9838 · PowerShell/PowerShell][issue9838]

[soap]: https://www.w3schools.com/xml/tempconvert.asmx?op=FahrenheitToCelsius "FahrenheitToCelsius"
[issue9838]: https://github.com/PowerShell/PowerShell/issues/9838

Windows Management Instrumentation
----------------------------------

WMI allows querying system details like hardware info, but it uses an old Windows-specific protocol that has been
supplanted by the newer Common Information Model (CIM). PSC no longer supports WMI, in favor of CIM.

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

Maybe the easiest workaround is to call WPS from PSC:

```powershell
powershell.exe -NoProfile -NonInteractive -Command "Get-Clipboard |Set-Clipboard -AsHtml"
```

or, more concisely:

```powershell
powershell -nop -noni -c "gcb |scb -ash"
```

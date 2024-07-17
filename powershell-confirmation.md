 PowerShell Confirmation
 =======================
 
 PowerShell provides a [`$PSCmdlet.ShouldProcess($target, $action)`][ShouldProcess] method
 (and some variants) that are enabled when a function enables [SupportsShouldProcess][].
 The behavior is affected by the [`$ConfirmPreference`][] preference variable,
 the declared `ConfirmImpact` level of the function, and the [`-WhatIf` and `-Confirm` parameters][RiskParams].
 A [`$PSCmdlet.ShouldContinue($target, $action)`][ShouldContinue] method is provided for greater control.
 See [Everything you wanted to know about ShouldProcess][moreinfo].
 
 ```powershell
 function Invoke-Action
 {
     [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='Medium')] Param(
     [psobject] $Target
     )
     if($PSCmdlet.ShouldProcess("$Target", 'invoke action')) { <# perform action #> }
 }
 
 $ConfirmPreference = 'High'
 
 Invoke-Action
 # (ShouldProcess returns true)
 
 Invoke-Action -WhatIf
 # What if: Performing the operation "invoke action" on target "Target".
 # (ShouldProcess returns false)
 
 Invoke-Action -Confirm
 # Confirm
 # Are you sure you want to perform this action?
 # Performing the operation "show" on target "prompt".
 # [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
 ```
 
 `ShouldProcess()` return value
 ------------------------------
 
 1. If `-WhatIf` is enabled, `ShouldProcess()` will write the intended action to the host and return false.
 2. If `-Confirm` is enabled, `ShouldProcess()` will prompt.
 3. If `$ConfirmPreference` or `ConfirmImpact` is `None`, `ShouldProcess()` will return true.
 4. If the function `ConfirmImpact` is `High`, `ShouldProcess()` will always prompt.
 5. If `$ConfirmPreference` is higher than `ConfirmImpact`, `ShouldProcess()` will return true.
 6. `ShouldProcess()` will prompt otherwise.
 
 | level<br/>`$ConfirmPreference` &rarr;<br/>`ConfirmImpact` &darr; |  Low   | Medium |  High  | None |
 |:---------------------------------------------------------:|:------:|:------:|:------:|:----:|
 |                           None                            |  True  |  True  |  True  | True |
 |                            Low                            | prompt |  True  |  True  | True |
 |                          Medium                           | prompt | prompt |  True  | True |
 |                           High                            | prompt | prompt | prompt | True |
 
 [ShouldProcess]: https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet.shouldprocess "Cmdlet.ShouldProcess() Method"
 [ShouldContinue]: https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet.shouldcontinue "Cmdlet.ShouldContinue() Method"
 [SupportsShouldProcess]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute#supportsshouldprocess "about_Functions_CmdletBindingAttribute"
 [`$ConfirmPreference`]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables#confirmpreference "about_Preference_Variables"
 [RiskParams]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_commonparameters#risk-management-parameter-descriptions "Risk Management Parameter Descriptions"
 [moreinfo]: https://learn.microsoft.com/powershell/scripting/learn/deep-dives/everything-about-shouldprocess "Everything you wanted to know about ShouldProcess"
 
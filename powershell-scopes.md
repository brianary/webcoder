PowerShell Scopes
=================

Test Scripts
------------

### `ScopeFirst.ps1`

```powershell
[CmdletBinding()] Param()
function Show-Variable([Parameter(ValueFromPipeline)]$var)
{Process{"- $($var.Name) = $($var.Value)"}}
$FirstDefault         = $true
$Global:FirstGlobal   = $true
$Script:FirstScript   = $true
$Local:FirstLocal     = $true
$Private:FirstPrivate = $true
Set-Variable First1 $true -Scope 1
.\ScopeSecond.ps1
"First default scope"
Get-Variable First*,Second*,Third* |Show-Variable
foreach($s in 1,'Global','Script','Local')
{
    "First $s scope"
    Get-Variable First*,Second*,Third* -Scope $s |Show-Variable
}
```

### `ScopeSecond.ps1`

```powershell
[CmdletBinding()] Param()
function ScopeSecondFunction
{
    $SecondFunctionDefault         = $true
    $Global:SecondFunctionGlobal   = $true
    $Script:SecondFunctionScript   = $true
    $Local:SecondFunctionLocal     = $true
    $Private:SecondFunctionPrivate = $true
    Set-Variable SecondFunction1 $true -Scope 1
    Set-Variable SecondFunction2 $true -Scope 2
    Set-Variable SecondFunction3 $true -Scope 3
    "Second function default scope"
    Get-Variable First*,Second*,Third* |Show-Variable
    foreach($s in 1,2,3,'Global','Script','Local')
    {
        "Second function $s scope"
        Get-Variable First*,Second*,Third* -Scope $s |Show-Variable
    }
}
$SecondDefault         = $true
$Global:SecondGlobal   = $true
$Script:SecondScript   = $true
$Local:SecondLocal     = $true
$Private:SecondPrivate = $true
Set-Variable Second1 $true -Scope 1
Set-Variable Second2 $true -Scope 2
.\ScopeThird.ps1
ScopeSecondFunction
{
    $SecondBlockDefault         = $true
    $Global:SecondBlockGlobal   = $true
    $Script:SecondBlockScript   = $true
    $Local:SecondBlockLocal     = $true
    $Private:SecondBlockPrivate = $true
    Set-Variable SecondBlock1 $true -Scope 1
    Set-Variable SecondBlock2 $true -Scope 2
    Set-Variable SecondBlock3 $true -Scope 3
    "Second block default scope"
    Get-Variable First*,Second*,Third* |Show-Variable
    foreach($s in 1,2,3,'Global','Script','Local')
    {
        "Second block $s scope"
        Get-Variable First*,Second*,Third* -Scope $s |Show-Variable
    }
}.Invoke()
"Second default scope"
Get-Variable First*,Second*,Third* |Show-Variable
foreach($s in 1,2,'Global','Script','Local')
{
    "Second $s scope"
    Get-Variable First*,Second*,Third* -Scope $s |Show-Variable
}
```

### `ScopeThird.ps1`

```powershell
[CmdletBinding()] Param()
$ThirdDefault         = $true
$Global:ThirdPrivate  = $true
$Script:ThirdScript   = $true
$Local:ThirdLocal     = $true
$Private:ThirdPrivate = $true
Set-Variable Third1 $true -Scope 1
Set-Variable Third2 $true -Scope 2
Set-Variable Third3 $true -Scope 3
"Third default scope"
Get-Variable First*,Second*,Third* |Show-Variable
foreach($s in 1,2,3,'Global','Script','Local')
{
    "Third $s scope"
    Get-Variable First*,Second*,Third* -Scope $s |Show-Variable
}
```

Windows PowerShell Result
-------------------------

- PSVersion: 5.1.19041.1
- PSEdition: Desktop
- PSCompatibleVersions: 1.0, 2.0, 3.0, 4.0, 5.0, 5.1.19041.1
- BuildVersion: 10.0.19041.1
- CLRVersion: 4.0.30319.42000
- WSManStackVersion: 3.0
- PSRemotingProtocolVersion: 2.3
- SerializationVersion: 1.1.0.1

```text
Third default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondDefault = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- SecondLocal = True
- SecondScript = True
- Third1 = True
- Third2 = True
- Third3 = True
- ThirdDefault = True
- ThirdLocal = True
- ThirdPrivate = True
- ThirdScript = True
Third 1 scope
- SecondDefault = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Third 2 scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- Third2 = True
Third 3 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Third Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Third Script scope
- ThirdDefault = True
- ThirdLocal = True
- ThirdPrivate = True
- ThirdScript = True
Third Local scope
- ThirdDefault = True
- ThirdLocal = True
- ThirdPrivate = True
- ThirdScript = True
Second function default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunction2 = True
- SecondFunction3 = True
- SecondFunctionDefault = True
- SecondFunctionGlobal = True
- SecondFunctionLocal = True
- SecondFunctionPrivate = True
- SecondFunctionScript = True
- SecondGlobal = True
- SecondLocal = True
- SecondScript = True
- Third1 = True
- Third2 = True
- Third3 = True
- ThirdPrivate = True
Second function 1 scope
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second function 2 scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondFunction2 = True
- Third2 = True
Second function 3 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second function Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second function Script scope
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second function Local scope
- SecondFunctionDefault = True
- SecondFunctionLocal = True
- SecondFunctionPrivate = True
Second block default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock1 = True
- SecondBlock2 = True
- SecondBlock3 = True
- SecondBlockDefault = True
- SecondBlockGlobal = True
- SecondBlockLocal = True
- SecondBlockPrivate = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunction2 = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondFunctionScript = True
- SecondGlobal = True
- SecondLocal = True
- SecondScript = True
- Third1 = True
- Third2 = True
- Third3 = True
- ThirdPrivate = True
Second block 1 scope
- SecondBlock1 = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second block 2 scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondBlock2 = True
- SecondFunction2 = True
- Third2 = True
Second block 3 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second block Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second block Script scope
- SecondBlock1 = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second block Local scope
- SecondBlockDefault = True
- SecondBlockLocal = True
- SecondBlockPrivate = True
Second default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock1 = True
- SecondBlock2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunction2 = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondFunctionScript = True
- SecondGlobal = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
- Third2 = True
- Third3 = True
- ThirdPrivate = True
Second 1 scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondBlock2 = True
- SecondFunction2 = True
- Third2 = True
Second 2 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second Script scope
- SecondBlock1 = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second Local scope
- SecondBlock1 = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
First default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction2 = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third2 = True
- Third3 = True
- ThirdPrivate = True
First 1 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
First Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
First Script scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondBlock2 = True
- SecondFunction2 = True
- Third2 = True
First Local scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondBlock2 = True
- SecondFunction2 = True
- Third2 = True
```

PowerShell Core Result
----------------------

- PSVersion: 7.0.3
- PSEdition: Core
- GitCommitId: 7.0.3
- OS: Microsoft Windows 10.0.19041
- Platform: Win32NT
- PSCompatibleVersions: 1.0, 2.0, 3.0, 4.0, 5.0, 5.1.10032.0, 6.0.0, 6.1.0, 6.2.0, 7.0.3
- PSRemotingProtocolVersion: 2.3
- SerializationVersion: 1.1.0.1
- WSManStackVersion: 3.0

```text
Third default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondDefault = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- SecondLocal = True
- SecondScript = True
- Third1 = True
- Third2 = True
- Third3 = True
- ThirdDefault = True
- ThirdLocal = True
- ThirdPrivate = True
- ThirdScript = True
Third 1 scope
- SecondDefault = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Third 2 scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- Third2 = True
Third 3 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Third Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Third Script scope
- ThirdDefault = True
- ThirdLocal = True
- ThirdPrivate = True
- ThirdScript = True
Third Local scope
- ThirdDefault = True
- ThirdLocal = True
- ThirdPrivate = True
- ThirdScript = True
Second function default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondDefault = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction1 = True
- SecondFunction2 = True
- SecondFunction3 = True
- SecondFunctionDefault = True
- SecondFunctionGlobal = True
- SecondFunctionLocal = True
- SecondFunctionPrivate = True
- SecondFunctionScript = True
- SecondGlobal = True
- SecondLocal = True
- SecondScript = True
- Third1 = True
- Third2 = True
- Third3 = True
- ThirdPrivate = True
Second function 1 scope
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second function 2 scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondFunction2 = True
- Third2 = True
Second function 3 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second function Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second function Script scope
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second function Local scope
- SecondFunctionDefault = True
- SecondFunctionLocal = True
- SecondFunctionPrivate = True
Second block default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock1 = True
- SecondBlock2 = True
- SecondBlock3 = True
- SecondBlockDefault = True
- SecondBlockGlobal = True
- SecondBlockLocal = True
- SecondBlockPrivate = True
- SecondBlockScript = True
- SecondDefault = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction1 = True
- SecondFunction2 = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondFunctionScript = True
- SecondGlobal = True
- SecondLocal = True
- SecondScript = True
- Third1 = True
- Third2 = True
- Third3 = True
- ThirdPrivate = True
Second block 1 scope
- SecondBlock1 = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second block 2 scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondBlock2 = True
- SecondFunction2 = True
- Third2 = True
Second block 3 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second block Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second block Script scope
- SecondBlock1 = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second block Local scope
- SecondBlockDefault = True
- SecondBlockLocal = True
- SecondBlockPrivate = True
Second default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock1 = True
- SecondBlock2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondBlockScript = True
- SecondDefault = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction1 = True
- SecondFunction2 = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondFunctionScript = True
- SecondGlobal = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
- Third2 = True
- Third3 = True
- ThirdPrivate = True
Second 1 scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondBlock2 = True
- SecondFunction2 = True
- Third2 = True
Second 2 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
Second Script scope
- SecondBlock1 = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
Second Local scope
- SecondBlock1 = True
- SecondBlockScript = True
- SecondDefault = True
- SecondFunction1 = True
- SecondFunctionScript = True
- SecondLocal = True
- SecondPrivate = True
- SecondScript = True
- Third1 = True
First default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondBlock2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction2 = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third2 = True
- Third3 = True
- ThirdPrivate = True
First 1 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
First Global scope
- First1 = True
- FirstGlobal = True
- Second2 = True
- SecondBlock3 = True
- SecondBlockGlobal = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondFunction3 = True
- SecondFunctionGlobal = True
- SecondGlobal = True
- Third3 = True
- ThirdPrivate = True
First Script scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondBlock2 = True
- SecondFunction2 = True
- Third2 = True
First Local scope
- FirstDefault = True
- FirstLocal = True
- FirstPrivate = True
- FirstScript = True
- Second1 = True
- SecondBlock2 = True
- SecondFunction2 = True
- Third2 = True
```

PS7 includes visibility of SecondExpression3 and SecondExpressionGlobal at various levels.

Conclusions
-----------

- All non-private scopes are visible to the default reading scope within that scope or any child scopes.
- All scopes are visible at the named or numbered level, but a named or numbered scope will not include parent scopes.
- The default scope is:
  - `Global` at the PowerShell prompt or profile script.
  - `Script` at the root scope of a script or module.
  - `Local` in a function or script block.
- `Global`: The root scope.
- `Script`: The root of a script.
- `Local`: The current function or block.
- `Private`: The same as `Local`, except without visibility in child scopes.
- `0`: The same as `Local`
- `1`: The parent scope.
- `2`: The grandparent scope.
- *n*: The nth ancestor scope.

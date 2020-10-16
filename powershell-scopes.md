PowerShell Scopes
=================

Test Scripts
------------

### `ScopeFirst.ps1`

```powershell
[CmdletBinding()] Param()
$FirstDefault         = $true
$Global:FirstGlobal   = $true
$Script:FirstScript   = $true
$Local:FirstLocal     = $true
$Private:FirstPrivate = $true
Set-Variable First1 $true -Scope 1
.\ScopeSecond.ps1
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
}
$SecondDefault         = $true
$Global:SecondGlobal   = $true
$Script:SecondScript   = $true
$Local:SecondLocal     = $true
$Private:SecondPrivate = $true
Set-Variable Second1 $true -Scope 1
Set-Variable Second2 $true -Scope 2
ScopeSecondFunction
{
    $SecondExpressionDefault         = $true
    $Global:SecondExpressionGlobal   = $true
    $Script:SecondExpressionScript   = $true
    $Local:SecondExpressionLocal     = $true
    $Private:SecondExpressionPrivate = $true
    Set-Variable SecondExpression1 $true -Scope 1
    Set-Variable SecondExpression2 $true -Scope 2
    Set-Variable SecondExpression3 $true -Scope 3
}.Invoke()
.\ScopeThird.ps1
```

### `ScopeThird.ps1`

```powershell
[CmdletBinding()] Param()
function Show-Variable([Parameter(ValueFromPipeline)]$var)
{Process{"- $($var.Name) = $($var.Value)"}}
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
"Third 1 scope"
Get-Variable First*,Second*,Third* -Scope 1 |Show-Variable
"Third 2 scope"
Get-Variable First*,Second*,Third* -Scope 2 |Show-Variable
"Third 3 scope"
Get-Variable First*,Second*,Third* -Scope 3 |Show-Variable
"Third Global scope"
Get-Variable First*,Second*,Third* -Scope Global |Show-Variable
"Third Script scope"
Get-Variable First*,Second*,Third* -Scope Script |Show-Variable
"Third Local scope"
Get-Variable First*,Second*,Third* -Scope Local |Show-Variable
```

Result
------

```text
Third default scope
- First1 = True
- FirstDefault = True
- FirstGlobal = True
- FirstLocal = True
- FirstScript = True
- Second1 = True
- Second2 = True
- SecondDefault = True
- SecondExpression1 = True
- SecondExpression2 = True
- SecondExpression3 = True
- SecondExpressionGlobal = True
- SecondExpressionScript = True
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
- ThirdDefault = True
- ThirdLocal = True
- ThirdPrivate = True
- ThirdScript = True
Third 1 scope
- SecondDefault = True
- SecondExpression1 = True
- SecondExpressionScript = True
- SecondFunction1 = True
- SecondFunctionScript = True
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
- SecondExpression2 = True
- SecondFunction2 = True
- Third2 = True
Third 3 scope
- First1 = True
- FirstGlobal = True
- Second2 = True
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
```

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

PowerShell secret vault
=======================

The secret vault modules allow you to securely [store secrets][] using the Windows [DPAPI][] to
keep a `byte[]`, `string`, `SecureString`, `pscredential`, or `hashtable` to be able to access later.
It also allows annotating secrets with a hashtable of `string` names to values of type `string`, `int`,
or `datetime`, so you can provide context like where the secret is used, how to update it, when it
was generated, or when it expires.

[store secrets]: https://learn.microsoft.com/powershell/module/microsoft.powershell.secretmanagement/set-secretinfo
[DPAPI]: https://en.wikipedia.org/wiki/Data_Protection_API

Installing and setting up
-------------------------

You probably just want a single store with a simple name.
There are a number of configuration options you can set with [`Set-SecretStoreConfiguration`][],
which you may want to investigate fully to use effectively for automation, or however you need to in your environment.

[`Set-SecretStoreConfiguration`]: https://learn.microsoft.com/powershell/module/microsoft.powershell.secretstore/set-secretstoreconfiguration

```powershell
$VaultName = 'DefaultVault' # whatever name you want
Install-Module Microsoft.PowerShell.SecretManagement,Microsoft.PowerShell.SecretStore -Force
Register-SecretVault -Name $VaultName -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault
Set-SecretStoreConfiguration -Interaction Prompt
Test-SecretVault $VaultName
```

Setting a secret
----------------

All you really need to save is a name and a value, but providing more context may save you some effort later.

```powershell
# assuming the secret is currently on the clipboard
Set-Secret -Name GitHubToken -Secret "$(Get-Clipboard)" -Vault SecretStore -Metadata @{
    Description = 'A GitHub classic token'
    TokenName   = 'PowerShell token'
    Url         = 'https://github.com/settings/tokens'
    Generated   = Get-Date
    Expires     = (Get-Date).AddDays(90)
}
```

Listing secrets
---------------

You can also specify a vault name if you have more than one.

```powershell
Get-SecretInfo
```

Getting a secret value
----------------------

You'll also need to provide the vault name if there are secrets with the same name in separate vaults.

```powershell
# to get the encrypted value, when you can use a secure string or pscredential, &c
$value = Get-Secret -Name $secretname

# to get the unencrypted value, if you have to use a plaintext string, &c
$value = Get-Secret -Name $secretname -AsPlainText
```

Getting a secret's metadata
---------------------------

You'll also need to provide the vault name if there are secrets with the same name in separate vaults.

```powershell
Get-SecretInfo -Name $secretname |Select-Object -ExpandProperty Metadata
```

Deleting a secret
-----------------

```powershell
Remove-Secret -Name $secretname -Vault $VaultName
```

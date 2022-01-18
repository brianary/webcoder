Writing a PowerShell Core Module With F#, A Complete Guide
==========================================================

🆕 Updated with MSBuild automation recipes for your .fsproj file.

Preparation
-----------

It may be easier converting [scripts][] to a binary module than writing one from scratch, especially if you don't use a
lot of dynamic features. You can build a related group of cmdlets and get things working conceptually that way. You'll
have to find alternatives to techniques like using the Framework 4.x CLR or Windows-specific features, or switching to
reflection instead of accessing properties by variable names. If you find you inherently rely heavily on dynamic techniques,
you may not have a good candidate for a binary module (though a script module would still make sense).

Once you have some scripts you'd like to significantly improve the performance of, you'll need to consider a good name
for your module that accurately reflects their common functionality, and maximizes its discoverability when people search
for it, even for people that don't yet have a clear idea what their need is. You should also start thinking about a possible
icon or logo for the module.

[scripts]: https://github.com/brianary/scripts "brianary/scripts: Useful, general-purpose scripts"

Creating the Project
--------------------

Adapted from _[Writing PowerShell Modules in F# - Nate Lehman - Medium][@natelehman]_

Prerequisites:

- .NET Core SDK 3.1 or later ([older versions don't add version numbers to F# DLLs][versions])
- the [Pester][] PowerShell module (you can use [paket][] to install this to the repo, if you want)
- the [platyPS][] PowerShell module (not available through paket)

In PowerShell, set `$ModuleName` to the name of your module, and run these commands:

```powershell
cd (mkdir $ModuleName)
dotnet new sln
dotnet new classlib -lang 'F#' -f netcoreapp2.1 -o src/$ModuleName
dotnet sln add src/$ModuleName/$ModuleName.fsproj
pushd src/$ModuleName
dotnet add package PowerShellStandard.Library
New-ModuleManifest "$ModuleName.psd1"
'<helpItems schema="maml" xmlns="http://msh" />' |Out-File "$ModuleName.dll-Help.xml" utf8
popd
```

You may have to experiment with the framework (`-f`) version in your .fsproj file later, your dependencies could have
very specific requirements.

To the .fsproj project file, add `<Version>1.0.0</Version>` to the first `<PropertyGroup>`. Alternatively, you can add
`<VersionPrefix>1.0.0</VersionPrefix>`, and add the `--version-suffix` param to the build (`publish`) steps below and
skip the version sync check (the `if`), although this may make it more difficult to keep the module manifest version
up to date.

To include the module manifest and DLL help, add this within `<Project>`, next:

```xml
  <ItemGroup>
    <None Include="ModuleName.psd1" Pack="true" CopyToOutputDirectory="Always" />
    <None Include="ModuleName.dll-Help.xml" Pack="true" CopyToOutputDirectory="Always" />
  </ItemGroup>
```

Then fill in the _ModuleName_.psd1 [module manifest file][manifest] with some basic info, at least:

```powershell
@{
RootModule = 'ModuleName.dll'
ModuleVersion = '1.0.0'
CompatiblePSEditions = @('Core')
# https://guidgen.com/
GUID = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
Author = 'Your name'
Description = 'One-line elevator pitch for your module.'
PowerShellVersion = '6.0'
FunctionsToExport = @()
CmdletsToExport = @('Get-Foo')
VariablesToExport = @()
FileList = @('ModuleName.dll', 'ModuleName.dll-Help.xml')
PrivateData = @{
    PSData = @{
        Tags = @('Foo','Example')
        # probably your GitHub license URL:
        LicenseUri = 'http://github.com/example/test/blob/master/LICENSE'
        # probably your GitHub repo:
        ProjectUri = 'http://github.com/example/test/'
        # maybe a logo you added to your GitHub repo:
        IconUri = 'http://raw.githubusercontent.com/example/test/master/icon.svg?sanitize=true'
    }
}
}
```

You may need to include more values in the manifest for certain dependencies and integrations.

[@natelehman]: https://medium.com/@natelehman/writing-powershell-modules-in-f-ed52704d97ed
[versions]: https://webcoder.info/version-odyssey.html
[paket]: https://fsprojects.github.io/Paket/
[platyPS]: https://github.com/PowerShell/platyPS
[manifest]: https://docs.microsoft.com/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest

Writing Cmdlets
---------------

You can delete _Library.fs_ and the reference to it in your _.fsproj_ file, which is where you'll add
references to your cmdlets.

For each cmdlet you want to include in the module, create a class file and add it to the project.

```fsharp
namespace ModuleName // use your module name for the namespace

open System.Management.Automation // PowerShell attributes come from this namespace

/// Describe cmdlet in /// comments
/// Cmdlet attribute takes verb names as strings or verb enums
/// Output type works the same as for PowerShell cmdlets
[<Cmdlet("Get", "Foo")>]
[<OutputType(typeof<string>)>]
type GetFooCommand () =
    inherit PSCmdlet ()

    // cmdlet parameters are properties of the class

    /// Describe property params in /// comments
    /// Parameter, Validate, and Alias attributes work the same as PowerShell params
    [<ValidateNotNullOrEmpty>]
    [<ValidatePattern(@"\w+")>]
    [<Alias("Key")>]
    member val Name : string = "" with get, set

    [<Parameter(ValueFromPipeline=true)>]
    [<ValidateNotNull>]
    member val InputObject : obj = null with get, set

    // optional: setup before pipeline input starts (e.g. Name is set, InputObject is not)
    override x.BeginProcessing () =
        base.BeginProcessing ()

    // optional: handle each pipeline value (e.g. InputObject)
    override x.ProcessRecord () =
        base.ProcessRecord ()

    // optional: finish after all pipeline input
    override x.EndProcessing () =
        x.WriteObject x.Name
        base.EndProcessing ()
```

Create [Pester][] tests for each cmdlet as needed, probably named _ModuleName_.Tests.ps1 if you intend to keep your
tests in a single file, but Pester test files need to at least end with ".Tests.ps1".

```powershell
Describe 'ModuleName' {
    Context 'ModuleName module' {
        It "Given the ModuleName module, it should have a nonzero version" {
            $m = Get-Module ModuleName
            $m.Version |Should -Not -Be $null
            $m.Version.Major |Should -BeGreaterThan 0
        }
    }
    Context 'Get-Foo cmdlet' {
        It "Given a name '<Name>', '<Expected>' should be returned." -TestCases @(
            @{ Name = 'Hello, world'; Expected = 'Hello, world' }
            @{ Name = 'Zaphod'; Expected = 'Zaphod' }
        ) {
            Param($Name,$Expected)
            Get-Foo $Name |Should -BeExactly $Expected
        }
    }
}
```

You may also set up your GitHub repo at this point with a license and readme, maybe setting up a .NET Core [action][]
for CI, and maybe add an _[.editorconfig][]_ file, maybe also _.gitconfig_, _.gitattributes_ for [Linguist][] and other
settings, _CODEOWNERS_, _LICENSE_, _CONTRIBUTING_, and issue/PR templates.

[Pester]: https://github.com/Pester/Pester/wiki
[action]: https://github.com/features/actions "GitHub Actions"
[.editorconfig]: https://editorconfig.org/
[Linguist]: https://github.com/github/linguist#overrides

Building the Module, Debug and Test Phase
-----------------------------------------

In PowerShell, you can do this:

```powershell
$ModuleName = Resolve-Path ./src/* |Split-Path -Leaf
Import-LocalizedData module -BaseDirectory (Resolve-Path ./src/*) -FileName "$ModuleName.psd1"
$err = 'Module manifest (.psd1) version does not match project (.fsproj) version.'
if($module.ModuleVersion -ne (Select-Xml '//Version/text()' (Resolve-Path ./src/*/*.fsproj)).Node.Value){throw$err}
dotnet publish
cp (Resolve-Path ./src/*/bin/Debug/*/publish/FSharp.Core.dll) (Resolve-Path ./src/*/bin/Debug/*/) -vb
rm (Resolve-Path ./src/*/bin/Debug/*/) -Recurse -Force -vb
Import-Module (Resolve-Path ./src/*/bin/Debug/*/*.psd1)
Invoke-Pester
```

You can also modify your .fsproj file to do this automatically when you run `dotnet publish`, after removing
`<Version>1.0.0</Version>` first:

```xml
  <Target Name="GetVersion" BeforeTargets="CoreCompile">
    <Exec Command='pwsh -nol -noni -nop -c "&amp; { Import-LocalizedData -BindingVariable m -FileName $(MSBuildProjectName); (gv m -va).ModuleVersion }"'
      ConsoleToMSBuild="true" IgnoreExitCode="true" IgnoreStandardErrorWarningFormat="true">
      <Output TaskParameter="ConsoleOutput" PropertyName="Version" />
    </Exec>
  </Target>

  <Target Name="Pester" DependsOnTargets="Publish" Condition="'$(Configuration)' == 'Debug'">
    <Copy SourceFiles="$(OutputPath)\publish\FSharp.Core.dll"
      DestinationFolder="$(OutputPath)" />
    <Exec Command='pwsh -nol -noni -nop -c "&amp; { cd ..\..; Invoke-Pester }"'
      IgnoreExitCode="true" IgnoreStandardErrorWarningFormat="true" />
  </Target>
```

Instead of specifying the version in both the module manifest and the project file, the **GetVersion** target reads
the manifest and uses that version in the project file. The **Pester** target runs your tests automatically,
but it may need some additional integration work for your CI/build system to properly interpret the results.

> **📝 Note**
>
> Since `$` can be interpolated by the shell on some systems, it should be avoided when calling PowerShell one-liners this way.
> The **GetVersion** target does this by using `(gv m -va)` (`Get-Variable -Name m -ValueOnly`) instead of `$m`.

Update platyPS Documentation
----------------------------

Run the following PowerShell to set up the platyPS help templates.
Anytime you add cmdlets to your module, or change parameters in your cmdlets, run this again:

```powershell
$envPath,$env:Path = $env:Path,'' # avoid pulling duplicate cmdlets into documentation
New-MarkdownHelp -Module ModuleName -OutputFolder .\docs -ErrorAction SilentlyContinue
$env:Path = $envPath
Update-MarkdownHelp docs
```

The Markdown files in the _./docs/_ folder are templates that need to be edited to add descriptions
and examples. Run this PowerShell cmdlet anytime the templates change:

```powershell
New-ExternalHelp docs -OutputPath (Resolve-Path ./src/*/)
```

You can do all of this automatically by adding this to your .fsproj file:

```xml
  <Target Name="Documentation" DependsOnTargets="Publish">
    <Exec Command='pwsh -nol -noni -nop -c "&amp; { Import-Module (Resolve-Path $(OutputPath)*.psd1); New-MarkdownHelp -Module $(MSBuildProjectName) -OutputFolder ..\..\docs -ea 0; Update-MarkdownHelp ..\..\docs; New-ExternalHelp ..\..\docs -OutputPath . -Force }"'
      IgnoreExitCode="true" IgnoreStandardErrorWarningFormat="true" />
  </Target>
```

In your repo's readme, you can link to each Markdown template, since they are perfectly legible.

If your logo/icon is ready, add that near the top of your readme, too.

Building the Module, Release and Publish Phase
----------------------------------------------

Before you can publish to the [PowerShellGallery][], you'll have to create an account and set up
and copy your API key, which can have very narrowly defined permissions.

To save an encrypted file with your API key using the Windows [DPAPI][], run this PowerShell:

```powershell
(Get-Credential API-key -Message 'Enter your API key as the password').Password |
    ConvertFrom-SecureString |Out-File ./.apikey utf8
```

Once your tests pass and you are ready to publish, close all PowerShell sessions, then start a new one
and run this PowerShell:

```powershell
$ModuleName = Resolve-Path ./src/* |Split-Path -Leaf
Import-LocalizedData module -BaseDirectory (Resolve-Path ./src/*) -FileName "$ModuleName.psd1"
$err = 'Module manifest (.psd1) version does not match project (.fsproj) version.'
if($module.ModuleVersion -ne (Select-Xml '//Version/text()' (Resolve-Path ./src/*/*.fsproj)).Node.Value){throw $err}
dotnet publish -c Release
cp (Resolve-Path ./src/*/bin/Release/*/publish/FSharp.Core.dll) (Resolve-Path ./src/*/bin/Release/*/) -vb
rm (Resolve-Path ./src/*/bin/Release/*/) -Recurse -Force -vb
$installpath = Join-Path ($env:PSModulePath -split ';' -like '*\Users\*') $ModuleName -add $module.ModuleVersion
cp (Resolve-Path ./src/*/bin/Release/*/*) $installpath -vb
Import-Module $ModuleName
$key = (New-Object PSCredential apikey,
    (Get-Content ./.apikey |ConvertTo-SecureString)).GetNetworkCredential().Password
Publish-Module -Name $ModuleName -NuGetApiKey $key
```

To make all this automatic when you run `dotnet publish -c Release`, add this to your .fsproj file.

```xml
  <ItemGroup>
    <PSModulePath Include="$(PSModulePath)" Exclude="C:\Program Files\**;C:\Windows\**" />
  </ItemGroup>

  <Target Name="PublishModule" DependsOnTargets="Publish" Condition="'$(Configuration)' == 'Release'">
    <RemoveDir Directories="@(PSModulePath->'%(FullPath)\$(MSBuildProjectName)')" />
    <Copy SourceFiles="$(OutputPath)\publish\FSharp.Core.dll" DestinationFolder="$(OutputPath)" />
    <ItemGroup><ModuleFiles Include="$(OutputPath)\*" /></ItemGroup>
    <Copy SourceFiles="@(ModuleFiles)" DestinationFolder="@(PSModulePath->'%(FullPath)\$(MSBuildProjectName)\$(Version)')" />
    <Error Text="To publish, first run: (Get-Credential API-key -Message &#x27;Enter your API key&#x27;).Password |ConvertFrom-SecureString |Out-File .\.apikey utf8"
      Condition="!Exists('..\..\.apikey')" />
    <Exec Command='pwsh -nol -noni -nop -c "&amp; { (New-Object PSCredential apikey,(Get-Content ..\..\.apikey |ConvertTo-SecureString)).GetNetworkCredential().Password }"'
      ConsoleToMSBuild="true" IgnoreExitCode="true" IgnoreStandardErrorWarningFormat="true" Condition="Exists('..\..\.apikey')">
      <Output TaskParameter="ConsoleOutput" PropertyName="ApiKey" />
    </Exec>
    <Exec Command='pwsh -nol -noni -nop -c "&amp; { Import-Module $(MSBuildProjectName); Publish-Module -Name $(MSBuildProjectName) -NuGetApiKey $(ApiKey) }"'
      IgnoreExitCode="true" IgnoreStandardErrorWarningFormat="true" Condition="Exists('..\..\.apikey')" />
  </Target>
```

[PowerShellGallery]: https://www.powershellgallery.com/ "The central repository for PowerShell content"
[DPAPI]: https://wikipedia.org/wiki/Data_Protection_API "Data Protection Application Programming Interface"

Future Development
------------------

As you change your cmdlets, be sure to add or modify your tests, update your documentation, and increment your
version numbers (keep those versions in your module manifest (.psd1) and project (.fsproj) in sync).
Keep the list of exported cmdlets, functions, and variables up to date in your manifest.
Make sure the tags in your manifest continue to accurately reflect the functionality of your module, too.

You might want to refine that icon over time, too.

HTH :)

See also [A .NET Core/Standard Versioning Odyssey](version-odyssey.md) describes my process for one very difficult part of that module.

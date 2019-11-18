Writing a PowerShell Core Module With F#, A Complete Guide
==========================================================

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
dotnet new classlib -lang 'F#' -f netstandard2.1 -o src/$ModuleName
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
CompatiblePSVersions = @('Core')
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

Create [Pester][] tests for each cmdlet as needed.

```powershell
Describe 'ModuleName' {
    Context 'ModuleName module' {
        It "Given the ModuleName module, it should have a nonzero version" {
            $m = Get-Module SelectXmlExtensions
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
for CI, and maybe add a _.gitignore_ and an _[.editorconfig][]_ file.

[Pester]: https://github.com/Pester/Pester/wiki
[action]: https://github.com/features/actions "GitHub Actions"
[.editorconfig]: https://editorconfig.org/

Building the Module, Debug and Test Phase
-----------------------------------------

In PowerShell again:

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

Update platyPS Documentation
----------------------------

Run the following PowerShell to set up the platyPS help templates.
Anytime you add cmdlets to your module, or change parameters in your cmdlets, run this again:

```powershell
$envPath,$env:Path = $env:Path,'' # avoid pulling duplicate cmdlets into documentation
New-MarkdownHelp -Module SelectXmlExtensions -OutputFolder .\docs -ErrorAction SilentlyContinue
$env:Path = $envPath
Update-MarkdownHelp docs
```

The Markdown files in the _./docs/_ folder are templates that need to be edited to add descriptions
and examples. Run this PowerShell cmdlet anytime the templates change:

```powershell
New-ExternalHelp docs -OutputPath (Resolve-Path ./src/*/)
```

In your repo's readme, you can link to each Markdown template, since they are perfectly legible.

If your logo/icon is ready, add that near the top of your readme, too.

Building the Module, Release and Publish Phase
----------------------------------------------

Before you can publish to the [PowerShellGallery][], you'll have to create an account and set up
and copy your API key, which can have very narrowly defined permissions.

Once your tests pass and you are ready to publish, close all PowerShell sessions, then start a new one
and run this PowerShell:

```powershell
$key = '<< your API key goes here >>'
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
Publish-Module -Name $ModuleName -NuGetApiKey $key
```

Future Development
------------------

As you change your cmdlets, be sure to add or modify your tests, update your documentation, and increment your
version numbers (keep those versions in your module manifest (.psd1) and project (.fsproj) in sync).
Keep the list of exported cmdlets, functions, and variables up to date in your manifest.
Make sure the tags in your manifest continue to accurately reflect the functionality of your module, too.

You might want to refine that icon over time, too.

HTH :)

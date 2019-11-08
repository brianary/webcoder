A .NET Core/Standard Versioning Odyssey
=======================================

<style>
img:first-of-type {float: right; margin: 1ex;}
h6 {font-size: 12pt; margin-bottom: 0; color: #636363;}
summary {color:blue; text-decoration: underline;}
</style>

![SelectXmlExtensions.dll: no version numbers](images/version-missing.png)

While creating my first binary PowerShell module, which just happened to also be my first .NET Core/Standard project,
I ran into trouble trying to set the assembly version info on the DLL.

```text
PS C:\> ls SelectXmlExtensions.dll |% VersionInfo

ProductVersion   FileVersion      FileName
--------------   -----------      --------
                                  SelectXmlExtensions.dll
```

The aborted [xproj][] / [project.json] formats for early .NET Core versions polluted my search results.
Those also meant that I'd have to be pretty careful about how recent any proposed solutions were, particularly
since I was using the .NET Core SDK 3.0. But how old was too old?

I found SDK issues [#967][] and [#1098][], and I tried the whole version prefix & suffix thing, updating
my fsproj with `<VersionPrefix>1.0.0</VersionPrefix>` and ran `dotnet build --version-suffix beta`, but
despite being the most up-to-date info, this didn't work.
Sometimes Microsoft does a great job of documenting stuff that won't be released for some time, so maybe
I had to watch out for info that was too new, as well.

I found [more][] [suggestions][], so I added `<Version>1.0.0</Version>` to my fsproj and rebuilt,
I added `/p:Version=1.0.0` or `/p:AssemblyVersion=1.0.0` to the command line and rebuilt, and nothing worked.
I tried creating a [Directory.Build.props][]
I even tried creating an _AssemblyInfo.fs_ file which I hadn't done by hand for a while, and added
`<GenerateAssemblyInfo>false</GenerateAssemblyInfo>` and `<Compile Include="Properties\AssemblyInfo.fs" />`
to the fsproj and tried again, but nothing changed.

###### Directory.Build.props

```xml
<Project>
  <PropertyGroup>
    <GenerateAssemblyInfo>false</GenerateAssemblyInfo>
  </PropertyGroup>
</Project>
```

###### Properties\AssemblyInfo.fs

```fsharp
namespace SelectXmlExtensions
open System.Reflection
open System.Runtime.CompilerServices
open System.Runtime.InteropServices
[<assembly: AssemblyVersion("1.0.0.0")>]
[<assembly: AssemblyFileVersion("1.0.0.0")>]
do()
```

What was really puzzling me was that it seemed like the people getting these answers were successful,
but they were probably using a different version of the tools than I was.
Sometimes I would find [unanswered questions][unanswered], so maybe I wasn't alone with this problem.

I'd gradually built a pretty decent script for rerunning clean builds, though.

I found a what seemed to be [a pretty definitive article][corever] on all of this, but it didn't help either.

I decided that I'd made a pretty thorough effort, so I filed [an issue][issue].
I was a little surprised when a fix was promised in .NET Core 3.1.
It made me wonder if I could use an older feature of an older .NET Core toolset to work around the problem while I waited for the fix.

I uninstalled the .NET Core SDK 3.0.100, then installed 2.2.402, and even 2.1.802, but it didn't seem to
be a problem with the version of the tooling. One or more of these methods should have worked in 2.x.

Then I decided to try one more thing.

It didn't work. But now I know that I'll have to wait for a fix, or manually add version info
with some kind of [external tool][].

```samp
C:\temp> pushd (mkdir LibCS).FullName
C:\temp\LibCS> dotnet new sln
The template "Solution File" was created successfully.
C:\temp\LibCS> dotnet new classlib
The template "Class library" was created successfully.
Processing post-creation actions...
  Restore completed in 194.91 ms for C:\temp\LibCS\LibCS.csproj.

Restore succeeded.

C:\temp\LibCS> dotnet sln add LibCS.csproj
Project `LibCS.csproj` added to the solution.
Microsoft (R) Build Engine version 16.3.0+0f4c62fea for .NET Core
Copyright (C) Microsoft Corporation. All rights reserved.

  Restore completed in 27.99 ms for C:\temp\LibCS\LibCS.csproj.
  LibCS -> C:\temp\LibCS\bin\Debug\netstandard2.0\LibCS.dll
  LibCS -> C:\temp\LibCS\bin\Debug\netstandard2.0\publish\
C:\temp\LibCS> (ls -r -fi LibCS.dll).VersionInfo

ProductVersion   FileVersion      FileName
--------------   -----------      --------
1.0.0            1.0.0.0          C:\temp\LibCS\bin\Debug\netstandard2.0\LibCS.dll
1.0.0            1.0.0.0          C:\temp\LibCS\bin\Debug\netstandard2.0\publish\LibCS.dll
1.0.0            1.0.0.0          C:\temp\LibCS\obj\Debug\netstandard2.0\LibCS.dll


C:\temp\LibCS> popd
C:\temp> pushd (mkdir LibFS).FullName
C:\temp\LibFS> dotnet new sln
The template "Solution File" was created successfully.
C:\temp\LibFS> dotnet new classlib -lang 'F#'
The template "Class library" was created successfully.

Processing post-creation actions...
Running 'dotnet restore' on C:\temp\LibFS\LibFS.fsproj...
  Restore completed in 210.12 ms for C:\temp\LibFS\LibFS.fsproj.

Restore succeeded.

C:\temp\LibFS> dotnet sln add LibFS.fsproj
Project `LibFS.fsproj` added to the solution.
C:\temp\LibFS> dotnet publish
Microsoft (R) Build Engine version 16.3.0+0f4c62fea for .NET Core
Copyright (C) Microsoft Corporation. All rights reserved.

  Restore completed in 45.47 ms for C:\temp\LibFS\LibFS.fsproj.
  LibFS -> C:\temp\LibFS\bin\Debug\netstandard2.0\LibFS.dll
  LibFS -> C:\temp\LibFS\bin\Debug\netstandard2.0\publish\
C:\temp\LibFS> (ls -r -fi LibFS.dll).VersionInfo

ProductVersion   FileVersion      FileName
--------------   -----------      --------
                                  C:\temp\LibFS\bin\Debug\netstandard2.0\LibFS.dll
                                  C:\temp\LibFS\bin\Debug\netstandard2.0\publish\LibFS.dll
                                  C:\temp\LibFS\obj\Debug\netstandard2.0\LibFS.dll

```

With this broken for _so long_, on top of the lack of F# support in tools like [Add-Type][] and [xsd.exe],
Microsoft has to earn back a lot of credibility before claiming F# as a first-class language
with full support again.

[xproj]: https://stackoverflow.com/questions/37409168/whys-are-assemby-attributes-like-assemblyversion-missing-in-xproj ".net - Whys are Assemby Attributes like AssemblyVersion missing in xproj? - Stack Overflow"
[project.json]: https://stackoverflow.com/questions/39163558/do-i-need-assemblyinfo-while-working-with-net-core "Do I need AssemblyInfo while working with .NET Core? - Stack Overflow"
[#967]: https://github.com/dotnet/sdk/issues/967 "AssemblyInfo generation skipped on incremental build even if Version/VersionSuffix changes · Issue #967 · dotnet/sdk"
[#1098]: https://github.com/dotnet/sdk/issues/1098 "Question: How to version dotnet core assemblies · Issue #1098 · dotnet/sdk"
[more]: https://stackoverflow.com/questions/42138418/equivalent-to-assemblyinfo-in-dotnet-core-csproj "visual studio - Equivalent to AssemblyInfo in dotnet core/csproj - Stack Overflow"
[suggestions]: https://stackoverflow.com/questions/43274254/setting-the-version-number-for-net-core-projects-csproj-not-json-projects "continuous integration - Setting the version number for .NET Core projects - CSPROJ - not JSON projects - Stack Overflow"
[Directory.Build.props]: https://docs.microsoft.com/visualstudio/msbuild/customize-your-build "Customize your build - Visual Studio | Microsoft Docs"
[unanswered]: https://stackoverflow.com/questions/56236610/net-core-publish-as-exe-how-to-put-assembly-infos-into-exe "c# - .NET Core publish as exe: How to put assembly infos into exe - Stack Overflow"
[corever]: https://andrewlock.net/version-vs-versionsuffix-vs-packageversion-what-do-they-all-mean/ "Version vs VersionSuffix vs PackageVersion: What do they all mean?"
[issue]: https://github.com/dotnet/cli/issues/12910 "Can't find any way to set version · Issue #12910 · dotnet/cli"
[Add-Type]: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/add-type "Adds a Microsoft .NET Core class to a PowerShell session."
[xsd.exe]: https://docs.microsoft.com/dotnet/standard/serialization/xml-schema-definition-tool-xsd-exe#xsd-file-options "XML Schema Definition Tool (Xsd.exe) | Microsoft Docs"
[external tool]: https://stackoverflow.com/questions/284258/how-do-i-set-the-version-information-for-an-existing-exe-dll "windows - How do I set the version information for an existing .exe, .dll? - Stack Overflow"

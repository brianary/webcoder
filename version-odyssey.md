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

<details><summary>What finally worked?</summary>

_[…to be concluded soon…]_

</details>

[xproj]: https://stackoverflow.com/questions/37409168/whys-are-assemby-attributes-like-assemblyversion-missing-in-xproj
[project.json]: https://stackoverflow.com/questions/39163558/do-i-need-assemblyinfo-while-working-with-net-core
[#967]: https://github.com/dotnet/sdk/issues/967
[#1098]: https://github.com/dotnet/sdk/issues/1098
[more]: https://stackoverflow.com/questions/42138418/equivalent-to-assemblyinfo-in-dotnet-core-csproj
[suggestions]: https://stackoverflow.com/questions/43274254/setting-the-version-number-for-net-core-projects-csproj-not-json-projects
[Directory.Build.props]: https://docs.microsoft.com/visualstudio/msbuild/customize-your-build
[unanswered]: https://stackoverflow.com/questions/56236610/net-core-publish-as-exe-how-to-put-assembly-infos-into-exe
[corever]: https://andrewlock.net/version-vs-versionsuffix-vs-packageversion-what-do-they-all-mean/
[issue]: https://github.com/dotnet/cli/issues/12910

⌨️🖥️
====

Research/Articles
-----------------

- [Windows PowerShell to PowerShell Core](wps-to-psc.md) is how to deal with breaking changes in the new PowerShell.
- [Writing a PowerShell Core Module With F#, A Complete Guide](fspsmodule.md) fully explains how to create a binary
  PowerShell module in F#, considering branding, source control, tests, documentation, and publication.
- [Setext vs atx Header Styles in Markdown](markdown-headers.md) is an even-handed analysis of the available Markdown
  header styles.

References
----------

- [Windows Key Shortcuts for Windows 10](windowskey.md) has all the Windows Key shortcuts.
- [Two Letter ISO/FIPS/NUTS Country Codes with Currency, Language, and Subregion Codes](countries.html) puts all the
  two-letter internationalization codes from several standards on the same grid.
- [C# History](csharp-history.html) helps to determine what version of C# is required for specific language features.
- [XSLT 2.0/XPath 2.0 QuickRef](xslt2.md) and [XML Schema QuickRef](xsd.md) for those of us that still have to work with
  a lot of XML.
- [SQL Server Datatypes QuickRef](mssqldatatypes.html) is something I put together in the '90s.
- [Important Standards](standards.md) the specs and standards that make the Internet (and related stuff) work.

PowerShell & F#
---------------

My [Detextive][], [SelectXmlExtensions][], [CertAdmin][], or [Pretendpoint][] PowerShell modules can be installed by runnning
`Install-Module SelectXmlExtensions` (for example). [DotNetGlobalToolProvider][] is a trivial exercise in creating a OneGet
package.

My most active repo is [scripts](https://github.com/brianary/scripts), which is mostly PowerShell, but also some F# and other
(primarily Windows) stuff.

I contribute a small amount to several community projects, as well.

[Detextive]: https://github.com/brianary/Detextive "Investigates data to determine what the textual characteristics are."
[SelectXmlExtensions]: https://powershellgallery.com/packages/SelectXmlExtensions/ "PowerShell cmdlets that Select-Xml can compose into pipelines"
[CertAdmin]: https://www.powershellgallery.com/packages/CertAdmin/ "Manage certificates and their permissions on a Windows server."
[Pretendpoint]: https://www.powershellgallery.com/packages/Pretendpoint/ "Pretend Endpoint, the disposable web server."
[DotNetGlobalToolProvider]: https://github.com/brianary/DotNetGlobalToolProvider "OneGet package provider for dotnet global tools."

Some Old Perl Modules
---------------------

- [Lingua-EN-Nickname](https://github.com/brianary/Lingua-EN-Nickname)
& [Lingua-EN-MatchNames](https://github.com/brianary/Lingua-EN-MatchNames) allow matching on human names.
As seen in [The Perl Journal](http://www.foo.be/docs/tpj/issues/vol5_3/tpj0503-0009.html), reprinted as
chapter 21 of O'Reilly's [Games, Diversions & Perl Culture](http://shop.oreilly.com/product/9780596003128.do).
- [Statistics-Lite](https://github.com/brianary/Statistics-Lite), a pretty basic stats package that for some
reason has been used all over the world, in cancer research, and by NASA.

Some Old Windows Projects
-------------------------

- [dbscope](https://github.com/brianary/dbscope), a simple GUI to browse databases.
- [magicnumber-lite](https://github.com/brianary/magicnumber-lite), a sort of simplified Windows port of
  [file(1)](http://linux.die.net/man/1/file), which uses
  [magic numbers](http://en.wikipedia.org/wiki/List_of_file_signatures) in data to determine the format of the data stream.
  (Zip data starts with "PK". Java class files start with 0xCAFEBABE.)

<footer>
    <a rel="me" href="https://mastodon.spotek.io/@brianary">🐘</a>
    <a href="Friday.ics" title="#AntepenultimateFriday">🍸</a>
</footer>

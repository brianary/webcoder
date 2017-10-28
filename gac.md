Installing To the Global Assembly Cache (GAC)
=============================================

[How to: Install an Assembly into the Global Assembly Cache](http://msdn.microsoft.com/en-us/library/dkkx7f79.aspx)

---

> **Note:** In earlier versions of the .NET Framework, the [Shfusion.dll](http://msdn.microsoft.com/en-us/library/34149zk3.aspx) Windows shell extension enabled you to install assemblies by dragging them in File Explorer. Beginning with the .NET Framework 4, Shfusion.dll is obsolete.

---

> **Note:** Gacutil.exe is only for development purposes and should not be used to install production assemblies into the global assembly cache.

---

_(Also: Yikes, there are multiple GACs (by CLR, and by 32/64-bit processor architecture): [.NET 4.0 has a new GAC, why? - Stack Overflow](http://stackoverflow.com/questions/2660355/net-4-0-has-a-new-gac-why))_

Alternative? [Tip/Trick: Creating Packaged ASP.NET Setup Programs with VS 2005 - ScottGu's Blog](http://weblogs.asp.net/scottgu/archive/2007/06/15/tip-trick-creating-packaged-asp-net-setup-programs-with-vs-2005.aspx)

Not for VS2012: [Visual Studio setup projects (vdproj) will not ship with future versions of VS - Buck Hodges - Site Home - MSDN Blogs](http://blogs.msdn.com/b/buckh/archive/2011/03/17/visual-studio-setup-projects-vdproj-will-not-ship-with-future-versions-of-vs.aspx)

_(See [Bring back the basic setup and deployment project type Visual Studio Installer. – Customer Feedback for Microsoft](https://visualstudio.uservoice.com/forums/121579-visual-studio/suggestions/3041773-bring-back-the-basic-setup-and-deployment-project-))_

Replacement for the alternative: [http://wixtoolset.org/](http://wixtoolset.org/)(**not** [http://www.wix.com/](http://www.wix.com/)) ("[Standard Custom Actions](http://wix.sourceforge.net/manual-wix3/standard_customactions.htm)"?):
[Installing Assemblies for Runtime and Design-time Use - Heath Stewart's blog - Site Home - MSDN Blogs](http://blogs.msdn.com/b/heaths/archive/2006/09/20/installing-assemblies-for-runtime-and-design_2d00_time-use.aspx) (GAC install with WIX.)

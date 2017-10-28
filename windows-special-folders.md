Windows Special Folders Support
===============================

Windows system/special folders, unlike Linux (which has [a consistent, reliable filesystem heirarchy](http://www.pathname.com/fhs/)), can be in all kinds of crazy custom locations, or use localized text.

As a consequence, you cannot simply use a path to a special folder. You have to look it up first. Nearly all Microsoft APIs/platforms/technologies provide some way to look up these special folders. What's even more complicated is that these lookups seem to be about as varied as the folder names themselves.

Not only do newer technologies reflect completely new folders, as could be expected, but each API seems to provide access to a different subset of special folders, and use different names/keys for the folders, and sometimes provide multiple partial lists via different methods/lookups/constants. Say you want to look up the location of the Windows Recycle Bin, does your API refer to this as CSIDL\_BITBUCKET or FOLDERID\_RecycleBinFolder, or does it provide any access to it at all?

This reference aims to provide an overview of whether your API supports a given special folder, and where to look for it.

Windows Special Folder Environment Variables
--------------------------------------------

* ALLUSERSPROFILE
* APPDATA
* CommonProgramFiles
* CommonProgramFiles(x86)
* CommonProgramFilesW6432

* ProgramFiles
* ProgramFiles(x86)
* ProgramFilesW6432

* SystemDrive
* SystemRoot
* TEMP
* TMP
* USERPROFILE
* windir

Windows XP Embedded uses [numeric environment variables](http://msdn.microsoft.com/en-us/library/ms933062.aspx).

.NET [`System.Environment.SpecialFolder`][env] Enumeration
----------------------------------------------------------

* ApplicationData
* CommonApplicationData
* LocalApplicationData
* Cookies
* Desktop
* Favorites
* History
* InternetCache
* Programs
* MyComputer
* MyMusic
* MyPictures
* Recent
* SendTo
* StartMenu
* Startup
* System
* Templates
* DesktopDirectory
* Personal
* MyDocuments
* ProgramFiles
* CommonProgramFiles

[env]: http://msdn.microsoft.com/en-us/library/system.environment.specialfolder.aspx

.NET [`System.IO.Path`][path] Methods
-------------------------------------

* GetTempPath()

[path]: http://msdn.microsoft.com/en-us/library/system.io.path.aspx

Windows Scripting Host [`WshShell.SpecialFolders`][shell] Collection
--------------------------------------------------------------------

* AllUsersDesktop
* AllUsersStartMenu
* AllUsersPrograms
* AllUsersStartup
* Desktop
* Favorites
* Fonts
* MyDocuments
* NetHood
* PrintHood
* Programs
* Recent
* SendTo
* StartMenu
* Startup
* Templates

[shell]: http://msdn.microsoft.com/en-us/library/0ea7b5xe%28VS.85%29.aspx

Windows Scripting Host [`FileSystemObject.GetSpecialFolder()`][fso] Method Parameters
-------------------------------------------------------------------------------------

* SystemFolder
* TemporaryFolder
* WindowsFolder

[fso]: http://msdn.microsoft.com/en-us/library/a72y2t1c%28VS.85%29.aspx

Windows CLSID GUIDs
-------------------

| Folder                   | CLSID                                    |
| ------------------------ | ---------------------------------------- |
| Administrative Tools     | `{D20EA4E1-3957-11d2-A40B-0C5020524153}` |
| Briefcase                | `{85BBD920-42A0-1069-A2E4-08002B30309D}` |
| Control Panel            | `{21EC2020-3AEA-1069-A2DD-08002B30309D}` |
| Fonts                    | `{D20EA4E1-3957-11d2-A40B-0C5020524152}` |
| History                  | `{FF393560-C2A7-11CF-BFF4-444553540000}` |
| Inbox                    | `{00020D75-0000-0000-C000-000000000046}` |
| Microsoft Network        | `{00028B00-0000-0000-C000-000000000046}` |
| My Computer              | `{20D04FE0-3AEA-1069-A2D8-08002B30309D}` |
| My Documents             | `{450D8FBA-AD25-11D0-98A8-0800361B1103}` |
| My Network Places        | `{208D2C60-3AEA-1069-A2D7-08002B30309D}` |
| Network Connections      | `{7007ACC7-3202-11D1-AAD2-00805FC1270E}` |
| Printers and Faxes       | `{2227A280-3AEA-1069-A2DE-08002B30309D}` |
| Recycle Bin              | `{645FF040-5081-101B-9F08-00AA002F954E}` |
| Scanners and Cameras     | `{E211B736-43FD-11D1-9EFB-0000F8757FCD}` |
| Scheduled Tasks          | `{D6277990-4C6A-11CF-8D87-00AA0060F5BF}` |
| Temporary Internet Files | `{7BD29E00-76C1-11CF-9DD0-00A0C9034933}` |
| Web Folders              | `{BDEADF00-C265-11D0-BCED-00A0C90AB50F}` |

Win32 [`CSIDL`][csidl] Constants
--------------------------------

* CSIDL\_ADMINTOOLS
* CSIDL\_ALTSTARTUP
* CSIDL\_APPDATA
* CSIDL\_BITBUCKET
* CSIDL\_CDBURN\_AREA
* CSIDL\_COMMON\_ADMINTOOLS
* CSIDL\_COMMON\_ALTSTARTUP
* CSIDL\_COMMON\_APPDATA
* CSIDL\_COMMON\_DESKTOPDIRECTORY
* CSIDL\_COMMON\_DOCUMENTS
* CSIDL\_COMMON\_FAVORITES
* CSIDL\_COMMON\_MUSIC
* CSIDL\_COMMON\_OEM\_LINKS
* CSIDL\_COMMON\_PICTURES
* CSIDL\_COMMON\_PROGRAMS
* CSIDL\_COMMON\_STARTMENU
* CSIDL\_COMMON\_STARTUP
* CSIDL\_COMMON\_TEMPLATES
* CSIDL\_COMMON\_VIDEO
* CSIDL\_COMPUTERSNEARME
* CSIDL\_CONNECTIONS
* CSIDL\_CONTROLS
* CSIDL\_COOKIES
* CSIDL\_DESKTOP
* CSIDL\_DESKTOPDIRECTORY
* CSIDL\_DRIVES
* CSIDL\_FAVORITES
* CSIDL\_FONTS
* CSIDL\_HISTORY
* CSIDL\_INTERNET
* CSIDL\_INTERNET\_CACHE
* CSIDL\_LOCAL\_APPDATA
* CSIDL\_MYDOCUMENTS
* CSIDL\_MYMUSIC
* CSIDL\_MYPICTURES
* CSIDL\_MYVIDEO
* CSIDL\_NETHOOD
* CSIDL\_NETWORK
* CSIDL\_PERSONAL
* CSIDL\_PRINTERS
* CSIDL\_PRINTHOOD
* CSIDL\_PROFILE
* CSIDL\_PROGRAM\_FILES
* CSIDL\_PROGRAM\_FILESX86
* CSIDL\_PROGRAM\_FILES\_COMMON
* CSIDL\_PROGRAM\_FILES\_COMMONX86
* CSIDL\_PROGRAMS
* CSIDL\_RECENT
* CSIDL\_RESOURCES
* CSIDL\_RESOURCES\_LOCALIZED
* CSIDL\_SENDTO
* CSIDL\_STARTMENU
* CSIDL\_STARTUP
* CSIDL\_SYSTEM
* CSIDL\_SYSTEMX86
* CSIDL\_TEMPLATES
* CSIDL\_WINDOWS

[csidl]: http://msdn.microsoft.com/en-us/library/bb762494.aspx

Windows Vista [`KNOWNFOLDERID`][known]
--------------------------------------

* FOLDERID\_AddNewPrograms
* FOLDERID\_AdminTools
* FOLDERID\_AppUpdates
* FOLDERID\_CDBurning
* FOLDERID\_ChangeRemovePrograms
* FOLDERID\_CommonAdminTools
* FOLDERID\_CommonOEMLinks
* FOLDERID\_CommonPrograms
* FOLDERID\_CommonStartMenu
* FOLDERID\_CommonStartup
* FOLDERID\_CommonTemplates
* FOLDERID\_ComputerFolder
* FOLDERID\_ConflictFolder
* FOLDERID\_ConnectionsFolder
* FOLDERID\_Contacts
* FOLDERID\_ControlPanelFolder
* FOLDERID\_Cookies
* FOLDERID\_Desktop
* FOLDERID\_Documents
* FOLDERID\_Downloads
* FOLDERID\_Favorites
* FOLDERID\_Fonts
* FOLDERID\_Games
* FOLDERID\_GameTasks
* FOLDERID\_History
* FOLDERID\_InternetCache
* FOLDERID\_InternetFolder
* FOLDERID\_Links
* FOLDERID\_LocalAppData
* FOLDERID\_LocalAppDataLow
* FOLDERID\_LocalizedResourcesDir
* FOLDERID\_Music
* FOLDERID\_NetHood
* FOLDERID\_NetworkFolder
* FOLDERID\_OriginalImages
* FOLDERID\_PhotoAlbums
* FOLDERID\_Pictures
* FOLDERID\_Playlists
* FOLDERID\_PrintersFolder
* FOLDERID\_PrintHood
* FOLDERID\_Profile
* FOLDERID\_ProgramData
* FOLDERID\_ProgramFiles
* FOLDERID\_ProgramFilesX64
* FOLDERID\_ProgramFilesX86
* FOLDERID\_ProgramFilesCommon
* FOLDERID\_ProgramFilesCommonX64
* FOLDERID\_ProgramFilesCommonX86
* FOLDERID\_Programs
* FOLDERID\_Public
* FOLDERID\_PublicDesktop
* FOLDERID\_PublicDocuments
* FOLDERID\_PublicDownloads
* FOLDERID\_PublicGameTasks
* FOLDERID\_PublicMusic
* FOLDERID\_PublicPictures
* FOLDERID\_PublicVideos
* FOLDERID\_QuickLaunch
* FOLDERID\_Recent
* FOLDERID\_RecordedTV
* FOLDERID\_RecycleBinFolder
* FOLDERID\_ResourceDir
* FOLDERID\_RoamingAppData
* FOLDERID\_SampleMusic
* FOLDERID\_SamplePictures
* FOLDERID\_SamplePlaylists
* FOLDERID\_SampleVideos
* FOLDERID\_SavedGames
* FOLDERID\_SavedSearches
* FOLDERID\_SEARCH\_CSC
* FOLDERID\_SEARCH\_MAPI
* FOLDERID\_SearchHome
* FOLDERID\_SendTo
* FOLDERID\_SidebarDefaultParts
* FOLDERID\_SidebarParts
* FOLDERID\_StartMenu
* FOLDERID\_Startup
* FOLDERID\_SyncManagerFolder
* FOLDERID\_SyncResultsFolder
* FOLDERID\_SyncSetupFolder
* FOLDERID\_System
* FOLDERID\_SystemX86
* FOLDERID\_Templates
* FOLDERID\_TreeProperties
* FOLDERID\_UserProfiles
* FOLDERID\_UsersFiles
* FOLDERID\_Videos
* FOLDERID\_Windows

[known]: http://msdn.microsoft.com/en-us/library/bb762584%28VS.85%29.aspx

Old (Defunct) [TweakUI][tweakui] Special Folders
------------------------------------------------

* CD Burning
* Desktop
* Document Templates
* Favorites
* Installation Path
* My Documents
* My Music
* My Pictures
* My Video
* Programs
* Send To
* Shared Music
* Shared Pictures
* Shared Video
* Start Menu
* Startup

[tweakui]: http://www.microsoft.com/windowsxp/Downloads/powertoys/Xppowertoys.mspx

Visual Studio 2008 Setup Project → Add Special Folder
-----------------------------------------------------

* Common Files Folder
* Common Files (64-bit) Folder
* Fonts Folder
* Program Files Folder
* Program Files (64-bit) Folder
* System Folder
* System (64-bit) Folder
* User's Application Data Folder
* User's Desktop
* User's Favorites Folder
* User's Personal Data Folder
* User's Programs Menu
* User's Send To Menu
* User's Start Menu
* User's Startup Folder
* User's Template Folder
* Windows Folder
* Global Assembly Cache Folder

Visual Studio 2008 Setup Project → File Installation Properties → DefaultLocation [*SpecialFolders*]
----------------------------------------------------------------------------------------------------

* AdminToolsFolder
* AppDataFolder
* CommonAppDataFolder
* CommonFiles64Folder
* CommonFilesFolder
* DesktopFolder
* FavoritesFolder
* FontsFolder
* LocalAppDataFolder
* MyPicturesFolder
* PersonalFolder
* ProgramFiles64Folder
* ProgramFilesFolder
* ProgramMenuFolder
* SendToFolder
* StartMenuFolder
* StartupFolder
* System16Folder
* System64Folder
* SystemFolder
* TempFolder
* TemplateFolder
* WindowsFolder
* WindowsVolume

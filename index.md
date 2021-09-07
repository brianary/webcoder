⌨️🖥️
====

References
----------

- [Windows Key Shortcuts for Windows 10](windowskey.md) has all the Windows Key shortcuts.
- [Two Letter ISO/FIPS/NUTS Country Codes with Currency, Language, and Subregion Codes](countries.html) puts all the
  two-letter internationalization codes from several standards on the same grid.
- [XSLT 2.0/XPath 2.0 QuickRef](xslt2.md) and [XML Schema QuickRef](xsd.md) for those of us that still have to work with
  a lot of XML.
- [SQL Server Datatypes QuickRef](mssqldatatypes.html) is something I put together in the '90s.
- [Writing a PowerShell Core Module With F#, A Complete Guide](fspsmodule.md) fully explains how to create a binary
  PowerShell module in F#, considering branding, source control, tests, documentation, and publication.
- [A .NET Core/Standard Versioning Odyssey](version-odyssey.md) describes my process for one very difficult part of that module.
- ["Else if" in multiple languages](else.md) enumerates differences in syntax across languages for the "else if" construct.

PowerShell & F#
---------------

My [SelectXmlExtensions][], [CertAdmin][], or [Pretendpoint][] PowerShell modules can be installed by runnning
`Install-Module SelectXmlExtensions` (for example).

I contribute a little to several projects.
My most active repo is [scripts](https://github.com/brianary/scripts), which is mostly PowerShell, but also some F# and other
(primarily Windows) stuff.

[SelectXmlExtensions]: https://powershellgallery.com/packages/SelectXmlExtensions/ "PowerShell cmdlets that Select-Xml can compose into pipelines"
[CertAdmin]: https://www.powershellgallery.com/packages/CertAdmin/ "Manage certificates and their permissions on a Windows server."
[Pretendpoint]: https://www.powershellgallery.com/packages/Pretendpoint/ "Pretend Endpoint, the disposable web server."

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

Favorite Specs & Standards
--------------------------

- [Unicode][]; see [&amp;what;][]
- [ISO639-1 alpha-2][] Common language codes
- [ISO3166-1 alpha-2][] Common country codes
- [ISO4217][] Common currency codes
- [ISO8601][] Date, time, duration, and recurrence formats
- [RFC1945][] `GET`, `HEAD`, `POST`, `200 OK`, `Cache-Control: no-cache, no-store, must-revalidate`, `Expires: 0`
- [RFC2017][] `Content-Type: message/external-body; access-type=URL; URL="http://www.example.com/"`
- [RFC2046][] `text/*`, `image/*`, `audio/*`, `video/*`, `application/*`, `multipart/*`, `message/*`, `*/x-*`; see [media types][]
- [RFC2119][] & [RFC8174][] `MUST`, `MUST NOT`, `REQUIRED`, `SHALL`, `SHALL NOT`, `SHOULD`, `SHOULD NOT`, `RECOMMENDED`,  `MAY`, and `OPTIONAL`
- [RFC2397][] `data:text/plain,Hello` • `data:image/png;base64,R0lGODlhBAAEAHAAACwAAAAABAAEAIH///8AAAAAAAAAAAACBYQdgXpQADs=`
- [RFC3986][] `https://example.com/` • `ftp://user@pwd:example.net/` • `tel:+1-816-555-1212`
- [RFC5545][] `BEGIN:VCALENDAR` … `END:VCALENDAR`
- [RFC6238][] 2FA token: 123456 <progress max="6" value="2" />
- [RFC6454][] `Origin: https://example.org/`
- [RFC6648][] deprecating `X-` prefix
- [RFC6797][] HSTS: `Strict-Transport-Security: max-age=16070400; includeSubdomains`
- [RFC7469][] HPKP: `Public-Key-Pins: max-age=2592000; pin-sha256="E9CZ9INDbd+2eRQozYqqbQ2yXLVKB9+xcprMF+44U1g="; report-uri="http://example.com/pkp-report"; max-age=10000; includeSubDomains`
- [RFC7519][] JWT: `{"alg": "HS256", "typ": "JWT"}` → `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9`; see [jwt.io][]
- [RFC7617][] `Authorization: Basic dGVzdDoxMjPCow==`
- [RFC7764][] Markdown guidance; see [commonmark.org][]
- [RFC8280][] Human rights considerations when developing protocols
- [draft-rep-wg-topic-00][] robots.txt; see [robotstxt.org][]
- [draft-foudil-securitytxt-11][] security.txt; see [securitytxt.org][]
- [editorconfig][] for specifying coding style
- [Fetch][] Fetch: URL schemes, redirects, CORS, CSP, referrer, &c
- [CORS][] Cross-origin request sharing
- [CSP][] `Content-Security-Policy: default-src 'self' *.example.org 'unsafe-inline'; report-uri https://example.com/csp-report`
- [HTML][] `<!doctype html><title>Page</title><h1>Page</h1>`
- [CSS][] `article {display: flex; flex-flow: column;}`
- [DOM][] for document manipulation
- [ECMA262][] ECMAScript

[Unicode]: https://home.unicode.org/
[ISO639-1 alpha-2]: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes#Table_of_all_possible_two_letter_codes "ISO639-1 alpha-2 Two-letter language codes"
[ISO3166-1 alpha-2]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Decoding_table "ISO3166-1 alpha-2 Two-letter country codes"
[ISO4217]: https://en.wikipedia.org/wiki/ISO_4217#Active_codes
[ISO8601]: https://en.wikipedia.org/wiki/ISO_8601 "Date, time, duration, and recurrence formats"
[RFC1945]: https://tools.ietf.org/html/rfc1945 "Hypertext Transfer Protocol -- HTTP/1.0"
[RFC2017]: https://tools.ietf.org/html/rfc2017 "Definition of the URL MIME External-Body Access-Type"
[RFC2046]: https://tools.ietf.org/html/rfc2046 "Multipurpose Internet Mail Extensions (MIME) Part Two: Media Types"
[RFC2119]: https://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels"
[RFC2397]: https://tools.ietf.org/html/rfc2397 "The 'data' URL scheme"
[RFC3986]: https://tools.ietf.org/html/rfc3986 "Uniform Resource Identifier (URI): Generic Syntax"
[RFC5545]: https://tools.ietf.org/html/rfc5545 "Internet Calendaring and Scheduling Core Object Specification (iCalendar)"
[RFC6238]: https://tools.ietf.org/html/rfc6238 "TOTP: Time-Based One-Time Password Algorithm"
[RFC6454]: https://tools.ietf.org/html/rfc6454 "The Web Origin Concept"
[RFC6648]: https://tools.ietf.org/html/rfc6648 "Deprecating the 'X-' Prefix and Similar Constructs in Application Protocols"
[RFC6797]: https://tools.ietf.org/html/rfc6797 "HTTP Strict Transport Security (HSTS)"
[RFC7469]: https://tools.ietf.org/html/rfc7469 "Public Key Pinning Extension for HTTP"
[RFC7519]: https://tools.ietf.org/html/rfc7519 "JSON Web Token (JWT)"
[RFC7617]: https://tools.ietf.org/html/rfc7617 "The 'Basic' HTTP Authentication Scheme"
[RFC7764]: https://tools.ietf.org/html/rfc7764 "Guidance on Markdown: Design Philosophies, Stability Strategies, and Select Registrations"
[RFC8174]: https://tools.ietf.org/html/rfc8174 "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words"
[RFC8280]: https://tools.ietf.org/html/rfc8280 "Research into Human Rights Protocol Considerations"
[draft-rep-wg-topic-00]: https://tools.ietf.org/html/draft-rep-wg-topic-00 "Robots Exclusion Protocol"
[draft-foudil-securitytxt-11]: https://tools.ietf.org/html/draft-foudil-securitytxt-11 "A File Format to Aid in Security Vulnerability Disclosure"
[editorconfig]: https://editorconfig.org/
[Fetch]: https://fetch.spec.whatwg.org/ "WHATWG Fetch Living Standard"
[CORS]: https://w3c.github.io/webappsec-cors-for-developers/ "CORS for Developers"
[CSP]: https://www.w3.org/TR/CSP3/ "Content Security Policy Level 3"
[HTML]: https://html.spec.whatwg.org/ "WHATWG HTML Living Standard"
[CSS]: https://www.w3.org/Style/CSS/Overview.en.html "Cascading Style Sheets"
[DOM]: https://dom.spec.whatwg.org/ "WHATWG DOM Living Standard"
[ECMA262]: https://tc39.es/ecma262/ "ECMAScript Language Specification"

[media types]: https://www.iana.org/assignments/media-types/media-types.xhtml "IANA-registered media types list"
[jwt.io]: https://jwt.io/ "JSON Web Tokens"
[commonmark.org]: https://commonmark.org/
[robotstxt.org]: https://www.robotstxt.org/ "The Web Robots Pages"
[securitytxt.org]: https://securitytxt.org/ "A proposed standard which allows websites to define security policies"
[&amp;what;]: http://www.amp-what.com/ "Unicode character search"

[🍸](Friday.ics "🚫")

Important Standards
===================

![heirarchy map of standars, by category/topic](images/standards.svg)

Standards
---------

- [RFC8280][] Human rights considerations when developing protocols
- [RFC2119][] & [RFC8174][] `MUST`, `MUST NOT`, `REQUIRED`, `SHALL`, `SHALL NOT`, `SHOULD`, `SHOULD NOT`, `RECOMMENDED`,  `MAY`, and `OPTIONAL`
- [RFC6648][] deprecating `X-` prefix

Protocols
---------

- [RFC3986][] `https://example.com/` • `ftp://user@pwd:example.net/` • `tel:+1-816-555-1212`
- [RFC1945][] `GET`, `HEAD`, `POST`, `200 OK`, `Cache-Control: no-cache, no-store, must-revalidate`, `Expires: 0`
- [RFC2017][] `Content-Type: message/external-body; access-type=URL; URL="http://www.example.com/"`
- [draft-rep-wg-topic-00][] robots.txt; see [robotstxt.org][]
- [draft-foudil-securitytxt-11][] security.txt; see [securitytxt.org][]
- [Fetch][] Fetch: URL schemes, redirects, CORS, CSP, referrer, &c

Security
--------

- [RFC6238][] 2FA token: 123456 <progress max="6" value="2" />
- [RFC6454][] `Origin: https://example.org/`
- [RFC6797][] HSTS: `Strict-Transport-Security: max-age=16070400; includeSubdomains`
- [RFC7469][] HPKP: `Public-Key-Pins: max-age=2592000; pin-sha256="E9CZ9INDbd+2eRQozYqqbQ2yXLVKB9+xcprMF+44U1g="; report-uri="http://example.com/pkp-report"; max-age=10000; includeSubDomains`
- [RFC7617][] `Authorization: Basic dGVzdDoxMjPCow==`
- [CORS][] Cross-origin request sharing
- [CSP][] `Content-Security-Policy: default-src 'self' *.example.org 'unsafe-inline'; report-uri https://example.com/csp-report`
- SAML

Development
------------

- [editorconfig][] for specifying coding style
- [emmet][] for efficient markup entry
- [openapi][]: OpenAPI: `{"openapi": "3.0.3", "info": {"title": "Example API", "version": "1.0"}}`
- [`NO_COLOR`][] for suppressing color output from terminal apps
- [DOM][] for document manipulation
- [ECMA262][] ECMAScript

Codes
-----

- [RFC2046][] `text/*`, `image/*`, `audio/*`, `video/*`, `application/*`, `multipart/*`, `message/*`, `*/x-*`; see [media types][]
- [ISO639-1 alpha-2][] Common language codes
- [ISO3166-1 alpha-2][] Common country codes
- [ISO4217][] Common currency codes

Data
----

- [ISO8601][] Date, time, duration, and recurrence formats
- [RFC2397][] `data:text/plain,Hello` • `data:image/png;base64,R0lGODlhBAAEAHAAACwAAAAABAAEAIH///8AAAAAAAAAAAACBYQdgXpQADs=`
- [RFC5545][] `BEGIN:VCALENDAR` … `END:VCALENDAR`
- [RFC8259][] JSON: `{"": true, "key": "value", "zero": 0, "subobject": {"key": "value"}}`
    - [RFC6901][] JSON select: `/paths/~1users/get`
    - [jsonref][] JSON reference: `{"$ref": "https://example.net/value"}`
    - [jsonschema][] JSON schema `{"type": "string", "maxLength": 255}`
- [RFC7519][] JWT: `{"alg": "HS256", "typ": "JWT"}` → `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9`; see [jwt.io][]
- [yaml][] YAML: `YAML: "Document Title"`
- XML
    - XPath
    - XSLT

Text
----

- [Unicode][]; see [&amp;what;][]
- [RFC7764][] Markdown guidance; see [commonmark.org][]
- [asciidoc][] for more complex text features, including powerful table support
- wiki, reStructuredText, &c
- [HTML][] `<!doctype html><title>Page</title><h1>Page</h1>`
    - [CSS][] `article {display: flex; flex-flow: column;}`
- DocBook
- LaTeX
- ISO 26300 OpenDocument (ODF)
- supporting content
    - MathML
    - AsciiMath
    - Mermaid
    - Graphviz DOT

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
[RFC6901]: https://tools.ietf.org/html/rfc6901 "JavaScript Object Notation (JSON) Pointer"
[RFC7469]: https://tools.ietf.org/html/rfc7469 "Public Key Pinning Extension for HTTP"
[RFC7519]: https://tools.ietf.org/html/rfc7519 "JSON Web Token (JWT)"
[RFC7617]: https://tools.ietf.org/html/rfc7617 "The 'Basic' HTTP Authentication Scheme"
[RFC7764]: https://tools.ietf.org/html/rfc7764 "Guidance on Markdown: Design Philosophies, Stability Strategies, and Select Registrations"
[RFC8174]: https://tools.ietf.org/html/rfc8174 "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words"
[RFC8259]: https://tools.ietf.org/html/rfc8259 "The JavaScript Object Notation (JSON) Data Interchange Format"
[RFC8280]: https://tools.ietf.org/html/rfc8280 "Research into Human Rights Protocol Considerations"
[draft-rep-wg-topic-00]: https://tools.ietf.org/html/draft-rep-wg-topic-00 "Robots Exclusion Protocol"
[draft-foudil-securitytxt-11]: https://tools.ietf.org/html/draft-foudil-securitytxt-11 "A File Format to Aid in Security Vulnerability Disclosure"
[editorconfig]: https://editorconfig.org/
[`NO_COLOR`]: https://no-color.org/ "An informal standard to suppress color output."
[Fetch]: https://fetch.spec.whatwg.org/ "WHATWG Fetch Living Standard"
[CORS]: https://w3c.github.io/webappsec-cors-for-developers/ "CORS for Developers"
[CSP]: https://www.w3.org/TR/CSP3/ "Content Security Policy Level 3"
[HTML]: https://html.spec.whatwg.org/ "WHATWG HTML Living Standard"
[CSS]: https://www.w3.org/Style/CSS/Overview.en.html "Cascading Style Sheets"
[DOM]: https://dom.spec.whatwg.org/ "WHATWG DOM Living Standard"
[ECMA262]: https://tc39.es/ecma262/ "ECMAScript Language Specification"

[media types]: https://www.iana.org/assignments/media-types/media-types.xhtml "IANA-registered media types list"
[yaml]: https://yaml.org/ "YAML Ain't Markup Language"
[jsonref]: http://jsonref.org/ "JSON Reference"
[jsonschema]: https://json-schema.org/ "JSON Schema"
[jwt.io]: https://jwt.io/ "JSON Web Tokens"
[emmet]: https://docs.emmet.io/ "Emmet — the essential toolkit for web-developers"
[openapi]: https://www.openapis.org/ "OpenAPI"
[asciidoc]: https://asciidoc.org/ "AsciiDoc is a plain text markup language for writing technical content."
[commonmark.org]: https://commonmark.org/
[robotstxt.org]: https://www.robotstxt.org/ "The Web Robots Pages"
[securitytxt.org]: https://securitytxt.org/ "A proposed standard which allows websites to define security policies"
[&amp;what;]: http://www.amp-what.com/ "Unicode character search"

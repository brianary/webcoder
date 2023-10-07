Encoding Markup in .NET
=======================

There are at least four ways to escape HTML or XML characters to entities in .NET, but they work quite differently.

<nav>

[Escape](#escape) | [Encode](#encode) | [HtmlEncode](#htmlencode) | [🏚️ _AntiXssEncoder_](#%F0%9F%8F%9A%EF%B8%8F-antixssencoder)

</nav>

> TL;DR: In #PowerShell, the best options to encode to HTML or XML are
> `[Security.SecurityElement]::Escape()` (minimal)
> or `[Text.Encodings.Web.HtmlEncoder]::Default.Encode()` (comprehensive).

[Escape][]
----------

`System.Security.SecurityElement.Escape()` is the simplest encoder, only escaping `&` `<` `>` `"` and `'` and
passing through all other characters unchanged.

This is fine if you want something lightweight (though not as lightweight as doing the five search-and-replace
operations yourself), and you don't want or need any special encoding for any other characters.

### Escape Effect

| codepoint(s) | name                                 | encoded? |   format    |
|--------------|--------------------------------------|:--------:|:-----------:|
| U+0022       | QUOTATION MARK                       |    ✔️    |  `&quot;`   |
| U+0026       | AMPERSAND                            |    ✔️    |   `&amp;`   |
| U+0027       | APOSTROPHE                           |    ✔️    |  `&apos;`   |
| U+003C       | LESS-THAN SIGN                       |    ✔️    |   `&lt;`    |
| U+003E       | GREATER-THAN SIGN                    |    ✔️    |   `&gt;`    |
| all others   | Basic Multilingual Plane (remaining) |    ❌     | (unescaped) |

[Escape]: https://learn.microsoft.com/dotnet/api/system.security.securityelement.escape "Replaces invalid XML characters in a string with their valid XML equivalent."

[Encode][]
----------

`System.Text.Encodings.Web.HtmlEncoder.Default.Encode()` is a more comprehensive encoder to not only encode the bare
minimum characters, but also to encode anything outside 7-bit ASCII for compatibility, using hex codepoint entities
instead of named entities, which work for both HTML and XML.

### Encode Effect

| codepoint(s)  | name                                 | encoded? |        format         |
|---------------|--------------------------------------|:--------:|:---------------------:|
| U+0000–U+001F | C0 Controls                          |    ✔️    |   `&#x0;` – `&#1F;`   |
| U+0020        | SPACE                                |    ❌     |                       |
| U+0021        | EXCLAMATION MARK                     |    ❌     |           !           |
| U+0022        | QUOTATION MARK                       |    ✔️    |       `&quot;`        |
| U+0023        | NUMBER SIGN                          |    ❌     |          \#           |
| U+0024        | DOLLAR SIGN                          |    ❌     |           $           |
| U+0025        | PERCENT SIGN                         |    ❌     |           %           |
| U+0026        | AMPERSAND                            |    ✔️    |        `&amp;`        |
| U+0027        | APOSTROPHE                           |    ✔️    |       `&#x27;`        |
| U+0028        | LEFT PARENTHESIS                     |    ❌     |           (           |
| U+0029        | RIGHT PARENTHESIS                    |    ❌     |           )           |
| U+002A        | ASTERISK                             |    ❌     |          \*           |
| U+002B        | PLUS SIGN                            |    ✔️    |       `&#x2B;`        |
| U+002C–U+003B | Basic Latin (partial)                |    ❌     |         , – ;         |
| U+003C        | LESS-THAN SIGN                       |    ✔️    |        `&lt;`         |
| U+003D        | EQUALS SIGN                          |    ❌     |           =           |
| U+003E        | GREATER-THAN SIGN                    |    ✔️    |        `&gt;`         |
| U+003F–U+007E | Basic Latin (remaining printable)    |    ❌     |         ? – ~         |
| U+007F–U+FFFF | Basic Multilingual Plane (remaining) |    ✔️    | `&#x7F;` – `&#xFFFF;` |

[Encode]: https://learn.microsoft.com/dotnet/api/system.text.encodings.web.htmlencoder "Represents an HTML character encoding."

[HtmlEncode][]
--------------

`System.Web.HttpUtility.HtmlEncode()` only encodes the minimal symbols as named entities (except decimal for apostrophe,
for maximum HTML compatibility with extremely old browsers and HTML parsers), and the Latin-1 Supplement as decimal
entities. It doesn't encode any control characters or any characters outside the Latin blocks.

### HtmlEncode Effect

| codepoint(s)  | name                                 | encoded? |        format        |
|---------------|--------------------------------------|:--------:|:--------------------:|
| U+0000–U+001F | C0 Controls                          |    ❌     |      _␀_ – _␟_       |
| U+0020        | SPACE                                |    ❌     |                      |
| U+0021        | EXCLAMATION MARK                     |    ❌     |          !           |
| U+0022        | QUOTATION MARK                       |    ✔️    |       `&quot;`       |
| U+0023        | NUMBER SIGN                          |    ❌     |          \#          |
| U+0024        | DOLLAR SIGN                          |    ❌     |          $           |
| U+0025        | PERCENT SIGN                         |    ❌     |          %           |
| U+0026        | AMPERSAND                            |    ✔️    |       `&amp;`        |
| U+0027        | APOSTROPHE                           |    ✔️    |       `&#39;`        |
| U+0028–U+003B | Basic Latin (partial)                |    ❌     |        ( – ;         |
| U+003C        | LESS-THAN SIGN                       |    ✔️    |        `&lt;`        |
| U+003D        | EQUALS SIGN                          |    ❌     |          =           |
| U+003E        | GREATER-THAN SIGN                    |    ✔️    |        `&gt;`        |
| U+003F–U+007E | Basic Latin (remaining)              |    ❌     |       ? – _␡_        |
| U+0080–U+009F | C1 Controls                          |    ❌     |    _PAD_ – _APC_     |
| U+00AD–U+00FF | Latin-1 Supplement                   |    ✔️    | `&#160;` – `&#255F;` |
| U+0100–U+FFFF | Basic Multilingual Plane (remaining) |    ❌     |    Ā – _U+FFFF_†     |

† not a valid codepoint

[HtmlEncode]: https://learn.microsoft.com/dotnet/api/system.web.httputility.htmlencode "Converts a string into an HTML-encoded string."

🏚️ [AntiXssEncoder][]
---------------------

`System.Web.Security.AntiXss.AntiXssEncoder` offered a variety of encoding choices, but was discontinued after .NET Framework 4.8.1.

Encoding is accomplished with any of three methods: [`HtmlEncode()`], [`XmlAttributeEncode()`], or [`XmlEncode()`].

These only encode codepoints up through U+00A0 then U+0370 and above as a decimal entity, and mangles a bunch of the characters in the
ranges it doesn't encode, so it's a bad choice for a number of reasons.

### AntiXssEncoder Effect

| codepoint(s)  | name                                  | encoded? |        format         | notes
|---------------|---------------------------------------|:--------:|:---------------------:|------
| U+0000–U+001F | C0 Controls                           |    ✔️    |   `&#0;` – `&#31;`    |
| U+0020        | SPACE                                 |    ✔️    |        `&#32;`        | `XmlAttributeEncode()`
| U+0020        | SPACE                                 |    ❌     |                       | `HtmlEncode()` & `XmlEncode()`
| U+0021        | EXCLAMATION MARK                      |    ❌     |           !           |
| U+0022        | QUOTATION MARK                        |    ✔️    |       `&quot;`        |
| U+0023        | NUMBER SIGN                           |    ❌     |          \#           |
| U+0024        | DOLLAR SIGN                           |    ❌     |           $           |
| U+0025        | PERCENT SIGN                          |    ❌     |           %           |
| U+0026        | AMPERSAND                             |    ✔️    |        `&amp;`        |
| U+0027        | APOSTROPHE                            |    ✔️    |       `&apos;`        | `XmlAttributeEncode()` & `XmlEncode()`
| U+0027        | APOSTROPHE                            |    ✔️    |        `&#39;`        | `HtmlEncode()`
| U+0028–U+003B | Basic Latin (partial)                 |    ❌     |         ( – ;         | some printable 7-bit ASCII
| U+003C        | LESS-THAN SIGN                        |    ✔️    |        `&lt;`         |
| U+003D        | EQUALS SIGN                           |    ❌     |           =           |
| U+003E        | GREATER-THAN SIGN                     |    ✔️    |        `&gt;`         |
| U+003F–U+007E | Basic Latin (remaining printable)     |    ❌     |         ? – ~         |
| U+007F        | DELETE                                |    ✔️    |       `&#127;`        |
| U+0080–U+009F | C1 Controls                           |    ✔️    |  `&#127;` – `&#159;`  |
| U+00A0        | NO-BREAK SPACE                        |    ✔️    |       `&#160;`        |
| U+00A1–U+00AC | Latin-1 Supplement (partial)          |    ❌️    |         ¡ – ¬         |
| U+00AD        | SOFT HYPHEN                           |    ✔️    |       `&#173;`        |
| U+00AE–U+036F | Latin (remaining), various extensions |    ❌️    |         ® – ͯ         | see †
| U+0370–U+FFFF | Basic Multilingual Plane (remaining)  |    ✔️    | `&#880;` – `&#65535;` |

† these blocks:

- Latin-1 Supplement (remaining)
- Latin Extended-A
- Latin Extended-B
- IPA Extensions
- Spacing Modifier Letters
- Combining Diacritical Marks

[AntiXssEncoder]: https://learn.microsoft.com/dotnet/api/system.web.security.antixss.antixssencoder "Encodes a string for use in HTML, XML, CSS, and URL strings."
[`HtmlAttributeEncode()`]: https://learn.microsoft.com/dotnet/api/system.web.security.antixss.antixssencoder.htmlattributeencode "Encodes and outputs the specified string for use in an HTML attribute."
[`HtmlEncode()`]: https://learn.microsoft.com/dotnet/api/system.web.security.antixss.antixssencoder.htmlencode "Encodes the specified string for use as text in HTML markup."
[`XmlAttributeEncode()`]: https://learn.microsoft.com/en-us/dotnet/api/system.web.security.antixss.antixssencoder.xmlattributeencode "Encodes the specified string for use in XML attributes."
[`XmlEncode()`]: https://learn.microsoft.com/en-us/dotnet/api/system.web.security.antixss.antixssencoder.xmlencode "Encodes the specified string for use in XML attributes."

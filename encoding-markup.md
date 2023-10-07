Encoding Markup in .NET
=======================

There are at least four ways to escape HTML or XML characters to entities in .NET, but they work quite differently.

> TL;DR: In #PowerShell, the best options to encode to HTML or XML are
> `[Security.SecurityElement]::Escape()` (minimal)
> or `[Text.Encodings.Web.HtmlEncoder]::Default.Encode()` (comprehensive).

[Escape][]
----------

`System.Security.SecurityElement.Escape()` is the simplest encoder, only escaping `&` `<` `>` `"` and `'` and
passing through all other characters unchanged.

This is fine if you want something lightweight, and you don't need to force the output to 7-bit ASCII for compatibility,
either because the input is already 7-bit, or because the output can acceptably use more complex encodings.

### Escape Effect

| codepoint(s) | name                      | encoded? |   format    |
| ------------ | ------------------------- | :------: | :---------: |
| U+0022       | QUOTATION MARK            |    ✔️     |  `&quot;`   |
| U+0026       | AMPERSAND                 |    ✔️     |   `&amp;`   |
| U+0027       | APOSTROPHE                |    ✔️     |  `&apos;`   |
| U+003C       | LESS-THAN SIGN            |    ✔️     |   `&lt;`    |
| U+003E       | GREATER-THAN SIGN         |    ✔️     |   `&gt;`    |
| all others   | Basic Multilingual Plance |    ❌     | (unescaped) |

[Escape]: https://learn.microsoft.com/dotnet/api/system.security.securityelement.escape "Replaces invalid XML characters in a string with their valid XML equivalent."

[Encode][]
----------

`System.Text.Encodings.Web.HtmlEncoder.Default.Encode()` is a more comprehensive encoder to not only encode the bare
minimum characters, but also to encode anything outside 7-bit ASCII for compatibility, using hex codepoint entities
instead of named entities, which work for both HTML and XML.

### Encode Effect

| codepoint(s) | name              | encoded? |  format  |
| ------------ | ----------------- | :------: | :------: |
| U+0022       | QUOTATION MARK    |    ✔️     | `&quot;` |
| U+0026       | AMPERSAND         |    ✔️     | `&amp;`  |
| U+0027       | APOSTROPHE        |    ✔️     | `&#x27;` |
| U+003C       | LESS-THAN SIGN    |    ✔️     |  `&lt;`  |
| U+003D       | EQUALS SIGN       |    ❌     |    =     |
| U+003E       | GREATER-THAN SIGN |    ✔️     |  `&gt;`  |


[Encode]: https://learn.microsoft.com/dotnet/api/system.text.encodings.web.htmlencoder "Represents an HTML character encoding."

[HtmlEncode][]
--------------

`System.Web.HttpUtility.HtmlEncode()` encodes 8-bit ASCII or Latin-1 characters to 7-bit ASCII using decimal codepoint
entities, which isn't as comprehensive, and anything above codepoint U+00FF don't seem to be preserved accurately,
so this seems like a less reliable encoder.

### HtmlEncode Effect

| codepoint(s) | name              | encoded? |  format  |
| ------------ | ----------------- | :------: | :------: |
| U+0022       | QUOTATION MARK    |    ✔️     | `&quot;` |
| U+0026       | AMPERSAND         |    ✔️     | `&amp;`  |
| U+0027       | APOSTROPHE        |    ✔️     | `&#39;`  |
| U+003C       | LESS-THAN SIGN    |    ✔️     |  `&lt;`  |
| U+003D       | EQUALS SIGN       |    ❌     |    =     |
| U+003E       | GREATER-THAN SIGN |    ✔️     |  `&gt;`  |

[HtmlEncode]: https://learn.microsoft.com/dotnet/api/system.web.httputility.htmlencode "Converts a string into an HTML-encoded string."

🏚️ [AntiXssEncoder][]
---------------------

`System.Web.Security.AntiXss.AntiXssEncoder` offered a variety of encoding choices, but was discontinued after .NET Framework 4.8.1.

Encoding is accomplished with any of three methods: [`HtmlEncode()`], [`XmlAttributeEncode()`], or [`XmlEncode()`].

These only encode codepoints up through U+00A0 then U+0370 and above as a decimal entity, and mangles a bunch of the characters in the
ranges it doesn't encode, so it's a bad choice for a number of reasons.

### AntiXssEncoder Effect

| codepoint(s)  | name                                  | encoded? |        format         | notes                                  |
| ------------- | ------------------------------------- | :------: | :-------------------: | -------------------------------------- |
| U+0000–U+001F | C0 Controls                           |    ✔️     |   `&#0;` – `&#31;`    |
| U+0020        | SPACE                                 |    ✔️     |        `&#32;`        | `XmlAttributeEncode()`                 |
| U+0020        | SPACE                                 |    ❌     |                       | `HtmlEncode()` & `XmlEncode()`         |
| U+0021        | EXCLAMATION MARK                      |    ❌     |           !           |
| U+0022        | QUOTATION MARK                        |    ✔️     |       `&quot;`        |
| U+0023        | NUMBER SIGN                           |    ❌     |          \#           |
| U+0024        | DOLLAR SIGN                           |    ❌     |           $           |
| U+0025        | PERCENT SIGN                          |    ❌     |           %           |
| U+0026        | AMPERSAND                             |    ✔️     |        `&amp;`        |
| U+0027        | APOSTROPHE                            |    ✔️     |       `&apos;`        | `XmlAttributeEncode()` & `XmlEncode()` |
| U+0027        | APOSTROPHE                            |    ✔️     |        `&#39;`        | `HtmlEncode()`                         |
| U+0028–U+003B | Basic Latin (selection)               |    ❌     |         ( – ;         | some printable 7-bit ASCII             |
| U+003C        | LESS-THAN SIGN                        |    ✔️     |        `&lt;`         |
| U+003D        | EQUALS SIGN                           |    ❌     |           =           |
| U+003E        | GREATER-THAN SIGN                     |    ✔️     |        `&gt;`         |
| U+003F–U+007E | Basic Latin (remaining printable)     |    ❌     |         ? – ~         | the remaining printable 7-bit ASCII    |
| U+007F        | DELETE                                |    ✔️     |       `&#127;`        |
| U+0080–U+009F | C1 Controls                           |    ✔️     |  `&#127;` – `&#159;`  |
| U+00A0        | NO-BREAK SPACE                        |    ✔️     |       `&#160;`        |
| U+00A1–U+00AC | Latin-1 Supplement (selection)        |    ❌️     |         ¡ – ¬         |
| U+00AD        | SOFT HYPHEN                           |    ✔️     |       `&#173;`        |
| U+00AE–U+036F | Latin (remaining), various extensions |    ❌️     |         ® – ͯ          | see †                                  |
| U+0370–U+FFFF | Basic Multilingual Plane (remaining)  |    ✔️     | `&#880;` – `&#65535;` |

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

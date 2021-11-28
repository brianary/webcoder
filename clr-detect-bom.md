Efficacy of System.IO.StreamReader's `detectEncodingFromByteOrderMarks`
=======================================================================

The .NET [`System.IO.StreamReader`](http://msdn.microsoft.com/en-us/library/system.io.streamreader.aspx) class has [several forms](http://msdn.microsoft.com/en-us/library/system.io.streamreader.streamreader.aspx) of its constructor that accept a [boolean `detectEncodingFromByteOrderMarks`](http://msdn.microsoft.com/en-us/library/9y86s1a9.aspx) parameter to look for a [byte-order-mark (BOM)/encoding-signature](http://en.wikipedia.org/wiki/Byte-order_mark) when the file is first read.
When enabled, this feature populates the [`CurrentEncoding`](http://msdn.microsoft.com/en-us/library/system.io.streamreader.currentencoding.aspx) property after the first time the file is read (which can be a simple call to [`Peek()`](http://msdn.microsoft.com/en-us/library/system.io.streamreader.peek.aspx)).
This method only works reliably for encodings that supply a BOM, but since the default encoding is `utf-8`, several other single-byte encodings are compatible with content in the 7-bit ASCII range.
Here is a sample of how well this feature works with content written in various encodings:

- `us-ascii`

    Not detected, but works fine with the default UTF-8 since ASCII is a subset of UTF-8.
    
- `utf-7`

    Not detected, not UTF-8 compatible.

- `utf-8`

    Detected correctly. Default encoding anyway.

- `utf-16`/`UCS-2`

    Detected correctly (as `utf-16`).

- `utf-32`

    Detected correctly.

- `utf-32BE`

    Detected correctly, but **still reads incorrectly** in my testing!

- `unicodeFFFE`

    Detected correctly.

- `Windows-1252`, `iso-8859-1`, `iso-8859-15`, `macintosh`

    Not detected, but shares a significant character overlap with the UTF-8 default (7-bit ASCII).

- Various EBCDIC encodings: `IBM037`, `IBM500`, `IBM870`

    Not detected, and not read correctly in tests.

- `UTF-EBCDIC`, `SCSU`, `BOCU-1`, `Punycode`, `CESU-8`, `UCS-4`*, `UTF-1`, `UTF-9`†, `UTF-18`†

    Not supported by the .NET Framework.

For the most part, content using a Unicode encoding of some kind (which include a BOM) have the greatest chance of success, and encodings not listed aren't likely to work. EBCDIC and international encodings, among others, must really be opened using their explicit encoding (meaning they must be anticipated), if they are to be read successfully, which is why you should only produce UTF-8/16/32 content.

<small>* Not recognized as an alias for UTF-32.</small>

<small>† To be fair, these encodings are a joke.</small>

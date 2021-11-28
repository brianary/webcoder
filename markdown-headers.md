Setext vs atx Header Styles in Markdown
=======================================

The case for atx headers
------------------------

```markdown
# This is an H1

## This is an H2

###### This is an H6
```

The atx header syntax is simple. It's concise to type and tokenizing is easy since it doesn't require stateful line parsing.

Since Setext only defines two levels of headers, any levels beyond that must be atx-style anyway, so using all atx
headers is more consistent than switching between the top two levels and the rest.

Using atx headers is widely supported, if not required.
[Prettier][] forces atx style, and [Google's style guide specifies it][Google], stating:

> Headings with `=` or `-` underlines can be annoying to maintain and don’t fit with the rest of the heading syntax.
> The user has to ask: Does `---` mean H1 or H2?

### atx: Simple and concise, whitespace (and syntax highlighting) provides some visual distinction

```markdown
# Lorem ipsum

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac est blandit,
vehicula tellus nec, hendrerit nibh. Suspendisse sed ipsum vestibulum, euismod
mauris eget, scelerisque ligula. Maecenas ultrices augue sit amet nibh dictum
mollis.

* Morbi at tortor ornare
* Malesuada erat in
* dignissim libero

## In hac

In hac habitasse platea dictumst. Cras ultricies elit sed velit consectetur,
non dictum ex imperdiet. Sed vehicula pretium interdum. In eget semper elit.
Nulla dolor lectus, pellentesque eu pellentesque egestas, laoreet et est.
Morbi dolor eros, dictum rutrum leo sed, iaculis vehicula nunc.

### In egestas ultricies

In egestas ultricies metus malesuada ullamcorper. Nam aliquam consequat nunc, a
pretium quam. Proin tempus, libero ut vulputate luctus, nunc mi tristique
ligula, vel sodales lorem ipsum ac enim. Duis interdum rutrum lectus eu
pulvinar. Nulla faucibus purus nec tellus lobortis pulvinar. Aenean varius
purus purus, id aliquet felis fermentum eu. 
```

[Prettier]: https://github.com/prettier/prettier/issues/6013 "#6013 Support setext headings in Markdown"
[Google]: https://google.github.io/styleguide/docguide/style.html#atx-style-headings

The case for closed atx headers
------------------------------------------

```markdown
# This is an H1 #

## This is an H2 ##

### This is an H3 ######
```

The atx style has a variant that allows "closing" the header with `#` characters, delimiting the header bracket-style, which can
increase the visibility of atx headers.

### Closed atx: A little more visible than atx, still easy to parse

```markdown
# Lorem ipsum #

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac est blandit,
vehicula tellus nec, hendrerit nibh. Suspendisse sed ipsum vestibulum, euismod
mauris eget, scelerisque ligula. Maecenas ultrices augue sit amet nibh dictum
mollis.

* Morbi at tortor ornare
* Malesuada erat in
* dignissim libero

## In hac ##

In hac habitasse platea dictumst. Cras ultricies elit sed velit consectetur,
non dictum ex imperdiet. Sed vehicula pretium interdum. In eget semper elit.
Nulla dolor lectus, pellentesque eu pellentesque egestas, laoreet et est.
Morbi dolor eros, dictum rutrum leo sed, iaculis vehicula nunc.

### In egestas ultricies ###

In egestas ultricies metus malesuada ullamcorper. Nam aliquam consequat nunc, a
pretium quam. Proin tempus, libero ut vulputate luctus, nunc mi tristique
ligula, vel sodales lorem ipsum ac enim. Duis interdum rutrum lectus eu
pulvinar. Nulla faucibus purus nec tellus lobortis pulvinar. Aenean varius
purus purus, id aliquet felis fermentum eu. 
```

The case for full-width closed atx headers
------------------------------------------

```markdown
# This is an H1 ###############################################################

## This is an H2 ##############################################################

### This is an H3 #############################################################
```

The atx header closing doesn't have to match the number of opening characters. Filling to a common width with these is one
way the atx headers can add much greater visual contrast and _gravitas_, and is less likely to cause confusion than a single
trailing `#`, since `# Phone #` will look to users more familiar with standard atx as "phone number".

### Fullwidth closed atx: Visually distinct and easy to parse

```markdown
# Lorem ipsum #################################################################

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac est blandit,
vehicula tellus nec, hendrerit nibh. Suspendisse sed ipsum vestibulum, euismod
mauris eget, scelerisque ligula. Maecenas ultrices augue sit amet nibh dictum
mollis.

* Morbi at tortor ornare
* Malesuada erat in
* dignissim libero

## In hac #####################################################################

In hac habitasse platea dictumst. Cras ultricies elit sed velit consectetur,
non dictum ex imperdiet. Sed vehicula pretium interdum. In eget semper elit.
Nulla dolor lectus, pellentesque eu pellentesque egestas, laoreet et est.
Morbi dolor eros, dictum rutrum leo sed, iaculis vehicula nunc.

### In egestas ultricies ######################################################

In egestas ultricies metus malesuada ullamcorper. Nam aliquam consequat nunc, a
pretium quam. Proin tempus, libero ut vulputate luctus, nunc mi tristique
ligula, vel sodales lorem ipsum ac enim. Duis interdum rutrum lectus eu
pulvinar. Nulla faucibus purus nec tellus lobortis pulvinar. Aenean varius
purus purus, id aliquet felis fermentum eu. 
```

The case for Setext headers
---------------------------

```markdown
This is an H1
=============

This is an H2
-------------

### This is an H3
```

Underlining headers provides a strong, natural visual decoration.

Readability is the primary design goal of Markdown over other formats, and the ease of writing and parsing atx headers
doesn't contribute to that goal.

Setext headers take about the same amount of work as closing atx headers (in either style), and don't suffer from the
potential narritave confusion of including a symbol meaning "number" inline with header text.

Visually, a single `#` character is easy to miss, though it is meant to indicate the header of greatest importance.
The `#` character also denotes a comment in many languages, and if you include any of those in your document, e.g.
distinguishing between a PowerShell comment and an H1 header becomes quite context-dependent. Headers like `# Products`
can even read as "number of products" when scanning a text quickly, especially when missing the context of the Markdown
syntax in unrendered/unhighlighted environments like database field values.

### The ambiguity of a single leading `#`

``````markdown
# PowerShell command line options

The PowerShell executable offers several command-line parameters than can be abbreviated to the minimum
# of characters that disambiguate them. <!-- Careful: This will usually be rendered as a header, but not always! -->

```powershell
# good options for Scheduled Tasks and simple one-liners
powershell.exe -NoLogo -NonInteractive -NoProfile -File C:\Scripts\Backup-Data.ps1

# shortened
powershell.exe -nol -noni -nop -f C:\Scripts\Backup-Data.ps1

# simple one-liner to list Windows file shares
powershell.exe -nol -noni -nop -Command "& {Get-WmiObject Win32_Share}"
```
``````

Google's stated rationale for dismissing Setext headers due to confusion between `=` and `-` appears to be a pre-emptive
use of the [_tu quoque_][] fallacy, since there doesn't seem to be any actual or likely confusion (`=====` is clearly
a heavier/double underline vs `-----`), while `###### This is an H6` has much *greater* visual emphasis than
`# This is an H1`, which isn't much more visually distinct than a list item: `* This is a list item`.
An atx H1 `# This in an H1` being greater than an atx H2 `## This is an H2` is also inconsistent with Markdown syntax
defining `*emphasis*` as less than `**strong emphasis**`, in terms of increasing decoration.
Confusion is a bigger problem for atx than Setext.

### Setext: Main headers are clearly offset from text, and easily distinguished from other content with single-character prefixes

```markdown
Lorem ipsum
===========

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac est blandit,
vehicula tellus nec, hendrerit nibh. Suspendisse sed ipsum vestibulum, euismod
mauris eget, scelerisque ligula. Maecenas ultrices augue sit amet nibh dictum
mollis.

* Morbi at tortor ornare
* Malesuada erat in
* dignissim libero

In hac
------

In hac habitasse platea dictumst. Cras ultricies elit sed velit consectetur,
non dictum ex imperdiet. Sed vehicula pretium interdum. In eget semper elit.
Nulla dolor lectus, pellentesque eu pellentesque egestas, laoreet et est.
Morbi dolor eros, dictum rutrum leo sed, iaculis vehicula nunc.

### In egestas ultricies

In egestas ultricies metus malesuada ullamcorper. Nam aliquam consequat nunc, a
pretium quam. Proin tempus, libero ut vulputate luctus, nunc mi tristique
ligula, vel sodales lorem ipsum ac enim. Duis interdum rutrum lectus eu
pulvinar. Nulla faucibus purus nec tellus lobortis pulvinar. Aenean varius
purus purus, id aliquet felis fermentum eu. 
```

[_tu quoque_]: https://yourlogicalfallacyis.com/tu-quoque "You avoided having to engage with criticism by turning it back on the accuser - you answered criticism with criticism."

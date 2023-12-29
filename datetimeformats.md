Date and time formatting comparison
===================================

The date and time fields available via [strftime][], [.NET standard][], or [.NET custom][] format templates.

Locale-specific formats will differ outside en-US. `strftime` doesn't support unpadded numeric values,
so the conversion from .NET single-digit values are approximations that use leading zeros.

The examples are using a value of 2063-04-05T15:26:42.

[strftime]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/strftime.html "IEEE Std 1003.1-2017: convert date and time to a string"
[.NET standard]: https://learn.microsoft.com/dotnet/standard/base-types/standard-date-and-time-format-strings "Standard date and time format strings"
[.NET custom]: https://learn.microsoft.com/dotnet/standard/base-types/custom-date-and-time-format-strings "Custom date and time format strings"

Format comparisons
------------------

|           .NET            |         strftime          |          en-US example           | description                                            |
|:-------------------------:|:-------------------------:|:--------------------------------:|--------------------------------------------------------|
|            `u`            |         `%FT%TZ`          |       2063-04-05T15:26:42Z       | UTC "sortable" (ISO8601) format                        |
|            `s`            |          `%FT%T`          |       2063-04-05T15:26:42        | "sortable" (ISO8601) format                            |
|        `O` or `o`         |   `%FT%H:%M:%S.0000000`   |   2063-04-05T15:26:42.0000000    | round-trip format                                      |
|        `R` or `r`         |   `%a, %d %b %Y %T %Z`    |  Thu, 05 Apr 2063 15:26:42 GMT   | RFC1123 format                                         |
|            `D`            |      `%A, %B %e, %Y`      |     Thursday, April 5, 2063      | long locale-dependent date format                      |
|            `d`            |           `%D`            |             4/5/2063             | short locale-dependent date format                     |
|            `U`            |    `%A, %B %e, %Y %T`     | Thursday, April 5, 2063 15:26:42 | UTC long date and long time                            |
|            `F`            |    `%A, %B %e, %Y %T`     | Thursday, April 5, 2063 15:26:42 | long date and long time                                |
|            `f`            |    `%A, %B %e, %Y %R`     |  Thursday, April 5, 2063 15:26   | long date and short time                               |
|            `G`            |          `%D %r`          |       4/5/2063 3:26:42 PM        | short date and long time                               |
|            `g`            |       `%D %I:%M %p`       |         4/5/2063 3:26 PM         | short date and short time                              |
| `ddd MMM d HH:mm:ss yyyy` |           `%c`            |     Thu Apr  5 15:26:42 2063     | locale-dependent date and time format                  |
|      `yyyy\-MM\-dd`       |           `%F`            |            2063-04-05            | ISO8601 date                                           |
|        `MM/dd/yy`         |           `%x`            |             04/05/63             | locale-dependent date format                           |
|        `HH:mm:ss`         |           `%X`            |             15:26:42             | locale-dependent time format                           |
|        `Y` or `y`         |          `%B %Y`          |            April 2063            | month and year format                                  |
|        `M` or `m`         |          `%B %e`          |             April 5              | month and day format                                   |
|            `T`            |    `%r` (`%T` for 24h)    |            3:26:42 PM            | long time format                                       |
|            `t`            | `%I:%M %p` (`%R` for 24h) |             3:26 PM              | short time format                                      |
|        `gg` or `g`        |           `AD`            |                AD                | era                                                    |
|                           |           `%C`            |                20                | century                                                |
|          `yyyyy`          |          `%05Y`           |              02063               | five-digit year                                        |
|          `yyyy`           |           `%Y`            |               2063               | four-digit year                                        |
|           `yyy`           |           `%Y`            |               2063               | at least three-digit year                              |
|           `yy`            |           `%y`            |                63                | two-digit year                                         |
|           `%y`            |           `%y`            |                63                | one or two-digit year                                  |
|                           |           `%G`            |               2063               | [ISO week date][] year                                 |
|                           |           `%g`            |                63                | [ISO week date][] two-digit year                       |
|          `MMMM`           |           `%B`            |              April               | full month name                                        |
|           `MMM`           |       `%b` or `%h`        |               Apr                | short month name                                       |
|           `MM`            |           `%m`            |                04                | two-digit month                                        |
|           `%M`            |           `%m`            |                4                 | one or two-digit month                                 |
|                           |           `%U`            |                13                | week date week, 00 is first week < 4 days              |
|                           |           `%V`            |                14                | [ISO week date][] week, 01 is first full week          |
|                           |           `%W`            |                14                | Monday-start week date week, 00 is first week < 4 days |
|                           |           `%u`            |                4                 | weekday as a digit 1 = Mon through 7 = Sun             |
|                           |           `%w`            |                4                 | weekday as a digit 0 = Sun through 6 = Sat             |
|          `dddd`           |           `%A`            |             Thursday             | full weekday name                                      |
|           `ddd`           |           `%a`            |               Thu                | short weekday name                                     |
|           `dd`            |           `%d`            |                05                | two-digit day of month                                 |
|           `%d`            |           `%e`            |                5                 | one or two-digit day of month                          |
|                           |           `%j`            |               095                | three-digit day of year                                |
|           `tt`            | `%p` (`%P` is lowercase)  |                PM                | two-character AM/PM 12h designation                    |
|           `%t`            |                           |                P                 | single-character AM/PM 12h designation                 |
|           `HH`            |           `%H`            |                15                | two-digit hours (24h)                                  |
|            `H`            |           `%H`            |                15                | one or two-digit hours (24h)                           |
|           `hh`            |           `%I`            |                03                | two-digit hours (12h)                                  |
|            `h`            |           `%I`            |                3                 | one or two-hours (12h)                                 |
|           `mm`            |           `%M`            |                26                | two-digit minutes                                      |
|            `m`            |           `%M`            |                26                | one or two-digit minutes                               |
|           `ss`            |           `%S`            |                42                | two-digit minutes                                      |
|            `s`            |           `%S`            |                42                | one or two-digit minutes                               |
|  `F` &hellip; `FFFFFFF`   |                           |        0 &hellip; 0000000        | fractions of a second, only output if nonzero          |
|  `f` &hellip; `fffffff`   |                           |        0 &hellip; 0000000        | fractions of a second                                  |
|           `zzz`           |           `%:z`           |              +00:00              | timezone offset, in hours and minutes, with separator  |
|           `zz`            |          `%:::z`          |               +00                | timezone offset, in two-digit hours                    |
|            `z`            |                           |                +0                | timezone offset, in one or two-digit hours             |
|            `K`            |           `%Z`            |                Z                 | conditional timezone based on `Kind`                   |
|                           |           `%z`            |              +0000               | timezone offset, in hours and minutes                  |
|                           |          `%::z`           |            +00:00:00             | timezone offset, in hours and minutes and seconds      |

[ISO week date]: https://en.wikipedia.org/wiki/ISO_week_date

### .NET escapes

- `/` is replaced with the locale-specific date separator
- `:` is replaced with the locale-specific time separator
- `\` escapes a format character to use it as a literal
- `'` or `"` single or double quotes escapes a string of characters to use as literals
- other unescaped characters are errors

### strftime escapes

- `%%` outputs a `%`
- `%t` outputs a tab character
- `%n` outputs a newline character
- other characters are literals

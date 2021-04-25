Recurrence Formats
==================

[crontab][]
-----------

```txt
0 3 * * SUN
0 12 ? 1 MON#3
```

Crontab is a flexible syntax for specifying a recurring schedule that has a lot of implementation variation.

The crontab file uses five space-separated fields to specify minutes, hours, day of month, month, and day of week,
with each field allowing a numeric value, a `-`-separated range of values, a `,`-separated list of values, `*` for
any value, a `/n` suffix to match every nth value, `?` to conditionally match a day value when the other day field
matches (in some implementations), a `#n` suffix for day of week to indicate which occurence of that day of week
within the month will match, a `L` to indicate the last day of the month or as a suffix to match the last day of
the week specified, and a `W` suffix to match the closest weekday to the day of the month specified.

There are a number of other ways implementations differ, including adding a sixth field to the beginning for seconds,
adding a field to the end for years, differences in how the days of the week or months of the year are represented.
The implementation also determines whether the values are executed relative to local time, UTC, or another time zone.

Since this allows matching at varous fields, irregular intervals are supported.

[crontab]: https://en.wikipedia.org/wiki/Cron "a [linux] configuration file that specifies shell commands to run periodically on a given schedule"

[ISO8601 Recurrence][ISO8601]
-----------------------------

```txt
R/2021-01-03T03:00:00/P1W
R/2000-W03-1T12:00:00/P1Y
```

ISO8601 defines a recurrence format that starts with an `R` with an optional number of iterations (infinite by default),
followed by two times or a combination of a time and a duration, all separated by `/`.

The point in time is specified either as the starting or ending point for a duration, or both a start and end
time can be used. The time uses the familiar ISO8601 `2000-01-01T00:00:00Z` format, or the less-well-known
[ISO Week Date][] `2000-W01-1T00:00:00Z` format for some limited day-of-week-driven scheduling.
A duration can specify any time unit, and uses the ISO8601 duration format `P9Y9M9DT9H9M9S` or `P9W` for weeks.

This format supports specifying a time zone offset, though not a geographic time zone, so no automatic daylight
saving time adjustment is done if a time zone is specified. Assuming a local time is up to the system handling
the recurrence if time zone data is omitted. This format also only allows specifying a single duration per
recurrence, a regular interval.

[ISO8601]: https://en.wikipedia.org/wiki/ISO_8601#Repeating_intervals
[ISO Week Date]: https://en.wikipedia.org/wiki/ISO_week_date

[iCalendar][] Recurrence Rule
-----------------------------

```txt
RRULE:FREQ=WEEKLY;BYDAY=SU;BYHOUR=3;BYMINUTE=0
RRULE:FREQ=YEARLY;BYDAY=3MO;BYHOUR=12;BYMINUTE=0
```

The iCalendar format widely supported by calendar software defines a recurrence format that is used with
a specified starting time.

The [RFC5545][] [RRULE][] syntax consists of semicolon-separated key-value pairs.

- `FREQ=` `SECONDLY`, `MINUTELY`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`, or `YEARLY`
- `UNTIL=` 📆
- `COUNT=` 🧮
- `INTERVAL=` 🧮
- `BYSECOND=`, `BYMINUTE=`, `BYHOUR=`  seconds, minutes, or hours (respectively) 🧮🔁
- `BYDAY=` optional 🔙🧮 ordinal followed by `SU`, `MO`, `TU`, `WE`, `TH`, `FR`, or `SA` 🔁
- `BYMONTHDAY=`, `BYYEARDAY=` day of month or year 🔙🧮🔁
- `BYWEEKNO=`, `BYMONTH=` week or month of year 🔙🧮🔁
- `BYSETPOS=` day of year 🧮🔁
- `WKST=` `SU`, `MO`, `TU`, `WE`, `TH`, `FR`, or `SA`

### Key

- 📆 = A date/time format is ISO8601 without separators or UTC offset, e.g. `2020-12-31` as a date,
  `TZID=America/Los_Angeles:2020-12-31T235959` for a datetime
- 🔙 = an optional plus or minus, with minus indicating counting backwards from the end
- 🧮 = an integer value
- 🔁 = comma-separated list of values

The [`rrule.js` demo][rrule.js] page allows you to design and test `RRULE` values.

[iCalendar]: https://en.wikipedia.org/wiki/ICalendar "Internet Calendaring and Scheduling Core Object Specification"
[RFC5545]: https://tools.ietf.org/html/rfc5545#section-3.8.5.3 "RFC5545 &sect; 3.8.5.3: iCalendar: Properties: Recurrence Rule"
[RRULE]: https://tools.ietf.org/html/rfc5545#section-3.3.10 "RFC5545 &sect; 3.3.10: iCalendar: Data Types: Recurrence Rule"
[rrule.js]: https://jakubroztocil.github.io/rrule/ "This is a demo and test app for rrule.js, a JavaScript library for working with recurrence rules for calendar dates."

Comparison
----------

### Sundays at 03:00

| Format              | Value                                            |
| ------------------- | ------------------------------------------------ |
| Cron                | `0 3 * * SUN`                                    |
| ISO8601             | `R/2021-01-03T03:00:00/P1W`                      |
| ISO8601 (week date) | `R/2021-W01-1T03:00:00/P1W`                      |
| RFC5545             | `RRULE:FREQ=WEEKLY;BYDAY=SU;BYHOUR=3;BYMINUTE=0` |


### New Year's Eve, one minute before midnight

| Format  | Value                                                  |
| ------- | ------------------------------------------------------ |
| Cron    | `59 23 31 12 ?`                                        |
| ISO8601 | `R/2000-12-31T23:59:00/P1Y`                            |
| RFC5545 | `RRULE:FREQ=YEARLY;BYYEARDAY=-1;BYHOUR=23;BYMINUTE=59` |

### Martin Luther King, Jr Day, lunchtime

| Format              | Value                                              |
| ------------------- | -------------------------------------------------- |
| Cron                | `0 12 ? 1 MON#3`                                   |
| ISO8601 (week date) | `R/2000-W03-1T12:00:00/P1Y`                        |
| RFC5545             | `RRULE:FREQ=YEARLY;BYMONTH=1;BYDAY=3MO;BYHOUR=12;BYMINUTE=0` |

### Leap Mondays, breakfast

Since this is an irregular interval, the ISO8601 format has to combine 15 separate recurrences.

| Format  | Value                                                                    |
| ------- | ------------------------------------------------------------------------ |
| Cron    | `0 7 29 2 MON`                                                           |
| ISO8601 | `R/2016-02-29T07:00:00/P400Y`                                            |
| +       | `R/2044-02-29T07:00:00/P400Y`                                            |
| +       | `R/2072-02-29T07:00:00/P400Y`                                            |
| +       | `R/2112-02-29T07:00:00/P400Y`                                            |
| +       | `R/2140-02-29T07:00:00/P400Y`                                            |
| +       | `R/2168-02-29T07:00:00/P400Y`                                            |
| +       | `R/2196-02-29T07:00:00/P400Y`                                            |
| +       | `R/2208-02-29T07:00:00/P400Y`                                            |
| +       | `R/2236-02-29T07:00:00/P400Y`                                            |
| +       | `R/2264-02-29T07:00:00/P400Y`                                            |
| +       | `R/2292-02-29T07:00:00/P400Y`                                            |
| +       | `R/2304-02-29T07:00:00/P400Y`                                            |
| +       | `R/2332-02-29T07:00:00/P400Y`                                            |
| +       | `R/2360-02-29T07:00:00/P400Y`                                            |
| +       | `R/2388-02-29T07:00:00/P400Y`                                            |
| RFC5545 | `RRULE:FREQ=YEARLY;BYMONTH=2;BYDAY=MO;BYMONTHDAY=29;BYHOUR=7;BYMINUTE=0` |

### Thanksgiving dinner

Another irregular interval, the ISO8601 format has to combine 400 separate recurrences.

| Format              | Value                                               |
| ------------------- | --------------------------------------------------- |
| Cron                | `0 18 ? 11 THU#L`                                   |
| ISO8601             | `R/2021-11-25T18:00:00/P400Y`                       |
| +                   | `R/2022-11-24T18:00:00/P400Y`                       |
| +                   | `R/2023-11-30T18:00:00/P400Y`                       |
| +                   | `R/2024-11-28T18:00:00/P400Y`                       |
| +                   | `R/2025-11-27T18:00:00/P400Y`                       |
| +                   | `R/2026-11-26T18:00:00/P400Y`                       |
| +                   | `R/2027-11-25T18:00:00/P400Y`                       |
| +                   | &vellip;                                            |
| +                   | _(400 entries total)_                               |
| ISO8601 (week date) | `R/2021-W47-4T18:00:00/P400Y`                       |
| +                   | `R/2022-W47-4T18:00:00/P400Y`                       |
| +                   | `R/2023-W48-4T18:00:00/P400Y`                       |
| +                   | `R/2024-W48-4T18:00:00/P400Y`                       |
| +                   | `R/2025-W48-4T18:00:00/P400Y`                       |
| +                   | `R/2026-W48-4T18:00:00/P400Y`                       |
| +                   | `R/2027-W47-4T18:00:00/P400Y`                       |
| +                   | &vellip;                                            |
| +                   | _(400 entries total)_                               |
| RFC5545             | `RRULE:FREQ=YEARLY;BYMONTH=11;BYDAY=-1TH;BYHOUR=18;BYMINUTE=0` |

### Antepenultimate Fridays, at 17:30

Neither cron nor ISO8601 is able to count a month's days of the week backwards the way iCalendar can.

| Format  | Value                                                 |
| ------- | ----------------------------------------------------- |
| Cron    | _(not supported)_                                     |
| ISO8601 | _(not supported)_                                     |
| RFC5545 | `RRULE:FREQ=MONTHLY;BYDAY=-3FR;BYHOUR=17;BYMINUTE=30` |

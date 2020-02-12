XSLT 2.0 QuickRef
=================

- [XSLT 2.0 QuickRef](#xslt-20-quickref)
  - [Declarations](#declarations)
  - [Instructions](#instructions)
  - [Functions](#functions)
  - [Namespaces](#namespaces)
- [XPath 2.0](#xpath-20)
  - [Paths](#paths)
    - [Axes](#axes)
    - [Node Tests](#node-tests)
  - [Accessors](#accessors)
  - [Nodes](#nodes)
  - [Sequences](#sequences)
  - [Context](#context)
  - [Numeric](#numeric)
  - [String](#string)
  - [Durations,<br/>Dates &amp; Times](#durationsbrdates--times)
    - [Arithmetic Operators](#arithmetic-operators)
    - [Comparison Operators](#comparison-operators)
    - [Functions](#functions-1)
  - [Boolean](#boolean)
  - [anyURI](#anyuri)
  - [QNames](#qnames)
  - [Other eq ne](#other-eq-ne)
  - [Error &amp; Trace](#error--trace)
  - [Type Expressions](#type-expressions)
  - [Constructors/Casts](#constructorsbrcasts)

Declarations
------------

- [xsl:attribute-set](https://www.w3.org/TR/xslt20/#element-attribute-set)
  - [xsl:attribute](https://www.w3.org/TR/xslt20/#element-attribute)\*
- [xsl:character-map](https://www.w3.org/TR/xslt20/#element-character-map)
  - [xsl:output-character](https://www.w3.org/TR/xslt20/#element-output-character)\*
- [xsl:decimal-format](https://www.w3.org/TR/xslt20/#element-decimal-format)
- [xsl:function](https://www.w3.org/TR/xslt20/#element-function)
  1. [xsl:param](https://www.w3.org/TR/xslt20/#element-param)\*
- [xsl:import-schema](https://www.w3.org/TR/xslt20/#element-import-schema)
- [xsl:include](https://www.w3.org/TR/xslt20/#element-include)
- [xsl:key](https://www.w3.org/TR/xslt20/#element-key)
- [xsl:namespace-alias](https://www.w3.org/TR/xslt20/#element-namespace-alias)
- [xsl:output](https://www.w3.org/TR/xslt20/#element-output)
- [xsl:param](https://www.w3.org/TR/xslt20/#element-param)
- [xsl:preserve-space](https://www.w3.org/TR/xslt20/#element-preserve-space)
- [xsl:strip-space](https://www.w3.org/TR/xslt20/#element-strip-space)
- [xsl:stylesheet](https://www.w3.org/TR/xslt20/#element-stylesheet)
  1. [xsl:import](https://www.w3.org/TR/xslt20/#element-import)\*
- [xsl:template](https://www.w3.org/TR/xslt20/#element-template)
- [xsl:transform](https://www.w3.org/TR/xslt20/#element-transform)
  1. [xsl:import](https://www.w3.org/TR/xslt20/#element-import)\*
- [xsl:variable](https://www.w3.org/TR/xslt20/#element-variable)

Instructions
------------

- [xsl:analyze-string](https://www.w3.org/TR/xslt20/#element-analyze-string)
  1. [xsl:matching-substring](https://www.w3.org/TR/xslt20/#element-matching-substring)?
  1. [xsl:non-matching-substring](https://www.w3.org/TR/xslt20/#element-non-matching-substring)?
  1. [xsl:fallback](https://www.w3.org/TR/xslt20/#element-fallback)\*
- [xsl:apply-imports](https://www.w3.org/TR/xslt20/#element-apply-imports)
  - [xsl:with-param](https://www.w3.org/TR/xslt20/#element-with-param)\*
- [xsl:apply-templates](https://www.w3.org/TR/xslt20/#element-apply-templates)
  - [xsl:sort](https://www.w3.org/TR/xslt20/#element-sort)\*
  - [xsl:with-param](https://www.w3.org/TR/xslt20/#element-with-param)\*
- [xsl:attribute](https://www.w3.org/TR/xslt20/#element-attribute)
- [xsl:call-template](https://www.w3.org/TR/xslt20/#element-call-template)
  - [xsl:with-param](https://www.w3.org/TR/xslt20/#element-with-param)\*
- [xsl:choose](https://www.w3.org/TR/xslt20/#element-choose)
  1. [xsl:when](https://www.w3.org/TR/xslt20/#element-when)+
  1. [xsl:otherwise](https://www.w3.org/TR/xslt20/#element-otherwise)?
- [xsl:comment](https://www.w3.org/TR/xslt20/#element-comment)
- [xsl:copy](https://www.w3.org/TR/xslt20/#element-copy)
- [xsl:copy-of](https://www.w3.org/TR/xslt20/#element-copy-of)
- [xsl:document](https://www.w3.org/TR/xslt20/#element-document)
- [xsl:element](https://www.w3.org/TR/xslt20/#element-element)
- [xsl:fallback](https://www.w3.org/TR/xslt20/#element-fallback)
- [xsl:for-each](https://www.w3.org/TR/xslt20/#element-for-each)
  1. [xsl:sort](https://www.w3.org/TR/xslt20/#element-sort)\*
- [xsl:for-each-group](https://www.w3.org/TR/xslt20/#element-for-each-group)
  1. [xsl:sort](https://www.w3.org/TR/xslt20/#element-sort)\*
- [xsl:if](https://www.w3.org/TR/xslt20/#element-if)
- [xsl:message](https://www.w3.org/TR/xslt20/#element-message)
- [xsl:namespace](https://www.w3.org/TR/xslt20/#element-namespace)
- [xsl:next-match](https://www.w3.org/TR/xslt20/#element-next-match)
- [xsl:number](https://www.w3.org/TR/xslt20/#element-number)
- [xsl:perform-sort](https://www.w3.org/TR/xslt20/#element-perform-sort)
  1. [xsl:sort](https://www.w3.org/TR/xslt20/#element-sort)+
- [xsl:processing-instruction](https://www.w3.org/TR/xslt20/#element-processing-instruction)
- [xsl:result-document](https://www.w3.org/TR/xslt20/#element-result-document)
- [xsl:sequence](https://www.w3.org/TR/xslt20/#element-sequence)
  - [xsl:fallback](https://www.w3.org/TR/xslt20/#element-fallback)\*
- [xsl:text](https://www.w3.org/TR/xslt20/#element-text)
- [xsl:value-of](https://www.w3.org/TR/xslt20/#element-value-of)

Functions
---------

- [current](https://www.w3.org/TR/xslt20/#function-current)
- [document](https://www.w3.org/TR/xslt20/#function-document)
- [generate-id](https://www.w3.org/TR/xslt20/#function-generate-id)
- [format-date](https://www.w3.org/TR/xslt20/#function-format-date)
- [format-dateTime](https://www.w3.org/TR/xslt20/#function-format-dateTime)
- [format-number](https://www.w3.org/TR/xslt20/#function-format-number)
- [format-time](https://www.w3.org/TR/xslt20/#function-format-time)
- [key](https://www.w3.org/TR/xslt20/#function-key)
- [system-property](https://www.w3.org/TR/xslt20/#function-system-property)
  - xsl:is-schema-aware
  - xsl:product-name
  - xsl:product-version
  - xsl:supports-backwards- compatibility
  - xsl:supports-serialization
  - xsl:vendor
  - xsl:vendor-url
  - xsl:version
- [unparsed-entity-public-id](https://www.w3.org/TR/xslt20/#function-unparsed-entity-public-id)
- [unparsed-entity-uri](https://www.w3.org/TR/xslt20/#function-unparsed-entity-uri)
- [unparsed-text](https://www.w3.org/TR/xslt20/#function-unparsed-text)
- [unparsed-text-available](https://www.w3.org/TR/xslt20/#function-unparsed-text-available)

Namespaces
----------

- [xsl](http://www.w3.org/1999/XSL/Transform)
- [xs](http://www.w3.org/2001/XMLSchema)
- [fn](http://www.w3.org/2006/xpath-functions)
- [err](http://www.w3.org/2005/xqt-errors)

***

<!-- markdownlint-disable single-title -->

[XPath 2.0][]
=============

[XPath 2.0]: https://www.w3.org/TR/xpath20/

[Paths][]
---------

[Paths]: https://www.w3.org/TR/xpath20#id-path-expressions

### [Axes](https://www.w3.org/TR/xpath20#axes)

▶️ forward, ◀️ backward

- ◀️ ancestor
- ◀️ ancestor-or-self
- ▶️ attribute @
- ▶️ child
- ▶️ descendant
- ▶️ descendant-or-self //
- ▶️ following
- ▶️ following-sibling
- ▶️ namespace
- ◀️ parent ..
- ◀️ preceding
- ◀️ preceding-sibling
- ▶️ self .

### [Node Tests](https://www.w3.org/TR/xpath20#doc-xpath-KindTest)

- \* &nbsp; _ns_:\* &nbsp; \*:_name_
- attribute()
- attribute(_name_)
- attribute(_name_,_attribute-type_)
- comment()
- document-node()
- document-node(element(_..._))
- document-node( schema-element( _element-type_ ) )
- element()
- element(_name_)
- element(_name_,_element-type_)
- processing-instruction()
- processing-instruction(_name_)
- node()
- schema-element(_element-type_)
- text()

Accessors
---------

- [base-uri](http://www.w3.org/TR/xpath-functions/#func-base-uri)
- [data](http://www.w3.org/TR/xpath-functions/#func-data)
- [document-uri](http://www.w3.org/TR/xpath-functions/#func-document-uri)
- [nilled](http://www.w3.org/TR/xpath-functions/#func-nilled)
- [node-name](http://www.w3.org/TR/xpath-functions/#func-node-name)
- [string](http://www.w3.org/TR/xpath-functions/#func-string)

Nodes
-----

- [is](http://www.w3.org/TR/xpath-functions/#func-is-same-node)
- [lang](http://www.w3.org/TR/xpath-functions/#func-lang)
- [local-name](http://www.w3.org/TR/xpath-functions/#func-local-name)
- [name](http://www.w3.org/TR/xpath-functions/#func-name)
- [namespace-uri](http://www.w3.org/TR/xpath-functions/#func-namespace-uri)
- [&gt;&gt;](http://www.w3.org/TR/xpath-functions/#func-node-after)
- [&lt;&lt;](http://www.w3.org/TR/xpath-functions/#func-node-before)
- [number](http://www.w3.org/TR/xpath-functions/#func-number)
- [root](http://www.w3.org/TR/xpath-functions/#func-root)

[Sequences][]
-------------

[Sequences]: https://www.w3.org/TR/xpath20#id-sequence-expressions

- [,](http://www.w3.org/TR/xpath-functions/#func-concatenate)
- [\[ _filter_ \]](http://www.w3.org/TR/xpath-functions/#id-filter-expr)
- [avg](http://www.w3.org/TR/xpath-functions/#func-avg)
- [boolean](http://www.w3.org/TR/xpath-functions/#func-boolean)
- [collection](http://www.w3.org/TR/xpath-functions/#func-collection)
- [count](http://www.w3.org/TR/xpath-functions/#func-count)
- [deep-equal](http://www.w3.org/TR/xpath-functions/#func-deep-equal)
- [distinct-values](http://www.w3.org/TR/xpath-functions/#func-distinct-values)
- [doc-available](http://www.w3.org/TR/xpath-functions/#func-doc-available)
- [doc](http://www.w3.org/TR/xpath-functions/#func-doc)
- [empty](http://www.w3.org/TR/xpath-functions/#func-empty)
- [every $_var_ in _sequence_ satisfies _expression_](https://www.w3.org/TR/xpath20/#id-quantified-expressions)
- [every $_var1_ in _sequence1_, $_var2_ in _sequence2_, _..._ satisfies _expression_](https://www.w3.org/TR/xpath20/#id-quantified-expressions)
- [exactly-one](http://www.w3.org/TR/xpath-functions/#func-exactly-one)
- [except](http://www.w3.org/TR/xpath-functions/#func-except)
- [exists](http://www.w3.org/TR/xpath-functions/#func-exists)
- [for $_var_ in _sequence_ return _expression_](https://www.w3.org/TR/xpath20/#id-for-expressions)
- [for $_var1_ in _sequence1_, $_var2_ in _sequence2_, _..._ return _expression_](https://www.w3.org/TR/xpath20/#id-for-expressions)
- [id](http://www.w3.org/TR/xpath-functions/#func-id)
- [idref](http://www.w3.org/TR/xpath-functions/#func-idref)
- [index-of](http://www.w3.org/TR/xpath-functions/#func-index-of)
- [insert-before](http://www.w3.org/TR/xpath-functions/#func-insert-before)
- [intersect](http://www.w3.org/TR/xpath-functions/#func-intersect)
- [max](http://www.w3.org/TR/xpath-functions/#func-max)
- [min](http://www.w3.org/TR/xpath-functions/#func-min)
- [one-or-more](http://www.w3.org/TR/xpath-functions/#func-one-or-more)
- [remove](http://www.w3.org/TR/xpath-functions/#func-remove)
- [reverse](http://www.w3.org/TR/xpath-functions/#func-reverse)
- [some $_var_ in _sequence_ satisfies _expression_](https://www.w3.org/TR/xpath20/#id-quantified-expressions)
- [some $_var1_ in _sequence1_, $_var2_ in _sequence2_, _..._ satisfies _expression_](https://www.w3.org/TR/xpath20/#id-quantified-expressions)
- [subsequence](http://www.w3.org/TR/xpath-functions/#func-subsequence)
- [sum](http://www.w3.org/TR/xpath-functions/#func-sum)
- [to](http://www.w3.org/TR/xpath-functions/#func-to)
- [union \|](http://www.w3.org/TR/xpath-functions/#func-union)
- [unordered](http://www.w3.org/TR/xpath-functions/#func-unordered)
- [zero-or-one](http://www.w3.org/TR/xpath-functions/#func-zero-or-one)

Context
-------

- [position](http://www.w3.org/TR/xpath-functions/#func-position)
- [last](http://www.w3.org/TR/xpath-functions/#func-last)
- [current-dateTime](http://www.w3.org/TR/xpath-functions/#func-current-dateTime)
- [current-date](http://www.w3.org/TR/xpath-functions/#func-current-date)
- [current-time](http://www.w3.org/TR/xpath-functions/#func-current-time)
- [implicit-timezone](http://www.w3.org/TR/xpath-functions/#func-implicit-timezone)
- [default-collation](http://www.w3.org/TR/xpath-functions/#func-default-collation)
- [static-base-uri](http://www.w3.org/TR/xpath-functions/#func-static-base-uri)

[Numeric][]
-----------

[Numeric]: https://www.w3.org/TR/xpath20#id-arithmetic

- [+](http://www.w3.org/TR/xpath-functions/#func-numeric-add)
- [-](http://www.w3.org/TR/xpath-functions/#func-numeric-subtract)
- [\*](http://www.w3.org/TR/xpath-functions/#func-numeric-multiply)
- [div](http://www.w3.org/TR/xpath-functions/#func-numeric-divide)
- [idiv](http://www.w3.org/TR/xpath-functions/#func-numeric-integer-divide)
- [mod](http://www.w3.org/TR/xpath-functions/#func-numeric-mod)
- [+_n_](http://www.w3.org/TR/xpath-functions/#func-numeric-unary-plus)
- [-_n_](http://www.w3.org/TR/xpath-functions/#func-numeric-unary-minus)
- [eq ne](http://www.w3.org/TR/xpath-functions/#func-numeric-equal)
- [lt le](http://www.w3.org/TR/xpath-functions/#func-numeric-less-than)
- [gt ge](http://www.w3.org/TR/xpath-functions/#func-numeric-greater-than)
- [abs](http://www.w3.org/TR/xpath-functions/#func-abs)
- *[ceiling](http://www.w3.org/TR/xpath-functions/#func-ceiling)*
- *[floor](http://www.w3.org/TR/xpath-functions/#func-floor)*
- *[round](http://www.w3.org/TR/xpath-functions/#func-round)*
- [round-half-to-even](http://www.w3.org/TR/xpath-functions/#func-round-half-to-even)

String
------

- [codepoint-equal](http://www.w3.org/TR/xpath-functions/#func-codepoint-equal)
- [codepoints-to-string](http://www.w3.org/TR/xpath-functions/#func-codepoints-to-string)
- [compare](http://www.w3.org/TR/xpath-functions/#func-compare)
- *[concat](http://www.w3.org/TR/xpath-functions/#func-concat)*
- *[contains](http://www.w3.org/TR/xpath-functions/#func-contains)*
- [encode-for-url](http://www.w3.org/TR/xpath-functions/#func-encode-for-url)
- [ends-with](http://www.w3.org/TR/xpath-functions/#func-ends-with)
- [escape-html-uri](http://www.w3.org/TR/xpath-functions/#func-escape-html-uri)
- [iri-to-uri](http://www.w3.org/TR/xpath-functions/#func-iri-to-uri)
- [lower-case](http://www.w3.org/TR/xpath-functions/#func-lower-case)
- [matches](http://www.w3.org/TR/xpath-functions/#func-matches)
- *[normalize-space](http://www.w3.org/TR/xpath-functions/#func-normalize-space)*
- [normalize-unicode](http://www.w3.org/TR/xpath-functions/#func-normalize-unicode)
- [replace](http://www.w3.org/TR/xpath-functions/#func-replace)
- *[starts-with](http://www.w3.org/TR/xpath-functions/#func-starts-with)*
- [string-join](http://www.w3.org/TR/xpath-functions/#func-string-join)
- *[string-length](http://www.w3.org/TR/xpath-functions/#func-string-length)*
- [string-to-codepoints](http://www.w3.org/TR/xpath-functions/#func-string-to-codepoints)
- *[substring-after](http://www.w3.org/TR/xpath-functions/#func-substring-after)*
- *[substring-before](http://www.w3.org/TR/xpath-functions/#func-substring-before)*
- *[substring](http://www.w3.org/TR/xpath-functions/#func-substring)*
- [tokenize](http://www.w3.org/TR/xpath-functions/#func-tokenize)
- *[translate](http://www.w3.org/TR/xpath-functions/#func-translate)*
- [upper-case](http://www.w3.org/TR/xpath-functions/#func-upper-case)

Durations,<br/>Dates &amp; Times
--------------------------------

### [Arithmetic Operators](https://www.w3.org/TR/xpath20#id-arithmetic)

- [xs:dayTimeDuration](http://www.w3.org/TR/xpath-functions/#dt-dayTimeDuration)
- [xs:yearMonthDuration](http://www.w3.org/TR/xpath-functions/#dt-yearMonthDuration)
- [dayTimeDuration + dayTimeDuration](http://www.w3.org/TR/xpath-functions/#func-add-dayTimeDurations)
- [dayTimeDuration + date](http://www.w3.org/TR/xpath-functions/#func-add-dayTimeDuration-to-date)
- [dayTimeDuration + dateTime](http://www.w3.org/TR/xpath-functions/#func-add-dayTimeDuration-to-dateTime)
- [dayTimeDuration + time](http://www.w3.org/TR/xpath-functions/#func-add-dayTimeDuration-to-time)
- [yearMonthDuration + yearMonthDuration](http://www.w3.org/TR/xpath-functions/#func-add-yearMonthDurations)
- [yearMonthDuration + date](http://www.w3.org/TR/xpath-functions/#func-add-yearMonthDuration-to-date)
- [yearMonthDuration + dateTime](http://www.w3.org/TR/xpath-functions/#func-add-yearMonthDuration-to-dateTime)
- [date - date](http://www.w3.org/TR/xpath-functions/#func-subtract-dates)
- [dateTime - dateTime](http://www.w3.org/TR/xpath-functions/#func-subtract-dateTimes)
- [dayTimeDuration - date](http://www.w3.org/TR/xpath-functions/#func-subtract-dayTimeDuration-from-date)
- [dayTimeDuration - dateTime](http://www.w3.org/TR/xpath-functions/#func-subtract-dayTimeDuration-from-dateTime)
- [dayTimeDuration - time](http://www.w3.org/TR/xpath-functions/#func-subtract-dayTimeDuration-from-time)
- [dayTimeDuration - dayTimeDuration](http://www.w3.org/TR/xpath-functions/#func-subtract-dayTimeDurations)
- [time - time](http://www.w3.org/TR/xpath-functions/#func-subtract-times)
- [yearMonthDuration - date](http://www.w3.org/TR/xpath-functions/#func-subtract-yearMonthDuration-from-date)
- [yearMonthDuration - dateTime](http://www.w3.org/TR/xpath-functions/#func-subtract-yearMonthDuration-from-dateTime)
- [yearMonthDuration - yearMonthDuration](http://www.w3.org/TR/xpath-functions/#func-subtract-yearMonthDurations)
- [dayTimeDuration \* double](http://www.w3.org/TR/xpath-functions/#func-multiply-dayTimeDuration)
- [yearMonthDuration \* double](http://www.w3.org/TR/xpath-functions/#func-multiply-yearMonthDuration)
- [dayTimeDuration div dayTimeDuration](http://www.w3.org/TR/xpath-functions/#func-divide-dayTimeDuration-by-dayTimeDuration)
- [dayTimeDuration div double](http://www.w3.org/TR/xpath-functions/#func-divide-dayTimeDuration)
- [yearMonthDuration div yearMonthDuration](http://www.w3.org/TR/xpath-functions/#func-divide-yearMonthDuration-by-yearMonthDuration)
- [yearMonthDuration div double](http://www.w3.org/TR/xpath-functions/#func-divide-yearMonthDuration)

### [Comparison Operators](https://www.w3.org/TR/xpath20#id-comparisons)

- [date: eq ne](http://www.w3.org/TR/xpath-functions/#func-date-equal)
- [date: gt ge](http://www.w3.org/TR/xpath-functions/#func-date-greater-than)
- [date: lt le](http://www.w3.org/TR/xpath-functions/#func-date-less-than)
- [dateTime: eq ne](http://www.w3.org/TR/xpath-functions/#func-dateTime-equal)
- [dateTime: gt ge](http://www.w3.org/TR/xpath-functions/#func-dateTime-greater-than)
- [dateTime: lt le](http://www.w3.org/TR/xpath-functions/#func-dateTime-less-than)
- [dayTimeDuration: gt ge](http://www.w3.org/TR/xpath-functions/#func-dayTimeDuration-greater-than)
- [dayTimeDuration: lt le](http://www.w3.org/TR/xpath-functions/#func-dayTimeDuration-less-than)
- [duration: eq ne](http://www.w3.org/TR/xpath-functions/#func-duration-equal)
- [gDay: eq ne](http://www.w3.org/TR/xpath-functions/#func-gDay-equal)
- [gMonthDay: eq ne](http://www.w3.org/TR/xpath-functions/#func-gMonthDay-equal)
- [gMonth: eq ne](http://www.w3.org/TR/xpath-functions/#func-gMonth-equal)
- [gYear: eq ne](http://www.w3.org/TR/xpath-functions/#func-gYear-equal)
- [gYearMonth: eq ne](http://www.w3.org/TR/xpath-functions/#func-gYearMonth-equal)
- [time: eq ne](http://www.w3.org/TR/xpath-functions/#func-time-equal)
- [time: gt ge](http://www.w3.org/TR/xpath-functions/#func-time-greater-than)
- [time: lt le](http://www.w3.org/TR/xpath-functions/#func-time-less-than)
- [yearMonthDuration: gt ge](http://www.w3.org/TR/xpath-functions/#func-yearMonthDuration-greater-than)
- [yearMonthDuration: lt le](http://www.w3.org/TR/xpath-functions/#func-yearMonthDuration-less-than)

### Functions

- [adjust-dateTime-to-timezone](http://www.w3.org/TR/xpath-functions/#func-adjust-dateTime-to-timezone)
- [adjust-date-to-timezone](http://www.w3.org/TR/xpath-functions/#func-adjust-date-to-timezone)
- [adjust-time-to-timezone](http://www.w3.org/TR/xpath-functions/#func-adjust-time-to-timezone)
- [day-from-date](http://www.w3.org/TR/xpath-functions/#func-day-from-date)
- [day-from-dateTime](http://www.w3.org/TR/xpath-functions/#func-day-from-dateTime)
- [days-from-duration](http://www.w3.org/TR/xpath-functions/#func-days-from-duration)
- [hours-from-dateTime](http://www.w3.org/TR/xpath-functions/#func-hours-from-dateTime)
- [hours-from-duration](http://www.w3.org/TR/xpath-functions/#func-hours-from-duration)
- [hours-from-time](http://www.w3.org/TR/xpath-functions/#func-hours-from-time)
- [minutes-from-dateTime](http://www.w3.org/TR/xpath-functions/#func-minutes-from-dateTime)
- [minutes-from-duration](http://www.w3.org/TR/xpath-functions/#func-minutes-from-duration)
- [minutes-from-time](http://www.w3.org/TR/xpath-functions/#func-minutes-from-time)
- [month-from-date](http://www.w3.org/TR/xpath-functions/#func-month-from-date)
- [month-from-dateTime](http://www.w3.org/TR/xpath-functions/#func-month-from-dateTime)
- [months-from-duration](http://www.w3.org/TR/xpath-functions/#func-months-from-duration)
- [seconds-from-dateTime](http://www.w3.org/TR/xpath-functions/#func-seconds-from-dateTime)
- [seconds-from-duration](http://www.w3.org/TR/xpath-functions/#func-seconds-from-duration)
- [seconds-from-time](http://www.w3.org/TR/xpath-functions/#func-seconds-from-time)
- [timezone-from-dateTime](http://www.w3.org/TR/xpath-functions/#func-timezone-from-dateTime)
- [timezone-from-date](http://www.w3.org/TR/xpath-functions/#func-timezone-from-date)
- [timezone-from-time](http://www.w3.org/TR/xpath-functions/#func-timezone-from-time)
- [year-from-dateTime](http://www.w3.org/TR/xpath-functions/#func-year-from-dateTime)
- [year-from-date](http://www.w3.org/TR/xpath-functions/#func-year-from-date)
- [years-from-duration](http://www.w3.org/TR/xpath-functions/#func-years-from-duration)

[Boolean][]
-----------

[Boolean]: https://www.w3.org/TR/xpath20/#id-logical-expressions

- [and](https://www.w3.org/TR/xpath20/#id-logical-expressions)
- [eq](http://www.w3.org/TR/xpath-functions/#func-boolean-equal)
- [gt ge](http://www.w3.org/TR/xpath-functions/#func-boolean-greater-than)
- [if ( _expression_ ) then _expression_ else _expression__](https://www.w3.org/TR/xpath20/#id-conditionals)
- [lt le](http://www.w3.org/TR/xpath-functions/#func-boolean-less-than)
- [false](http://www.w3.org/TR/xpath-functions/#func-false)
- [not](http://www.w3.org/TR/xpath-functions/#func-not)
- [or](https://www.w3.org/TR/xpath20/#id-logical-expressions)
- [true](http://www.w3.org/TR/xpath-functions/#func-true)

anyURI
------

- [resolve-uri](http://www.w3.org/TR/xpath-functions/#func-resolve-uri)

QNames
------

- [eq ne](http://www.w3.org/TR/xpath-functions/#func-QName-equal)
- [in-scope-prefixes](http://www.w3.org/TR/xpath-functions/#func-in-scope-prefixes)
- [local-name-from-QName](http://www.w3.org/TR/xpath-functions/#func-local-name-from-QName)
- [namespace-uri-for-prefix](http://www.w3.org/TR/xpath-functions/#func-namespace-uri-for-prefix)
- [namespace-uri-from-QName](http://www.w3.org/TR/xpath-functions/#func-namespace-uri-from-QName)
- [prefix-from-QName](http://www.w3.org/TR/xpath-functions/#func-prefix-from-QName)
- [QName](http://www.w3.org/TR/xpath-functions/#func-QName)
- [resolve-QName](http://www.w3.org/TR/xpath-functions/#func-resolve-QName)

Other eq ne
-----------

- [base64Binary](http://www.w3.org/TR/xpath-functions/#func-base64Binary-equal)
- [hexBinary](http://www.w3.org/TR/xpath-functions/#func-hexBinary-equal)
- [NOTATION](http://www.w3.org/TR/xpath-functions/#func-NOTATION-equal)

Error &amp; Trace
-----------------

- [error](http://www.w3.org/TR/xpath-functions/#func-error)
- [trace](http://www.w3.org/TR/xpath-functions/#func-trace)

[Type Expressions][]
--------------------

[Type Expressions]: https://www.w3.org/TR/xpath20/#id-expressions-on-datatypes

- [cast as](https://www.w3.org/TR/xpath20/#id-cast)
- [castable as](https://www.w3.org/TR/xpath20/#id-castable)
- [_constructor_(_expression_)](https://www.w3.org/TR/xpath20/#id-constructor-functions)
- [instance of](https://www.w3.org/TR/xpath20/#id-instance-of)
- [treat as](https://www.w3.org/TR/xpath20/#id-treat)

[Constructors][]/<br/>[Casts][]
-------------------------------

[Constructors]: http://www.w3.org/TR/xpath-functions/#constructor-functions
[Casts]: http://www.w3.org/TR/xpath-functions/#casting

- xs:anyURI
- xs:base64Binary
- xs:boolean
- xs:byte
- xs:date
- xs:dateTime
- [dateTime](http://www.w3.org/TR/xpath-functions/#func-dateTime)
- xs:dayTimeDuration
- xs:decimal #
- xs:double #
- xs:duration
- xs:ENTITY
- xs:float #
- xs:gDay
- xs:gMonthDay
- xs:gMonth
- xs:gYear
- xs:gYearMonth
- xs:hexBinary
- xs:ID
- xs:IDREF
- xs:integer #
- xs:int
- xs:language
- xs:long
- xs:Name
- xs:NCName
- xs:negativeInteger
- xs:NMTOKEN
- xs:nonNegativeInteger
- xs:nonPositiveInteger
- xs:normalizedString
- [~~xs:NOTATION~~](http://www.w3.org/TR/xpath-functions/#constructor-qname-notation)
- xs:positiveInteger
- [xs:QName](http://www.w3.org/TR/xpath-functions/#constructor-qname-notation)
- xs:short
- xs:string
- xs:time
- xs:token
- xs:unsignedByte
- xs:unsignedInt
- xs:unsignedLong
- xs:unsignedShort
- xs:untypedAtomic
- xs:yearMonthDuration

[XSchema built-in datatypes](https://www.w3.org/TR/xmlschema-2/#built-in-datatypes)

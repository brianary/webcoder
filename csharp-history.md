C# History
==========

C# has added many new keywords, syntax elements, and features since its introduction.

| Feature                                    | Keyword/Syntax                                                                                   | Version | Released   |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------ | ------- | ---------- |
| Anonymous methods                          | `delegate`                                                                                       | 2.0     | 2006-01-22 |
| Anonymous types                            | `new { }`                                                                                        | 3.0     | 2007-11-19 |
| Asynchronous members                       | `async` and `await`                                                                              | 5.0     | 2012-08-15 |
| Asynchronous streams                       | `async IAsyncEnumerable<T>` *Method( … )*                                                        | 8.0     | 2019-09-23 |
| Auto properties                            | *Property `{ get; set; }`*                                                                       | 3.0     | 2007-11-19 |
| Auto property initializers                 | *Property `{ get; set; } =` value`;`*                                                            | 6.0     | 2014-11-12 |
| Binary literals                            | `0b`*10011*                                                                                      | 7.0     | 2017-04-05 |
| Caller info attributes                     | `CallerFilePathAttribute`, `CallerLineNumberAttribute`,<br /> `CallerMemberNameAttribute`, `CallerArgumentExpressionAttribute`                                          | 5.0     | 2012-08-15 |
| Default interface methods                  | provide interface method implementations to inherit                                              | 8.0     | 2019-09-23 |
| Default literals                           | `default`                                                                                        | 7.1     | 2017-08-14 |
| Digit separators                           | *7*`_`*000*`_`*000*                                                                              | 7.0     | 2017-04-05 |
| Discards                                   | `_`                                                                                              | 7.0     | 2017-04-05 |
| Dynamic binding                            | `dynamic`                                                                                        | 4.0     | 2010-04-12 |
| Exception filters                          | *`catch (`ExceptionType e`) when` expression*                                                    | 6.0     | 2014-11-12 |
| Expression bodied members                  | *Member `=>` expression;* <br/> (method, operator, or read-only property)                        | 6.0     | 2014-11-12 |
| Expression bodied members: Expanded        | constructors, finalizers, indexers, and all properties now supported                             | 7.0     | 2017-04-05 |
| Extension methods                          | *Method`(this` Type param`)`*                                                                    | 3.0     | 2007-11-19 |
| File scoped namespaces                     | `namespace` *Name* `;`                                                                           | 10.0    | 2021-11-08 |
| Function pointers                          | `delegate*`                                                                                      | 9.0     | 2020-11-10 |
| Generics                                   | *Type*`<T>` and `System.Collections.Generic`                                                     | 2.0     | 2006-01-22 |
| Global usings                              | `global using` *Namespace* `;`                                                                   | 10.0    | 2021-11-08 |
| Implicitly typed local variables           | `var`                                                                                            | 3.0     | 2007-11-19 |
| In parameters                              | `in`                                                                                             | 7.2     | 2017-12-04 |
| Indices and ranges                         | `^` and `..` and `System.Index` and `System.Range`                                               | 8.0     | 2019-09-23 |
| Init only setters                          | *Property* `{ get; init; }`                                                                      | 9.0     | 2020-11-10 |
| Initializers                               | *`new` Type `{` … `}`* or *`new` CollectionType `{` item, item, item, … `}`*                     | 3.0     | 2007-11-19 |
| Iterators                                  | `yield return`                                                                                   | 2.0     | 2006-01-22 |
| Lambda expressions                         | *params `=>` expression*                                                                         | 3.0     | 2007-11-19 |
| Lambda expressions: Attributes             | *`var` name `=` `[`Attribute`]` params `=>` expression `;`*                                      | 10.0    | 2021-11-08 |
| Lambda expressions: Discard params         | *(`_`) `=>` expression*                                                                          | 9.0     | 2020-11-10 |
| Lambda expressions: Natural type           | *`var` name `=` params `=>` expression `;`* (or *name* as `object`, `Delegate`, &c)              | 10.0    | 2021-11-08 |
| Lambda expressions: Return type            | *`var` name `=` returntype params `=>` expression `;`*                                           | 10.0    | 2021-11-08 |
| Local functions                            | define a function inside a method or other function                                              | 7.0     | 2017-04-05 |
| Local functions: Attributes                | attributes are allowed before local functions                                                    | 9.0     | 2020-11-10 |
| Local functions: Extern                    | local functions may be marked as `extern`                                                        | 9.0     | 2020-11-10 |
| Local functions: Static                    | local functions can now be `static`                                                              | 8.0     | 2019-09-23 |
| Module initializers                        | `[System.Runtime.CompilerServices.ModuleInitializer]` *Method() { … }*                           | 9.0     | 2020-11-10 |
| Named argumentst                           | *Method`(` paramName`:` value`)`*                                                                | 4.0     | 2010-04-12 |
| Nameof operator                            | `nameof()`                                                                                       | 6.0     | 2014-11-12 |
| Native sized integers                      | `nint` (`System.IntPtr`) and `nuint` (`System.UIntPtr`)                                          | 9.0     | 2020-11-10 |
| Non-trailing named arguments               | named params can precede unnamed ones that are in the right position                             | 7.2     | 2017-12-04 |
| Null forgiving operator                    | `!`                                                                                              | 8.0     | 2019-09-23 |
| Null propagator                            | *x`?.`member* or *x`?[`expression`]`*                                                            | 6.0     | 2014-11-12 |
| Null-coalescing assignment                 | `??=`                                                                                            | 8.0     | 2019-09-23 |
| Nullable types                             | `Nullable<T>` or *Type*`?`                                                                       | 2.0     | 2006-01-22 |
| Nullable types: Reference types            | reference types may not be null without `?`, and require null-checking *with* it                 | 8.0     | 2019-09-23 |
| Out variables                              | *Method`(out var` param`)`*                                                                      | 7.0     | 2017-04-05 |
| Partial classes                            | `partial class` or `partial interface` or `partial struct`                                       | 2.0     | 2006-01-22 |
| Partial Methods                            | *`partial` ReturnType Method( … );*                                                              | 3.0     | 2007-11-19 |
| Pattern matching                           | *expression `is` pattern* (or `is not`) <br/> or *`switch(`expression`) { case` pattern`:` …`}`* | 7.0     | 2017-04-05 |
| Pattern matching: Conjunction              | *x `is` pattern `and` pattern*                                                                   | 9.0     | 2020-11-10 |
| Pattern matching: Disjunction              | *x `is` pattern `or` pattern*                                                                    | 9.0     | 2020-11-10 |
| Pattern matching: Negation                 | *x `is not` pattern* (not just types)                                                            | 9.0     | 2020-11-10 |
| Pattern matching: Parentheses              | *x `is (` patterns `) and (` patterns `)`*                                                       | 9.0     | 2020-11-10 |
| Pattern matching: Properties               | *expression `is {` Property`:` value `}`*                                                        | 8.0     | 2019-09-23 |
| Pattern matching: Properties: Extended     | *expression `is {` Property.Subproperty`:` value `}`*                                            | 10.0    | 2021-11-08 |
| Pattern matching: Relational               | *x `is >` value* (or `>=`, `<`, `<=`)                                                            | 9.0     | 2020-11-10 |
| Pattern matching: Switch expressions       | *expression `switch {` pattern `=>` value, … `}`*                                                | 8.0     | 2019-09-23 |
| Pattern matching: Tuples                   | *expression `is (` value/identifier`,` …`)`*                                                     | 8.0     | 2019-09-23 |
| Pattern matching: Type variables           | *x `is` type*                                                                                    | 9.0     | 2020-11-10 |
| Query expressions                          | `from item in Items …`                                                                           | 3.0     | 2007-11-19 |
| Readonly members                           | `readonly` *Method*                                                                              | 8.0     | 2019-09-23 |
| Records                                    | `record`                                                                                         | 9.0     | 2020-11-10 |
| Records: Record structs                    | `record struct`                                                                                  | 10.0    | 2021-11-08 |
| Static imports                             | *`using static` Namespace;*                                                                      | 6.0     | 2014-11-12 |
| Static lambdas and anonymous funcions      | lambdas and anonymous functions may be static                                                    | 9.0     | 2020-11-10 |
| String interpolation                       | *`$"`…`{`expression`}`…`"`*                                                                      | 6.0     | 2014-11-12 |
| String interpolation: Const                | *`const string` name `= $"`…{constantexpr}…`";`*                                                 | 10.0    | 2021-11-08 |
| String interpolation: Custom handler       | `[System.Runtime.CompilerServices.InterpolatedStringHandlerAttribute]` *class*                   | 10.0    | 2021-11-08 |
| String interpolation: Verbatim enhancement | `@$"…"` (previously only `$@"…"` worked)                                                         | 8.0     | 2019-09-23 |
| Struct initializers                        | *Parameter { get; init; } `=` value*                                                             | 10.0    | 2021-11-08 |
| Suppress emitting localsinit               | `System.Runtime.CompilerServices.SkipLocalsInitAttribute`                                        | 9.0     | 2020-11-10 |
| Target typed new                           | `new()` doesn't require a type name when inferrable                                              | 9.0     | 2020-11-10 |
| Throw expressions                          | *expr ? expr : `throw new` exception* <br/> *x ?? `throw new` exception* <br/> `=>` *exception*  | 7.0     | 2017-04-05 |
| Top level statements                       | statements in one source file outside any containing method imply program entry point            | 9.0     | 2020-11-20 |
| Tuples and deconstruction                  | *`(`Type`,` …`)` x = `(`value`,` …`);`* or with *`(`Type PropertyName`,` …`)`*                   | 7.0     | 2017-04-05 |
| Tuples: Inferred element names             | *list.Select(x => (x.Id, x.Name)).Where(y => y.Id == 1)*                                         | 7.1     | 2017-08-14 |
| Using declarations                         | *`using var `x` =` disposble`;`* (applies to end of scope)                                       | 8.0     | 2019-09-23 |

Source: [Microsoft Docs: C# Guide: The history of C#](https://docs.microsoft.com/dotnet/csharp/whats-new/csharp-version-history)
and [What's new in C# 10](https://docs.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-10).

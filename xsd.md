XML Schema
==========

[xs:schema][]🏷️

Part Ⅰ Declarations 🔁
----------------------

- [xs:include][]
- [xs:import][]
- [xs:redefine][]🏷️ 🔁
    - [xs:annotation][]🏷️
    - [xs:simpleType][]
    - [xs:complexType][]
    - [xs:group][]
    - [xs:attributeGroup][]
- [xs:annotation][] 🔁
    - [xs:appinfo][xs:annotation]🏷️
    - [xs:documentation][xs:annotation]🏷️

Part Ⅱ Definitions 🔁
----------------------

- [xs:simpleType][] 🔂
    - [xs:restriction][]
        1. [xs:simpleType][]
        2. 🔁
            - value ranges [xs:minExclusive][], [xs:minInclusive][], [xs:maxExclusive][], and/or [xs:maxInclusive][]
            - numeric precision [xs:totalDigits][] and/or [xs:fractionDigits][]
            - string length [xs:length][], [xs:minLength][], and/or [xs:maxLength][]
            - [xs:enumeration][]
            - [xs:whiteSpace][]
            - [xs:pattern][]
    - [xs:list][] ✅[xs:simpleType][]
    - [xs:union][] 🔁[xs:simpleType][]
- [xs:complexType][] 🔂
    - [xs:simpleContent][]
    - [xs:complexContent][]
    - this construct:
        1. ✅ [xs:group][], [xs:all][], [xs:choice][], or [xs:sequence][]
        2. 🔁 [xs:attribute][] and/or [xs:attributeGroup][]
        3. ✅ [xs:anyAttribute][]
- [xs:group][] 🔂
    - [xs:all][] 🔁 [xs:element][]
    - [xs:choice][] 🔁 [xs:element][], [xs:group][], [xs:choice][], [xs:sequence][], or [xs:any][]
    - [xs:sequence][] 🔁 [xs:element][], [xs:group][], [xs:choice][], [xs:sequence][], or [xs:any][]
- [xs:attributeGroup][]
    1. 🔁 [xs:attribute][] or [xs:attributeGroup][]
    2. ✅ [xs:anyAttribute][]
- [xs:element][]
    1. ✅ [xs:simpleType][] or [xs:complexType][]
    2. 🔁 [xs:unique][], [xs:key][], and/or [xs:keyref][]; each containing
        1. [xs:selector][]
        2. at least one [xs:field][]
- [xs:attribute][] ✅ [xs:simpleType][]
- [xs:notation][]
- [xs:annotation][]🏷️

* * *

- 🏷️ No optional [xs:annotation][] as the first child (all others immediately start with an optional [xs:annotation][]).
- ✅ Optionally contains one of the following.
- 🔁 Optionally contains any combination of the following.
- 🔂 Contains one of the following choices.

[xs:all]: https://www.w3.org/TR/xmlschema-1/#element-all
[xs:annotation]: https://www.w3.org/TR/xmlschema-1/#declare-annotation
[xs:anyAttribute]: https://www.w3.org/TR/xmlschema-1/#element-anyAttribute
[xs:attribute]: https://www.w3.org/TR/xmlschema-1/#declare-attribute
[xs:attributeGroup]: https://www.w3.org/TR/xmlschema-1/#declare-attributeGroup
[xs:choice]: https://www.w3.org/TR/xmlschema-1/#element-choice
[xs:complexContent]: https://www.w3.org/TR/xmlschema-1/#element-complexContent
[xs:complexType]: https://www.w3.org/TR/xmlschema-1/#declare-type
[xs:element]: https://www.w3.org/TR/xmlschema-1/#declare-element
[xs:enumeration]: https://www.w3.org/TR/xmlschema-2/#element-enumeration
[xs:field]: https://www.w3.org/TR/xmlschema-1/#element-field
[xs:fractionDigits]: https://www.w3.org/TR/xmlschema-2/#element-fractionDigits
[xs:group]: https://www.w3.org/TR/xmlschema-1/#declare-namedModelGroup
[xs:import]: https://www.w3.org/TR/xmlschema-1/#composition-schemaImport
[xs:include]: https://www.w3.org/TR/xmlschema-1/#compound-schema
[xs:key]: https://www.w3.org/TR/xmlschema-1/#element-key
[xs:keyref]: https://www.w3.org/TR/xmlschema-1/#element-keyref
[xs:length]: https://www.w3.org/TR/xmlschema-2/#element-length
[xs:list]: https://www.w3.org/TR/xmlschema-2/#derivation-by-list
[xs:maxExclusive]: https://www.w3.org/TR/xmlschema-2/#element-maxExclusive
[xs:maxInclusive]: https://www.w3.org/TR/xmlschema-2/#element-maxInclusive
[xs:maxLength]: https://www.w3.org/TR/xmlschema-2/#element-maxLength
[xs:minExclusive]: https://www.w3.org/TR/xmlschema-2/#element-minExclusive
[xs:minInclusive]: https://www.w3.org/TR/xmlschema-2/#element-minInclusive
[xs:minLength]: https://www.w3.org/TR/xmlschema-2/#element-minLength
[xs:notation]: https://www.w3.org/TR/xmlschema-1/#declare-notation
[xs:pattern]: https://www.w3.org/TR/xmlschema-2/#element-pattern
[xs:redefine]: https://www.w3.org/TR/xmlschema-1/#modify-schema
[xs:restriction]: https://www.w3.org/TR/xmlschema-2/#derivation-by-restriction
[xs:schema]: https://www.w3.org/TR/xmlschema-1/#declare-schema
[xs:selector]: https://www.w3.org/TR/xmlschema-1/#element-selector
[xs:sequence]: https://www.w3.org/TR/xmlschema-1/#element-sequence
[xs:simpleContent]: https://www.w3.org/TR/xmlschema-1/#element-simpleContent
[xs:simpleType]: https://www.w3.org/TR/xmlschema-2/#xr-defn
[xs:totalDigits]: https://www.w3.org/TR/xmlschema-2/#element-totalDigits
[xs:union]: https://www.w3.org/TR/xmlschema-2/#derivation-by-union
[xs:unique]: https://www.w3.org/TR/xmlschema-1/#element-unique
[xs:whiteSpace]: https://www.w3.org/TR/xmlschema-2/#element-whiteSpace

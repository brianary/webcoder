XML Schema
==========

- [xs:schema][]
    1. declarations 🔁
        - [xs:include][] 📝
        - [xs:import][] 📝
        - [xs:redefine][] 🔁
            - [xs:annotation][]
            - [xs:simpleType][]
            - [xs:complexType][]
            - [xs:group][]
            - [xs:attributeGroup][]
        - [xs:annotation][] 🔁
            - [xs:appinfo][xs:annotation]
            - [xs:documentation][xs:annotation]
    2. definitions 🔁
        - [xs:simpleType][] 📝🔂
            - [xs:restriction][] 📝
                1. [xs:simpleType][] 📝
                2. 🔁
                    - value ranges [xs:minExclusive][], [xs:minInclusive][], [xs:maxExclusive][], and/or [xs:maxInclusive][]
                    - numeric precision [xs:totalDigits][] and/or [xs:fractionDigits][]
                    - string length [xs:length][], [xs:minLength][], and/or [xs:maxLength][]
                    - [xs:enumeration][]
                    - [xs:whiteSpace][]
                    - [xs:pattern][]
            - [xs:list][] 📝 ✅ [xs:simpleType][]
            - [xs:union][] 🔁 [xs:simpleType][]
        - [xs:complexType][] 📝🔂
            - [xs:simpleContent][]
            - [xs:complexContent][]
            - this construct:
                1. ✅ [xs:group][], [xs:all][], [xs:choice][], or [xs:sequence][]
                2. 🔁 [xs:attribute][] and/or [xs:attributeGroup][]
                3. ✅ [xs:anyAttribute][]
        - [xs:group][] 📝 ✅ [xs:all][], [xs:choice][], or [xs:sequence][]
        - [xs:attributeGroup][] 📝
            1. 🔁 [xs:attribute][] or [xs:attributeGroup][]
            2. ✅ [xs:anyAttribute][]
        - [xs:element][] 📝
            1. ✅ [xs:simpleType][] or [xs:complexType][]
            2. 🔁 [xs:unique][], [xs:key][], and/or [xs:keyref][]
        - [xs:attribute][] 📝 ✅ [xs:simpleType][]
        - [xs:notation][] 📝
        - [xs:annotation][]

- 📝 accepts an optional [xs:annotation][] as the first child
- ✅ optionally contains one of the following
- 🔁 optionally contains any combination of the following
- 🔂 contains one of the following choices

[xs:all]: #TODO
[xs:annotation]: https://www.w3.org/TR/xmlschema-1/#declare-annotation
[xs:anyAttribute]: #TODO
[xs:attribute]: https://www.w3.org/TR/xmlschema-1/#declare-attribute
[xs:attributeGroup]: https://www.w3.org/TR/xmlschema-1/#declare-attributeGroup
[xs:choice]: #TODO
[xs:complexContent]: #TODO
[xs:complexType]: https://www.w3.org/TR/xmlschema-1/#declare-type
[xs:element]: https://www.w3.org/TR/xmlschema-1/#declare-element
[xs:enumeration]: #TODO
[xs:fractionDigits]: #TODO
[xs:group]: https://www.w3.org/TR/xmlschema-1/#declare-namedModelGroup
[xs:import]: https://www.w3.org/TR/xmlschema-1/#composition-schemaImport
[xs:include]: https://www.w3.org/TR/xmlschema-1/#compound-schema
[xs:key]: #TODO
[xs:keyref]: #TODO
[xs:length]: #TODO
[xs:list]: https://www.w3.org/TR/xmlschema-2/#derivation-by-list
[xs:maxExclusive]: #TODO
[xs:maxInclusive]: #TODO
[xs:maxLength]: #TODO
[xs:minExclusive]: #TODO
[xs:minInclusive]: #TODO
[xs:minLength]: #TODO
[xs:notation]: https://www.w3.org/TR/xmlschema-1/#declare-notation
[xs:pattern]: #TODO
[xs:redefine]: https://www.w3.org/TR/xmlschema-1/#modify-schema
[xs:restriction]: https://www.w3.org/TR/xmlschema-2/#derivation-by-restriction
[xs:schema]: https://www.w3.org/TR/xmlschema-1/#declare-schema
[xs:sequence]: #TODO
[xs:simpleContent]: #TODO
[xs:simpleType]: https://www.w3.org/TR/xmlschema-2/#xr-defn
[xs:totalDigits]: #TODO
[xs:union]: https://www.w3.org/TR/xmlschema-2/#derivation-by-union
[xs:unique]: #TODO
[xs:whiteSpace]: #TODO

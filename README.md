



## Implementation Progress
- [x] Arithmetic (+, -, *, /, %)
    - [x] `+`, `-`, `*` `PredicateExpressions.Arithmetic`
    - [x] `/`  `PredicateExpressions.FloatDivision`
    - [x] `/`  `PredicateExpressions.IntDivision`
    - [x] `%`  `PredicateExpressions.IntRemainder`

- [x] Unary minus `-` `PredicateExpressions.UnaryMinus`

- [x] Range (..., ..<)
    - [x] `...` `PredicateExpressions.ClosedRange`
    - [x] `..<` `PredicateExpressions.Range`
    - [x] `x..<z).contains(y)` `PredicateExpressions.RangeExpressionContains`

- [x] Comparison (<, <=, >, >=, ==, !=)
    - [x] `<`, `<=`, `>`, `>=` `PredicateExpressions.Comparison`
    - [x] `==` `PredicateExpressions.Equal`
    - [x] `!=` `PredicateExpressions.NotEqual`

- [x] Conditionals & Ternary (?:) `PredicateExpressions.Conditional`

- [x] Boolean logic (&&, ||, !)
    - [x] `&&` `PredicateExpressions.Conjunction`
    - [x] `||` `PredicateExpressions.Disjunction`
    - [x] `!`  `PredicateExpressions.Negation`

- [ ] Swift optionals (?, ??, !, flatMap(_:), if-let expressions)
    - [ ] `?`, `flatMap(_:)` `PredicateExpressions.OptionalFlatMap`
    - [x] `??`, `if-let` `PredicateExpressions.NilCoalesce`

- [x] Types (as, as?, as!, is)  [completion:: 2024-03-10]
    - [x] `as?` `PredicateExpressions.ConditionalCast`  [completion:: 2024-03-10]
    - [x] `as`, `as!` `PredicateExpressions.ForceCast`  [completion:: 2024-03-10]

- [x] Sequence operations (allSatisfy(), filter(), contains(), contains(where:), starts(with:), max(), min())  [completion:: 2024-03-10]
    - [x] `allSatisfy()` `PredicateExpressions.SequenceAllSatisfy`  [completion:: 2024-03-10]
    - [x] `filter()`  `PredicateExpressions.Filter` [completion:: 2024-03-10]
    - [x] `contains()`  `PredicateExpressions.SequenceContains` [completion:: 2024-03-10]
    - [x] `contains(where:)` `PredicateExpressions.SequenceContainsWhere`  [completion:: 2024-03-10]
    - [x] `starts(with:)` `PredicateExpressions.SequenceStartsWith`  [completion:: 2024-03-10]
    - [x] `min()`  `PredicateExpressions.SequenceMinimum` [completion:: 2024-03-10]
    - [x] `max()` `PredicateExpressions.SequenceMaximum`  [completion:: 2024-03-10]

- [x] Subscript and member access ([], .)  [completion:: 2024-03-10]
    - [x] `[0,1][0]` `PredicateExpressions.CollectionIndexSubscript`  [completion:: 2024-03-10]
    - [x] `["a": "b"]["a"]` `PredicateExpressions.DictionaryKeySubscript`  [completion:: 2024-03-10]
    - [x] `["a": "b"]["a", defaultValue: "b"]` `PredicateExpressions.DictionaryKeyDefaultValueSubscript`  [completion:: 2024-03-10]
    - [x] `obj.someKey` `PredicateExpressions.KeyPath`  [completion:: 2024-03-10]

- [x] String comparisons  [completion:: 2024-03-10]
    - [x] `contains(_:)`  `PredicateExpressions.CollectionContainsCollection`  [completion:: 2024-03-10]
    - [x] `localizedStandardContains(_:)`  `PredicateExpressions.StringLocalizedStandardContains`  [completion:: 2024-03-10]
    - [x] `caseInsensitiveCompare(_:)` `PredicateExpressions.StringCaseInsensitiveCompare`  [completion:: 2024-03-10]
    - [x] `localizedCompare(_:)` `PredicateExpressions.StringLocalizedCompare`  [completion:: 2024-03-10]

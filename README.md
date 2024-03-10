[![Build & Test](https://github.com/NoahKamara/CompoundPredicate/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/NoahKamara/CompoundPredicate/actions/workflows/build-and-test.yml)

# CompoundPredicate

CompoundPredicate aims to improve the Predicate system to enable combining multiple predicates after constructing them:

```swift
let notTooShort = #Predicate<Book> {
    $0.pages > 50
}

let notTooLong = #Predicate<Book> {
    $0.pages <= 350
}

let lengthFilter = [notTooShort, notTooShort].conjunction()

// Match Books that are just the right length
let titleFilter = #Predicate<Book> {
    $0.title.contains("Swift")
}

// Match Books that contain "Swift" in the title or
// are just the right length
let filter = [lengthFilter, titleFilter].disjunction()
```


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

- [x] Types (as, as?, as!, is)
    - [x] `as?` `PredicateExpressions.ConditionalCast`
    - [x] `as`, `as!` `PredicateExpressions.ForceCast`

- [x] Sequence operations (allSatisfy(), filter(), contains(), contains(where:), starts(with:), max(), min())
    - [x] `allSatisfy()` `PredicateExpressions.SequenceAllSatisfy`
    - [x] `filter()`  `PredicateExpressions.Filter` [completion:: 2024-03-10]
    - [x] `contains()`  `PredicateExpressions.SequenceContains` [completion:: 2024-03-10]
    - [x] `contains(where:)` `PredicateExpressions.SequenceContainsWhere`
    - [x] `starts(with:)` `PredicateExpressions.SequenceStartsWith`
    - [x] `min()`  `PredicateExpressions.SequenceMinimum` [completion:: 2024-03-10]
    - [x] `max()` `PredicateExpressions.SequenceMaximum`

- [x] Subscript and member access ([], .)
    - [x] `[0,1][0]` `PredicateExpressions.CollectionIndexSubscript`
    - [x] `["a": "b"]["a"]` `PredicateExpressions.DictionaryKeySubscript`
    - [x] `["a": "b"]["a", defaultValue: "b"]` `PredicateExpressions.DictionaryKeyDefaultValueSubscript`
    - [x] `obj.someKey` `PredicateExpressions.KeyPath`

- [x] String comparisons
    - [x] `contains(_:)`  `PredicateExpressions.CollectionContainsCollection`
    - [x] `localizedStandardContains(_:)`  `PredicateExpressions.StringLocalizedStandardContains`
    - [x] `caseInsensitiveCompare(_:)` `PredicateExpressions.StringCaseInsensitiveCompare`
    - [x] `localizedCompare(_:)` `PredicateExpressions.StringLocalizedCompare`

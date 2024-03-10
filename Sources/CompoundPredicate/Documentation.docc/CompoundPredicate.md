# ``CompoundPredicate``



## Overview

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

## Topics

### Combining Predicates
- ``Swift/Array/conjunction()``
- ``Swift/Array/disjunction()``

### Custom Predicates
- ``CompoundPredicate/VariableReplacing``
- ``CompoundPredicate/VariableReplacingLeaf``

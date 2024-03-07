import Foundation



extension PredicateExpressions.Variable: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Variable<Output> {
        if let replacement = replacement as? Self, variable.key == key {
            return replacement
        } else {
            return self
        }
    }
}

extension PredicateExpressions.Arithmetic: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Arithmetic<LHS, RHS> {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement),
            op: op
        )
    }
}

extension PredicateExpressions.ClosedRange: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.ClosedRange<LHS, RHS> {
        Self(
            lower: lower.replacing(variable, with: replacement),
            upper: upper.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.CollectionContainsCollection: VariableReplacing where Base: VariableReplacing, Other: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.CollectionContainsCollection<Base, Other> {
        Self(
            base: base.replacing(variable, with: replacement),
            other: other.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.CollectionIndexSubscript: VariableReplacing where Wrapped: VariableReplacing, Index: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.CollectionIndexSubscript<Wrapped, Index> {
        Self(
            wrapped: wrapped.replacing(variable, with: replacement),
            index: index.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.CollectionRangeSubscript: VariableReplacing where Wrapped: VariableReplacing, Range: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.CollectionRangeSubscript<Wrapped, Range> {
        Self(
            wrapped: wrapped.replacing(variable, with: replacement),
            range: range.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.Comparison: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing{
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Comparison<LHS, RHS> {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement),
            op: op
        )
    }
}

extension PredicateExpressions.Conditional: VariableReplacing where Test: VariableReplacing, If: VariableReplacing, Else: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Conditional<Test, If, Else> {
        Self(
            test: test.replacing(variable, with: replacement),
            trueBranch: trueBranch.replacing(variable, with: replacement),
            falseBranch: falseBranch.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.ConditionalCast: VariableReplacing where Input: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.ConditionalCast<Input, Desired> {
        Self(input.replacingVariable(variable, with: replacement))
    }
}

extension PredicateExpressions.Conjunction: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Conjunction<LHS, RHS> {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.DictionaryKeyDefaultValueSubscript: VariableReplacing where Wrapped: VariableReplacing, Key: VariableReplacing, Default: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.DictionaryKeyDefaultValueSubscript<Wrapped, Key, Default> {
        Self(
            wrapped: wrapped.replacing(variable, with: replacement),
            key: key.replacing(variable, with: replacement),
            default: self.default.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.DictionaryKeySubscript: VariableReplacing where Wrapped: VariableReplacing, Key: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.DictionaryKeySubscript<Wrapped, Key, Value> {
        Self(
            wrapped: wrapped.replacing(variable, with: replacement),
            key: key.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.Disjunction: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Disjunction<LHS, RHS> {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.Equal: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Equal<LHS, RHS> {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.NotEqual: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.Filter: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Filter<LHS, RHS> {
        Self(sequence.replacing(variable, with: replacement)) { elementVar in
            self
                .filter
                .replacing(self.variable, with: elementVar)
                .replacing(variable, with: replacement)
        }
    }
}

extension PredicateExpressions.FloatDivision: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.FloatDivision<LHS, RHS> {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.ForceCast: VariableReplacing where Input: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.ForceCast<Input, Desired> {
        Self(input.replacing(variable, with: replacement))
    }
}

extension PredicateExpressions.ForcedUnwrap: VariableReplacing where Inner: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.ForcedUnwrap<Inner, Wrapped> {
        Self(inner.replacing(variable, with: replacement))
    }
}

extension PredicateExpressions.IntDivision: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.IntDivision<LHS, RHS> {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.IntRemainder: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.IntRemainder<LHS, RHS> {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.KeyPath: VariableReplacing where Root: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self {
        Self(
            root: root.replacing(variable, with: replacement),
            keyPath: keyPath
        )
    }
}

extension PredicateExpressions.Negation: VariableReplacing where Wrapped: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self {
        Self(wrapped.replacing(variable, with: replacement))
    }
}

extension PredicateExpressions.NilCoalesce: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self {
        Self(
            lhs: lhs.replacing(variable, with: replacement),
            rhs: rhs.replacing(variable, with: replacement)
        )
    }
}


//extension PredicateExpressions.OptionalFlatMap: VariableReplacing {
//
//}

//extension PredicateExpressions.PredicateEvaluate: VariableReplacing {
//
//}

//extension PredicateExpressions.Range: VariableReplacing {
//
//}

//extension PredicateExpressions.RangeExpressionContains: VariableReplacing {
//
//}

//extension PredicateExpressions.SequenceAllSatisfy: VariableReplacing {
//
//}

extension PredicateExpressions.SequenceContains: VariableReplacing where LHS: VariableReplacing, RHS: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.SequenceContains<LHS, RHS> {
        Self(
            sequence: sequence.replacing(variable, with: replacement),
            element: element.replacing(variable, with: replacement)
        )
    }
}

//extension PredicateExpressions.SequenceContainsWhere: VariableReplacing where Self: StandardPredicateExpression {
//    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.SequenceContainsWhere<LHS, RHS> {
//        let elVariable = self.variable
//
//        return Self.init(
//            sequence.replaceVariable(variable, with: replacement)) { elReplacement in
//                test
//                    .replaceVariable(variable, with: replacement)
//                    .replaceVariable(elVariable, with: elReplacement)
//
//            }
//    }
//}

//extension PredicateExpressions.SequenceMaximum: VariableReplacing {
//
//}

//extension PredicateExpressions.SequenceMinimum: VariableReplacing {
//
//}

extension PredicateExpressions.SequenceStartsWith: VariableReplacing where Base: VariableReplacing, Prefix: VariableReplacing {
    public func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.SequenceStartsWith<Base, Prefix> {
        Self(
            base: self.base.replacing(variable, with: replacement),
            prefix: self.prefix.replacing(variable, with: replacement)
        )
    }
}

//extension PredicateExpressions.SmallestSubset: VariableReplacing {
//
//}

//extension PredicateExpressions.StringCaseInsensitiveCompare: VariableReplacing {
//
//}

//extension PredicateExpressions.StringLocalizedCompare: VariableReplacing {
//
//}

//extension PredicateExpressions.StringLocalizedStandardContains: VariableReplacing {
//
//}

//extension PredicateExpressions.TypeCheck: VariableReplacing {
//
//}

//extension PredicateExpressions.UnaryMinus: VariableReplacing {
//
//}

extension PredicateExpressions.Value: VariableReplacingLeaf {}


//extension PredicateExpressions.VariableID: VariableReplacing {
//
//}

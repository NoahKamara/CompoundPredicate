// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

// MARK: VariableReplacing
protocol VariableReplacing<Output>: StandardPredicateExpression {
    associatedtype Output
    typealias Variable<T> = PredicateExpressions.Variable<T>
    
    /// Recursively traverses itself and returns a copy replacing all occurences of `variable` with `replacement`
    /// - Parameters:
    ///   - variable: a variable that should be replaced
    ///   - replacement: the variable it should be replaced with
    /// - Returns: a copy replacing all occurences of `variable` with `replacement`
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self
}

// MARK: Predicate
extension Predicate {
    /// Recursively traverses itself and returns a copy replacing all occurences of `variable` with `replacement`
    /// - **if** Self conforms to ``CompoundPredicate/VariableReplacing``
    /// - **otherwise** returns a copy of ittself
    /// - Parameters:
    ///   - variable: a variable that should be replaced
    ///   - replacement: the variable it should be replaced with
    /// - Returns: a copy replacing all occurences of `variable` with `replacement`
    func replace(
        with replacement: repeat PredicateExpressions.Variable<each Input>
    ) -> any StandardPredicateExpression<Bool> {
//        guard var expression = expression as? any VariableReplacing<Bool> else {
//            print("expression is not variableReplacing", type(of: expression))
//            return expression
//        }
        var expression = expression

        func replace<T>(
            _ variable: PredicateExpressions.Variable<T>,
            with replacement: PredicateExpressions.Variable<T>
        ) {
            expression = expression.replaceVariable(variable, with: replacement)
        }

        repeat replace(each variable, with: each replacement)

        return expression
    }
}

extension StandardPredicateExpression {
    func replaceVariable<T>(
        _ variable: PredicateExpressions.Variable<T>,
        with replacement: PredicateExpressions.Variable<T>
    ) -> Self {
        if let replacingExpr = self as? any VariableReplacing<Output> {
            return replacingExpr.replace(variable, with: replacement) as! Self
        } else {
            print(Self.self, "is not replacing")
            return self
        }
    }
}

// MARK: Implementations

//extension PredicateExpressions.Arithmetic: VariableReplacing where Self: StandardPredicateExpression {
//    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Arithmetic<LHS, RHS> {
//        Self(
//            lhs: lhs.replaceVariable(variable, with: replacement),
//            rhs: rhs.replaceVariable(variable, with: replacement),
//            op: op
//        )
//    }
//}

//extension PredicateExpressions.ClosedRange: VariableReplacing {
//
//}

//extension PredicateExpressions.CollectionContainsCollection: VariableReplacing {
//
//}

//extension PredicateExpressions.CollectionIndexSubscript: VariableReplacing {
//
//}

//extension PredicateExpressions.CollectionRangeSubscript: VariableReplacing {
//
//}

extension PredicateExpressions.Comparison: VariableReplacing where Self: StandardPredicateExpression {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Comparison<LHS, RHS> {
        Self(
            lhs: lhs.replaceVariable(variable, with: replacement),
            rhs: rhs.replaceVariable(variable, with: replacement),
            op: op
        )
    }
}

//extension PredicateExpressions.Conditional: VariableReplacing {
//
//}

//extension PredicateExpressions.ConditionalCast: VariableReplacing {
//
//}

//extension PredicateExpressions.Conjunction: VariableReplacing {
//
//}

//extension PredicateExpressions.DictionaryKeyDefaultValueSubscript: VariableReplacing {
//
//}

//extension PredicateExpressions.DictionaryKeySubscript: VariableReplacing {
//
//}

//extension PredicateExpressions.Disjunction: VariableReplacing {
//
//}

//extension PredicateExpressions.DonatedWithin: VariableReplacing {
//
//}

//extension PredicateExpressions.DonationFilter: VariableReplacing {
//
//}

extension PredicateExpressions.Equal: VariableReplacing where Self: StandardPredicateExpression {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Equal<LHS, RHS> {
        Self(
            lhs: lhs.replaceVariable(variable, with: replacement),
            rhs: rhs.replaceVariable(variable, with: replacement)
        )
    }
}

extension PredicateExpressions.NotEqual: VariableReplacing where Self: StandardPredicateExpression {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self {
        Self(
            lhs: lhs.replaceVariable(variable, with: replacement),
            rhs: rhs.replaceVariable(variable, with: replacement)
        )
    }
}

//extension PredicateExpressions.Filter: VariableReplacing {
//
//}

//extension PredicateExpressions.FloatDivision: VariableReplacing {
//
//}

//extension PredicateExpressions.ForceCast: VariableReplacing {
//
//}

//extension PredicateExpressions.ForcedUnwrap: VariableReplacing {
//
//}

//extension PredicateExpressions.IntDivision: VariableReplacing {
//
//}

//extension PredicateExpressions.IntRemainder: VariableReplacing {
//
//}

extension PredicateExpressions.KeyPath: VariableReplacing where Root: VariableReplacing {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.KeyPath<Root, Output> {
        Self(
            root: root.replace(variable, with: replacement),
            keyPath: keyPath
        )
    }
}

//extension PredicateExpressions.LargestSubset: VariableReplacing {
//
//}

extension PredicateExpressions.Negation: VariableReplacing where Self: StandardPredicateExpression {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self {
        Self(wrapped.replaceVariable(variable, with: replacement))
    }
}

extension PredicateExpressions.NilCoalesce: VariableReplacing where Self: StandardPredicateExpression {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self {
        Self(
            lhs: lhs.replaceVariable(variable, with: replacement),
            rhs: rhs.replaceVariable(variable, with: replacement)
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

extension PredicateExpressions.SequenceContains: VariableReplacing where Self: StandardPredicateExpression {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.SequenceContains<LHS, RHS> {
        Self(
            sequence: sequence.replaceVariable(variable, with: replacement),
            element: element.replaceVariable(variable, with: replacement)
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

extension PredicateExpressions.SequenceStartsWith: VariableReplacing where Self: StandardPredicateExpression {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.SequenceStartsWith<Base, Prefix> {
        Self(
            base: base.replaceVariable(variable, with: replacement),
            prefix: self.prefix.replaceVariable(variable, with: replacement)
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

extension PredicateExpressions.Value: VariableReplacing where Self: StandardPredicateExpression {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Value<Output> {
        self
    }
}

extension PredicateExpressions.Variable: VariableReplacing {
    func replace<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> PredicateExpressions.Variable<Output> {
        print("VARIABLE", Self.self, Variable<T>.self)
        if let replacement = replacement as? Self, variable.key == key {
            return replacement
        } else {
            return self
        }
    }
}

//extension PredicateExpressions.VariableID: VariableReplacing {
//
//}

//

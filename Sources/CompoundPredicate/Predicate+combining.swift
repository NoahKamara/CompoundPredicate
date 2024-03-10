//
//  File.swift
//  
//
//  Created by Noah Kamara on 03.03.24.
//

import Foundation

fileprivate extension StandardPredicateExpression<Bool> {
    ///
    /// > Only Expression conforming to ``CompoundPredicate/VariableReplacing`` will be recursed
    ///
    /// - Parameters:
    ///   - variable: a variable that should be replaced
    ///   - replacement: the variable it should be replaced with
    /// - Returns:
    func replacingVariable<T>(
        _ variable: PredicateExpressions.Variable<T>,
        with replacement: PredicateExpressions.Variable<T>
    ) -> Self {
        if let replacingExpr = self as? any VariableReplacing<Output> {
            return replacingExpr.replacing(variable, with: replacement) as! Self
        } else {
            debugPrint("Unsupported Predicate \(Self.self)")
            return self
        }
    }
}

extension Predicate {
    typealias Expression = any StandardPredicateExpression<Bool>

    /// Returns the result of combining the predicates using the given closure.
    ///
    /// - Parameters:
    ///   - predicates: an array of predicates to combine
    ///   - nextPartialResult: A closure that combines an accumulating expression and
    ///     an expression of the sequence into a new accumulating value, to be used
    ///     in the next call of the `nextPartialResult` closure or returned to
    ///     the caller.
    /// - Returns: The final accumulated expression. If the sequence has no elements,
    ///   the result is `initialResult`.
    static func combining<T>(
        _ predicates: [Predicate<T>],
        nextPartialResult: (Expression, Expression) -> Expression
    ) -> Predicate<T> {
        return Predicate<T>({ variable in
            let expressions = predicates.map({
                $0.expression.replacingVariable($0.variable, with: variable)
            })

            guard let first = expressions.first else {
                return PredicateExpressions.Value(true)
            }

            let closure: (any StandardPredicateExpression<Bool>, any StandardPredicateExpression<Bool>) -> any StandardPredicateExpression<Bool> = {
                nextPartialResult($0,$1)
            }

            return expressions.dropFirst().reduce(first, closure)
        })
    }
}


public extension Array {
    /// Joins multiple predicates with an `Conjunction`
    ///
    /// ```swift
    /// var filters = [Predicate<Book>]()
    ///
    /// filters.append(#Predicate<Book> {
    ///     $0.pages > 50
    /// })
    ///
    /// filters.append(#Predicate<Book> {
    ///     $0.pages <= 200
    /// })
    ///
    /// let priceFilter = filters.conjunction()
    /// ```
    ///
    /// - Returns: A predicate evaluating to true if **all** sub-predicates evaluate to true
    func conjunction<T>() -> Predicate<T> where Element == Predicate<T> {
        func buildConjunction(lhs: some StandardPredicateExpression<Bool>, rhs: some StandardPredicateExpression<Bool>) -> any StandardPredicateExpression<Bool> {
            PredicateExpressions.Conjunction(lhs: lhs, rhs: rhs)
        }

        return Predicate<T>.combining(self, nextPartialResult: {
            buildConjunction(lhs: $0, rhs: $1)
        })
    }


    /// Joins multiple predicates with an `Disjunction`
    ///
    /// ```swift
    /// var filters = [Predicate<Book>]()
    ///
    /// filters.append(#Predicate<Book> {
    ///     $0.authors.contains("Aristoteles")
    /// })
    ///
    /// filters.append(#Predicate<ShoppingItem> {
    ///     $0.authors.contains("Sokrates")
    /// })
    ///
    /// let priceFilter = filters.disjunction()
    /// ```
    ///
    /// - Returns: A predicate evaluating to true if **any** sub-predicate evaluates to true
    func disjunction<T>() -> Predicate<T> where Element == Predicate<T> {
        func buildConjunction(lhs: some StandardPredicateExpression<Bool>, rhs: some StandardPredicateExpression<Bool>) -> any StandardPredicateExpression<Bool> {
            PredicateExpressions.Disjunction(lhs: lhs, rhs: rhs)
        }

        return Predicate<T>.combining(self, nextPartialResult: {
            buildConjunction(lhs: $0, rhs: $1)
        })
    }
}

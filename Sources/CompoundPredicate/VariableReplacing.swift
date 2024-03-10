//
//  File.swift
//  
//
//  Created by Noah Kamara on 07.03.24.
//

import Foundation


/// A PredicateExpression that can recursively replace a variable within itself
///
/// You typically don't need to use this protocol directly instead call ``Swift/Array/disjunction()`` or ``Swift/Array/conjunction()``
/// on an array of Predicate
///
/// ## Implementation
/// To implement Variable replacing in a custom PredicateExpression just conform your custom expression to ``CompoundPredicate/VariableReplacing``
/// > If your expression can not contain a child-variable you can opt to conform to ``CompoundPredicate/VariableReplacingLeaf`` instead
/// ```swift
/// extension PredicateExpressions.Equal: VariableReplacing 
///     where LHS: VariableReplacing, RHS: VariableReplacing {
///
///     public func replacing<T>(
///         _ variable: Variable<T>,
///         with replacement: Variable<T>
///     ) -> Self {
///         Self(
///             lhs: lhs.replacing(variable, with: replacement),
///             rhs: rhs.replacing(variable, with: replacement)
///         )
///     }
/// }
/// ```
///
public protocol VariableReplacing<Output>: PredicateExpression {
    associatedtype Output
    typealias Variable<T> = PredicateExpressions.Variable<T>

    /// Recursively traverses itself and returns a copy where all occurences of `variable` were replaced with`replacement`
    /// - Parameters:
    ///   - variable: a variable that should be replaced
    ///   - replacement: the variable it should be replaced with
    /// - Returns:
    func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self
}


/// A PredicateExpression conforming to ``CompoundPredicate/VariableReplacing``
/// where ``CompoundPredicate/VariableReplacing/replacing(_:with:)``
/// will aways return a copy of self
///
/// ## Implementation
/// To implement Variable replacing in a custom PredicateExpression just conform your custom expression to ``CompoundPredicate/VariableReplacing``
/// ```swift
/// extension PredicateExpressions.Equal: VariableReplacing 
///     where LHS: VariableReplacing,
///     RHS: VariableReplacing {}
/// ```
public protocol VariableReplacingLeaf: VariableReplacing {}

public extension VariableReplacingLeaf {
    /// returns a copy of `self` since this is a leaf
    func replacing<T>(_ variable: Variable<T>, with replacement: Variable<T>) -> Self { self }
}

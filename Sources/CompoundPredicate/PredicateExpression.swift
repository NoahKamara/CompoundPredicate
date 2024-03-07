//
//  File.swift
//  
//
//  Created by Noah Kamara on 07.03.24.
//

import Foundation

extension PredicateExpression {
    /// Recursively traverses itself and returns a copy where all occurences of `variable` were replaced with`replacement`
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

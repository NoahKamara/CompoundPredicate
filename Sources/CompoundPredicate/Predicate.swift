//
//  File.swift
//  
//
//  Created by Noah Kamara on 07.03.24.
//

import Foundation

//extension Predicate {
////    /// Recursively traverses itself and returns a copy replacing all occurences of `variable` with `replacement`
////    /// - **if** Self conforms to ``CompoundPredicate/VariableReplacing``
////    /// - **otherwise** returns a copy of ittself
////    /// - Parameters:
////    ///   - variable: a variable that should be replaced
////    ///   - replacement: the variable it should be replaced with
////    /// - Returns: a copy replacing all occurences of `variable` with `replacement`
////    func replacing(
////        with replacement: repeat PredicateExpressions.Variable<each Input>
////    ) -> any StandardPredicateExpression<Bool> {
////        //        guard var expression = expression as? any VariableReplacing<Bool> else {
////        //            print("expression is not variableReplacing", type(of: expression))
////        //            return expression
////        //        }
////        var expression = expression
////
////        func replace<T>(
////            _ variable: PredicateExpressions.Variable<T>,
////            with replacement: PredicateExpressions.Variable<T>
////        ) {
////            expression = expression.replacingVariable(variable, with: replacement)
////        }
////
////        repeat replace(each variable, with: each replacement)
////
////        return expression
////    }
//
////    func and(_ other: Predicate<repeat each Input>) -> Predicate<repeat each Input> {
////
////        Self {
////            PredicateExpressions.build_Conjunction(
////                lhs: self.expression.replacingVariable(self.variable, with: $0),
////                rhs: other.expression.replacingVariable(other.variable, with: $0)
////            )
////        }
////    }
//
////    func or(_ other: Self) -> Self {
////        Self { input in
////            PredicateExpressions.Disjunction(
////                lhs: self.expression.replacingVariable(self.variable, with: input),
////                rhs: other.expression.replacingVariable(other.variable, with: input)
////            )
////        }
////    }
//}

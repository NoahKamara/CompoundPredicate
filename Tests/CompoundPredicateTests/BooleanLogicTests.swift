import Testing
import CompoundPredicate
import Foundation

@Suite
struct BooleanLogicTests {
    @Test
    func conjunction() throws {
        let lhs = PredicateExpressions.Variable<Bool>()
        let rhs = PredicateExpressions.Variable<Bool>()

        let expression = PredicateExpressions.build_Conjunction(
            lhs: lhs,
            rhs: rhs
        )

        let replacement = PredicateExpressions.Variable<Bool>()

        // Replace LHS
        let lhsReplaced = expression.replacing(rhs, with: replacement)
        #expect(lhsReplaced.rhs == replacement)

        // Replace RHS
        let rhsReplaced = lhsReplaced.replacing(lhs, with: replacement)
        #expect(rhsReplaced.lhs == replacement)
    }

    @Test
    func disjunction() throws {
        let lhs = PredicateExpressions.Variable<Bool>()
        let rhs = PredicateExpressions.Variable<Bool>()

        let expression = PredicateExpressions.build_Disjunction(
            lhs: lhs,
            rhs: rhs
        )

        let replacement = PredicateExpressions.Variable<Bool>()

        // Replace LHS
        let lhsReplaced = expression.replacing(rhs, with: replacement)
        #expect(lhsReplaced.rhs == replacement)

        // Replace RHS
        let rhsReplaced = lhsReplaced.replacing(lhs, with: replacement)
        #expect(rhsReplaced.lhs == replacement)
    }

    @Test
    func negation() throws {
        let wrapped = PredicateExpressions.Variable<Bool>()

        let expression = PredicateExpressions.build_Negation(wrapped)

        let replacement = PredicateExpressions.Variable<Bool>()

        // Replace LHS
        let lhsReplaced = expression.replacing(wrapped, with: replacement)
        #expect(lhsReplaced.wrapped == replacement)
    }
}

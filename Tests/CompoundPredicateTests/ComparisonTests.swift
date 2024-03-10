import XCTesting


@XCTesting
@Suite
struct ComparisonTests {
    @Test(arguments: [PredicateExpressions.ComparisonOperator.greaterThan, .greaterThanOrEqual, .lessThan, .lessThanOrEqual])
    func comparison(op: PredicateExpressions.ComparisonOperator) throws {
        let lhs = PredicateExpressions.Variable<Float>()
        let rhs = PredicateExpressions.Variable<Float>()

        let expression = PredicateExpressions.build_Comparison(
            lhs: lhs,
            rhs: rhs,
            op: op
        )

        let replacement = PredicateExpressions.Variable<Float>()

        // Replace LHS
        let lhsReplaced = expression.replacing(rhs, with: replacement)
        #expect(lhsReplaced.rhs == replacement)

        // Replace RHS
        let rhsReplaced = lhsReplaced.replacing(lhs, with: replacement)
        #expect(rhsReplaced.lhs == replacement)
    }

    @Test
    func equal() throws {
        let lhs = PredicateExpressions.Variable<Float>()
        let rhs = PredicateExpressions.Variable<Float>()

        let expression = PredicateExpressions.build_Equal(
            lhs: lhs,
            rhs: rhs
        )

        let replacement = PredicateExpressions.Variable<Float>()

        // Replace LHS
        let lhsReplaced = expression.replacing(rhs, with: replacement)
        #expect(lhsReplaced.rhs == replacement)

        // Replace RHS
        let rhsReplaced = lhsReplaced.replacing(lhs, with: replacement)
        #expect(rhsReplaced.lhs == replacement)
    }

    @Test
    func notEqual() throws {
        let lhs = PredicateExpressions.Variable<Float>()
        let rhs = PredicateExpressions.Variable<Float>()

        let expression = PredicateExpressions.build_NotEqual(
            lhs: lhs,
            rhs: rhs
        )

        let replacement = PredicateExpressions.Variable<Float>()

        // Replace LHS
        let lhsReplaced = expression.replacing(rhs, with: replacement)
        #expect(lhsReplaced.rhs == replacement)

        // Replace RHS
        let rhsReplaced = lhsReplaced.replacing(lhs, with: replacement)
        #expect(rhsReplaced.lhs == replacement)
    }
}

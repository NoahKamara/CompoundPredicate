import XCTesting


@XCTesting
@Suite
/// Tests for Arithmetic (+, -, \*, /, %) and Unary Minus (-) Operators
struct ArithmeticTests {
    @Test(arguments: [
        PredicateExpressions.ArithmeticOperator.add,
        .multiply,
        .subtract,
    ])
    func arithmetic(op: PredicateExpressions.ArithmeticOperator) throws {
        let lhs = PredicateExpressions.Variable<Int>()
        let rhs = PredicateExpressions.Variable<Int>()

        let expression = PredicateExpressions.build_Arithmetic(
            lhs: lhs,
            rhs: rhs,
            op: op
        )

        try #require(expression.lhs == lhs)
        try #require(expression.rhs == rhs)

        let replacement = PredicateExpressions.Variable<Int>()
        
        // Replace LHS
        let lhsReplaced = expression.replacing(rhs, with: replacement)
        #expect(lhsReplaced.rhs == replacement)

        // Replace RHS
        let rhsReplaced = lhsReplaced.replacing(lhs, with: replacement)
        #expect(rhsReplaced.lhs == replacement)
    }


    @Test
    func floatDivision() throws {
        let lhs = PredicateExpressions.Variable<Float>()
        let rhs = PredicateExpressions.Variable<Float>()

        let expression = PredicateExpressions.build_Division(
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
    func intDivision() throws {
        let lhs = PredicateExpressions.Variable<Int>()
        let rhs = PredicateExpressions.Variable<Int>()

        let expression = PredicateExpressions.build_Division(
            lhs: lhs,
            rhs: rhs
        )

        let replacement = PredicateExpressions.Variable<Int>()

        // Replace LHS
        let lhsReplaced = expression.replacing(rhs, with: replacement)
        #expect(lhsReplaced.rhs == replacement)

        // Replace RHS
        let rhsReplaced = lhsReplaced.replacing(lhs, with: replacement)
        #expect(rhsReplaced.lhs == replacement)
    }

    @Test
    func intRemainder() throws {
        let lhs = PredicateExpressions.Variable<Int>()
        let rhs = PredicateExpressions.Variable<Int>()

        let expression = PredicateExpressions.build_Remainder(
            lhs: lhs,
            rhs: rhs
        )

        let replacement = PredicateExpressions.Variable<Int>()

        // Replace LHS
        let lhsReplaced = expression.replacing(rhs, with: replacement)
        #expect(lhsReplaced.rhs == replacement)

        // Replace RHS
        let rhsReplaced = lhsReplaced.replacing(lhs, with: replacement)
        #expect(rhsReplaced.lhs == replacement)
    }

    @Test(arguments: [
        PredicateExpressions.ArithmeticOperator.add,
        .multiply,
        .subtract,
    ])
    func unaryMinus(op: PredicateExpressions.ArithmeticOperator) throws {
        let wrapped = PredicateExpressions.Variable<Int>()

        let expression = PredicateExpressions.build_UnaryMinus(wrapped)

        try #require(expression.wrapped == wrapped)

        let replacement = PredicateExpressions.Variable<Int>()

        // Replace LHS
        let replaced = expression.replacing(wrapped, with: replacement)
        #expect(replaced.wrapped == replacement)
    }
}

extension PredicateExpressions.Variable: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.key == rhs.key
    }
}

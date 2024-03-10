import XCTesting


@XCTesting
@Suite
struct ConditionalLogicTests {
    @Test
    func conditional() throws {
        let test = PredicateExpressions.Variable<Bool>()
        let trueBranch = PredicateExpressions.Variable<Bool>()
        let falseBranch = PredicateExpressions.Variable<Bool>()

        let expression = PredicateExpressions.build_Conditional(
            test,
            trueBranch,
            falseBranch
        )

        let replacement = PredicateExpressions.Variable<Bool>()

        // Replace LHS
        let trueBranchReplaced = expression.replacing(trueBranch, with: replacement)
        #expect(trueBranchReplaced.trueBranch == replacement)

        // Replace RHS
        let falseBranchReplaced = trueBranchReplaced.replacing(falseBranch, with: replacement)
        #expect(falseBranchReplaced.falseBranch == replacement)

        // Replace Test
        let testReplaced = falseBranchReplaced.replacing(test, with: replacement)
        #expect(testReplaced.test == replacement)
    }
}

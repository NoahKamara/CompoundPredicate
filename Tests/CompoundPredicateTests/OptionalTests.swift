import XCTesting
import CompoundPredicate

@XCTesting
@Suite
struct OptionalTests {
    @Test
    func flatMap() throws {
        let wrapped = PredicateExpressions.Variable<Bool?>()
        let rhs = PredicateExpressions.Variable<Bool>()


        let expression = PredicateExpressions.build_flatMap(wrapped) { variable in
            rhs
        }

        let wrappedReplacement = PredicateExpressions.Variable<Bool?>()
        let rhsReplacement = PredicateExpressions.Variable<Bool>()

        // Replace Wrapped
        let wrappedReplaced = expression.replacing(wrapped, with: wrappedReplacement)
        #expect(wrappedReplaced.wrapped == wrappedReplacement)

        // Replace Transform
        let transformReplaced = wrappedReplaced.replacing(rhs, with: rhsReplacement)
        #expect(transformReplaced.transform == rhsReplacement)
    }

    @Test
    func nilCoalescence() throws {
        let lhs = PredicateExpressions.Variable<Bool?>()
        let rhs = PredicateExpressions.Variable<Bool>()


        let expression = PredicateExpressions.build_NilCoalesce(lhs: lhs, rhs: rhs)

        let replacement = PredicateExpressions.Variable<Bool>()
        let optReplacement = PredicateExpressions.Variable<Bool?>()

        // Replace LHS
        let lhsReplaced = expression.replacing(lhs, with: optReplacement)
        #expect(lhsReplaced.lhs == optReplacement)

        // Replace RHS
        let rhsReplaced = lhsReplaced.replacing(rhs, with: replacement)
        #expect(rhsReplaced.rhs == replacement)

    }

    @Test
    func forcedUnwrap() throws {
        let inner = PredicateExpressions.Variable<Bool?>()

        let expression = PredicateExpressions.build_ForcedUnwrap(inner)

        let replacement = PredicateExpressions.Variable<Bool?>()

        // Replace Wrapped
        let replaced = expression.replacing(inner, with: replacement)
        #expect(replaced.inner == replacement)
    }
}

import Testing
import CompoundPredicate
import Foundation

@Suite
struct CastingTests {
    @Test
    func conditionalCast() throws {
        let input = PredicateExpressions.Variable<CFBoolean>()

        let expression = PredicateExpressions.ConditionalCast<PredicateExpressions.Variable<CFBoolean>, Bool >(
            input
        )

        let replacement = PredicateExpressions.Variable<CFBoolean>()

        // Replace Wrapped
        let replaced = expression.replacing(input, with: replacement)
        #expect(replaced.input == replacement)
    }

    @Test
    func forceCast() throws {
        let input = PredicateExpressions.Variable<CFBoolean>()

        let expression = PredicateExpressions.ForceCast<PredicateExpressions.Variable<CFBoolean>, Bool >(
            input
        )

        let replacement = PredicateExpressions.Variable<CFBoolean>()

        // Replace Wrapped
        let replaced = expression.replacing(input, with: replacement)
        #expect(replaced.input == replacement)
    }

    @Test
    func typeCheck() throws {
        let input = PredicateExpressions.Variable<CFBoolean>()

        let expression = PredicateExpressions.TypeCheck<PredicateExpressions.Variable<CFBoolean>, Bool >(
            input
        )

        let replacement = PredicateExpressions.Variable<CFBoolean>()

        // Replace Wrapped
        let replaced = expression.replacing(input, with: replacement)
        #expect(replaced.input == replacement)
    }
}

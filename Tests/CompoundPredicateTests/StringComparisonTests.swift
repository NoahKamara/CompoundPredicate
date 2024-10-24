import Testing
import CompoundPredicate
import Foundation

@Suite
struct StringComparisonTests {
    @Test
    func contains() throws {
        let base = PredicateExpressions.Variable<String>()
        let other = PredicateExpressions.Variable<String>()

        let expression = PredicateExpressions.build_contains(
            base,
            other
        )

        let baseReplacement = PredicateExpressions.Variable<String>()
        let otherReplacement = PredicateExpressions.Variable<String>()

        // Replace root
        let baseReplaced = expression.replacing(base, with: baseReplacement)
        #expect(baseReplaced.base == baseReplacement)

        // Replace Value
        let otherReplaced = baseReplaced.replacing(other, with: otherReplacement)
        #expect(otherReplaced.other == otherReplacement)
    }

    @Test
    func localizedStandardContains() throws {
        let root = PredicateExpressions.Variable<String>()
        let other = PredicateExpressions.Variable<String>()

        let expression = PredicateExpressions.build_localizedStandardContains(
            root,
            other
        )

        let rootReplacement = PredicateExpressions.Variable<String>()
        let otherReplacement = PredicateExpressions.Variable<String>()

        // Replace root
        let rootReplaced = expression.replacing(root, with: rootReplacement)
        #expect(rootReplaced.root == rootReplacement)

        // Replace Value
        let otherReplaced = rootReplaced.replacing(other, with: otherReplacement)
        #expect(otherReplaced.other == otherReplacement)
    }

    @Test
    func caseInsensitiveCompare() throws {
        let root = PredicateExpressions.Variable<String>()
        let other = PredicateExpressions.Variable<String>()

        let expression = PredicateExpressions.build_caseInsensitiveCompare(
            root,
            other
        )

        let rootReplacement = PredicateExpressions.Variable<String>()
        let otherReplacement = PredicateExpressions.Variable<String>()

        // Replace root
        let rootReplaced = expression.replacing(root, with: rootReplacement)
        #expect(rootReplaced.root == rootReplacement)

        // Replace Value
        let otherReplaced = rootReplaced.replacing(other, with: otherReplacement)
        #expect(otherReplaced.other == otherReplacement)
    }

    @Test
    func localizedCompare() throws {
        let root = PredicateExpressions.Variable<String>()
        let other = PredicateExpressions.Variable<String>()

        let expression = PredicateExpressions.build_localizedCompare(
            root,
            other
        )

        let rootReplacement = PredicateExpressions.Variable<String>()
        let otherReplacement = PredicateExpressions.Variable<String>()

        // Replace root
        let rootReplaced = expression.replacing(root, with: rootReplacement)
        #expect(rootReplaced.root == rootReplacement)

        // Replace Value
        let otherReplaced = rootReplaced.replacing(other, with: otherReplacement)
        #expect(otherReplaced.other == otherReplacement)
    }
}


import XCTesting


@XCTesting
@Suite
struct RangeTests {
    @Test
    func closedRange() throws {
        let lower = PredicateExpressions.Variable<Float>()
        let upper = PredicateExpressions.Variable<Float>()

        let expression = PredicateExpressions.build_ClosedRange(
            lower: lower,
            upper: upper
        )

        let replacement = PredicateExpressions.Variable<Float>()

        // Replace Lower
        let lowerReplaced = expression.replacing(lower, with: replacement)
        #expect(lowerReplaced.lower == replacement)

        // Replace Upper
        let upperReplaced = lowerReplaced.replacing(upper, with: replacement)
        #expect(upperReplaced.upper == replacement)
    }

    @Test
    func range() throws {
        let lower = PredicateExpressions.Variable<Float>()
        let upper = PredicateExpressions.Variable<Float>()

        let expression = PredicateExpressions.build_Range(
            lower: lower,
            upper: upper
        )

        let replacement = PredicateExpressions.Variable<Float>()

        // Replace Lower
        let lowerReplaced = expression.replacing(lower, with: replacement)
        #expect(lowerReplaced.lower == replacement)

        // Replace Upper
        let upperReplaced = lowerReplaced.replacing(upper, with: replacement)
        #expect(upperReplaced.upper == replacement)
    }

    @Test
    func rangeExpressionContains() throws {
        let lower = PredicateExpressions.Variable<Float>()
        let upper = PredicateExpressions.Variable<Float>()
        let value = PredicateExpressions.Variable<Float>()

        let range = PredicateExpressions.Range(
            lower: lower,
            upper: upper
        )

        let expression = PredicateExpressions.build_contains(range, value)

        let replacement = PredicateExpressions.Variable<Float>()

        // Replace Lower
        let lowerReplaced = expression.replacing(lower, with: replacement)
        #expect(lowerReplaced.range.lower == replacement)

        // Replace Upper
        let upperReplaced = lowerReplaced.replacing(upper, with: replacement)
        #expect(upperReplaced.range.upper == replacement)

        // Replace Value
        let elementReplacement = upperReplaced.replacing(value, with: replacement)
        #expect(elementReplacement.element == replacement)
    }
}

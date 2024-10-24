import Testing
import CompoundPredicate
import Foundation

@Suite
struct SequenceOperationTests {
    @Test
    func allSatisfy() {
        let sequence = PredicateExpressions.Variable<[Int]>()
        let testVar = PredicateExpressions.Variable<Int>()

        let expression = PredicateExpressions.build_allSatisfy(
            sequence,
            {
                PredicateExpressions.build_Equal(
                    lhs: PredicateExpressions.build_Arg($0),
                    rhs: testVar
                )
            }
        )

        let sequenceReplacement = PredicateExpressions.Variable<[Int]>()
        let testVarReplacement = PredicateExpressions.Variable<Int>()

        // Replace Sequence
        let sequenceReplaced = expression.replacing(sequence, with: sequenceReplacement)
        #expect(sequenceReplaced.sequence == sequenceReplacement)

        // Replace Test
        let testVarReplaced = sequenceReplaced.replacing(testVar, with: testVarReplacement)
        #expect(testVarReplaced.test.lhs == testVarReplaced.variable)
        #expect(testVarReplaced.test.rhs == testVarReplacement)
    }

    @Test
    func filter() {
        let sequence = PredicateExpressions.Variable<[Int]>()
        let testVar = PredicateExpressions.Variable<Int>()

        let expression = PredicateExpressions.build_filter(
            sequence,
            {
                PredicateExpressions.build_Equal(
                    lhs: PredicateExpressions.build_Arg($0),
                    rhs: testVar
                )
            }
        )

        let sequenceReplacement = PredicateExpressions.Variable<[Int]>()
        let testVarReplacement = PredicateExpressions.Variable<Int>()

        // Replace Sequence
        let sequenceReplaced = expression.replacing(sequence, with: sequenceReplacement)
        #expect(sequenceReplaced.sequence == sequenceReplacement)

        // Replace Test
        let testVarReplaced = sequenceReplaced.replacing(testVar, with: testVarReplacement)
        #expect(testVarReplaced.filter.lhs == testVarReplaced.variable)
        #expect(testVarReplaced.filter.rhs == testVarReplacement)
    }


    @Test
    func sequenceContains() throws {
        let sequence = PredicateExpressions.Variable<[Int]>()
        let element = PredicateExpressions.Variable<Int>()

        let expression = PredicateExpressions.build_contains(
            sequence,
            element
        )

        let sequenceReplacement = PredicateExpressions.Variable<[Int]>()
        let elementReplacement = PredicateExpressions.Variable<Int>()

        // Replace Sequence
        let sequenceReplaced = expression.replacing(sequence, with: sequenceReplacement)
        #expect(sequenceReplaced.sequence == sequenceReplacement)

        // Replace Value
        let elementReplaced = sequenceReplaced.replacing(element, with: elementReplacement)
        #expect(elementReplaced.element == elementReplacement)
    }

    @Test
    func sequenceContainsWhere() throws {
        let sequence = PredicateExpressions.Variable<[Bool]>()
        let test = PredicateExpressions.Variable<Bool>()

        let expression = PredicateExpressions.build_contains(sequence) { variable in
            PredicateExpressions.Equal(lhs: variable, rhs: test)
        }

        let sequenceReplacement = PredicateExpressions.Variable<[Bool]>()
        let testReplacement = PredicateExpressions.Variable<Bool>()

        // Replace Sequence
        let sequenceReplaced = expression.replacing(sequence, with: sequenceReplacement)
        #expect(sequenceReplaced.sequence == sequenceReplacement)

        // Replace Value
        let testReplaced = sequenceReplaced.replacing(test, with: testReplacement)
        #expect(testReplaced.test.lhs == testReplaced.variable)
        #expect(testReplaced.test.rhs == testReplacement)
    }

    @Test
    func sequenceStartsWith() throws {
        let base = PredicateExpressions.Variable<[Int]>()
        let testPrefix = PredicateExpressions.Variable<[Int]>()

        let expression = PredicateExpressions.build_starts(
            base,
            with: testPrefix
        )

        let replacement = PredicateExpressions.Variable<[Int]>()

        // Replace Sequence
        let sequenceReplaced = expression.replacing(base, with: replacement)
        #expect(sequenceReplaced.base == replacement)

        // Replace Value
        let testReplaced = sequenceReplaced.replacing(testPrefix, with: replacement)
        #expect(testReplaced.prefix == replacement)
    }

    @Test
    func sequenceMinimum() throws {
        let elements = PredicateExpressions.Variable<[Int]>()

        let expression = PredicateExpressions.build_min(elements)

        let replacement = PredicateExpressions.Variable<[Int]>()

        // Replace Sequence
        let sequenceReplaced = expression.replacing(elements, with: replacement)
        #expect(sequenceReplaced.elements == replacement)
    }

    @Test
    func sequenceMaximum() throws {
        let elements = PredicateExpressions.Variable<[Int]>()

        let expression = PredicateExpressions.build_max(elements)

        let replacement = PredicateExpressions.Variable<[Int]>()

        // Replace Sequence
        let sequenceReplaced = expression.replacing(elements, with: replacement)
        #expect(sequenceReplaced.elements == replacement)
    }
}


import XCTesting
import CompoundPredicate

@XCTesting
@Suite
struct SubscriptAndMemberTests {
    func test() {
        let pred = #Predicate<Person> {
            $0.isStarred
        }
    }

    @Test
    func collectionSubscript() throws {
        let wrapped = PredicateExpressions.Variable<[Int]>()
        let index = PredicateExpressions.Variable<Int>()

        let expression = PredicateExpressions.build_subscript(
            wrapped,
            index
        )

        let wrappedReplacement = PredicateExpressions.Variable<[Int]>()
        let indexReplacement = PredicateExpressions.Variable<Int>()

        // Replace Collection
        let wrappedReplaced = expression.replacing(wrapped, with: wrappedReplacement)
        #expect(wrappedReplaced.wrapped == wrappedReplacement)

        // Replace Index
        let indexReplaced = wrappedReplaced.replacing(index, with: indexReplacement)
        #expect(indexReplaced.index == indexReplacement)
    }

    @Test
    func dictionarySubscript() throws {
        let wrapped = PredicateExpressions.Variable<[String:Int]>()
        let key = PredicateExpressions.Variable<String>()

        let expression = PredicateExpressions.build_subscript(
            wrapped,
            key
        )

        let wrappedReplacement = PredicateExpressions.Variable<[String:Int]>()
        let keyReplacement = PredicateExpressions.Variable<String>()

        // Replace Collection
        let wrappedReplaced = expression.replacing(wrapped, with: wrappedReplacement)
        #expect(wrappedReplaced.wrapped == wrappedReplacement)

        // Replace Key
        let indexReplaced = wrappedReplaced.replacing(key, with: keyReplacement)
        #expect(indexReplaced.key == keyReplacement)
    }

    @Test
    func dictionaryDefaultSubscript() throws {
        let wrapped = PredicateExpressions.Variable<[String:String]>()
        let key = PredicateExpressions.Variable<String>()
        let defaultValue = PredicateExpressions.Variable<String>()

        let expression = PredicateExpressions.build_subscript(
            wrapped,
            key,
            default: defaultValue
        )

        let wrappedReplacement = PredicateExpressions.Variable<[String:String]>()
        let keyReplacement = PredicateExpressions.Variable<String>()
        let defaultReplacement = PredicateExpressions.Variable<String>()

        // Replace Collection
        let wrappedReplaced = expression.replacing(wrapped, with: wrappedReplacement)
        #expect(wrappedReplaced.wrapped == wrappedReplacement)

        // Replace Key
        let indexReplaced = wrappedReplaced.replacing(key, with: keyReplacement)
        #expect(indexReplaced.key == keyReplacement)

        // Replace Default
        let defaultReplaced = indexReplaced.replacing(defaultValue, with: defaultReplacement)
        #expect(defaultReplaced.default == defaultReplacement)
    }

    @Test
    func collectionRangeSubscript() throws {
        let wrapped = PredicateExpressions.Variable<[Int]>()
        let range = PredicateExpressions.Variable<Range<Int>>()

        let expression = PredicateExpressions.build_subscript(
            wrapped,
            range
        )

        let wrappedReplacement = PredicateExpressions.Variable<[Int]>()
        let rangeReplacement = PredicateExpressions.Variable<Range<Int>>()

        // Replace Collection
        let wrappedReplaced = expression.replacing(wrapped, with: wrappedReplacement)
        #expect(wrappedReplaced.wrapped == wrappedReplacement)

        // Replace Range
        let rangeReplaced = wrappedReplaced.replacing(range, with: rangeReplacement)
        #expect(rangeReplaced.range == rangeReplacement)
    }

    @Test
    func memberAccess() throws {
        let root = PredicateExpressions.Variable<Person>()

        let expression = PredicateExpressions.build_KeyPath(
            root: root,
            keyPath: \.isStarred
        )

        let rootReplacement = PredicateExpressions.Variable<Person>()

        // Replace Root
        let rootReplaced = expression.replacing(root, with: rootReplacement)
        #expect(rootReplaced.root == rootReplacement)
    }
}


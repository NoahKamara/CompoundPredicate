import XCTest
import InlineSnapshotTesting
import XCTesting

@XCTesting
@Suite
struct ReplaceVariableTests {
    @Test
    func comparison() throws {
        let predicate = #Predicate<Person> { $0.age < $0.age }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()
        
        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.testFetch()
    }

    @Test
    func equal() throws {
        let predicate = #Predicate<Person> { $0.age == $0.age }

        let compoundPred = [.true, predicate].conjunction()

        try compoundPred.testFetch()
    }

    @Test
    func notEqual() throws {
        let predicate = #Predicate<Person> { $0.age != $0.age }

        let compoundPred = [.true, predicate].conjunction()

        try compoundPred.testFetch()
    }

    @Test
    func variable() throws {
        let predicate = #Predicate<Person> { $0.isStarred }

        let compoundPred = [.true, predicate].conjunction()

        try compoundPred.testFetch()
    }

    @Test
    func negation() throws {
        let predicate = #Predicate<Person> { !$0.isStarred }

        let compoundPred = [.true, predicate].conjunction()

        try compoundPred.testFetch()
    }

    @Test
    func sequenceContains() throws {
        let predicate = #Predicate<Person> { ["John", "James"].contains($0.firstName) }

        let compoundPred = [.true, predicate].conjunction()

        try compoundPred.testFetch()
    }

    @Test
    func sequenceStartsWith() throws {
        let predicate = #Predicate<Person> { $0.firstName.starts(with: "J") }

        let compoundPred = [.true, predicate].conjunction()

        try compoundPred.testFetch()
    }

    //    @Test
    //    func template() throws {
    //        let predicate = #Predicate<Person> { $0.firstName == "" }
    //
    //        let compoundPred = [.true, predicate].conjunction()
    //
    //        assertInlineSnapshot(of: compoundPred, as: .json(with: .shared))
    //
    //        try compoundPred.testFetch()
    //    }
}


@dynamicMemberLookup
struct Unknown {
    private let value: Any?

    public init(_ value: Any?) {
        self.value = value
    }

    subscript(dynamicMember key: String) -> Self {
        guard let dict = value as? [String:Any] else {
            return Unknown(nil)
        }

        return Unknown(dict[key])
    }

    subscript(_ index: Int) -> Self {
        guard let array = value as? [Any] else {
            return Unknown(nil)
        }

        guard array.startIndex <= index, index < array.endIndex else {
            return Unknown(nil)
        }

        return Unknown(array[index])
    }

    func `as`<T>(_ type: T.Type = T.self) -> T? {
        value as? T
    }
}

extension Predicate {
    func variableID() throws -> Int? {
        let data = try JSONEncoder().encode(self, configuration: .shared)
        let json = try JSONSerialization.jsonObject(with: data)

        return Unknown(json)
            .variable[0]
            .key
            .as(Int.self)
    }

    func recursiveVariables() throws -> Set<Int> {
        let data = try JSONEncoder().encode(self, configuration: .shared)
        let json = try JSONSerialization.jsonObject(with: data)

        return walkObject(json)
    }

    private func walkObject(_ json: Any) -> Set<Int> {
        var ids = Set<Int>()

        if let dict = json as? [String:Any] {
            for (key, value) in dict {
                if key == "key", let value = value as? Int {
                    ids.insert(value)
                }

                ids.formUnion(walkObject(value))
            }
        } else if let array = json as? [Any] {
            for value in array {
                ids.formUnion(walkObject(value))
            }
        }

        return ids
    }
}


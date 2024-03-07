import XCTest
import SwiftData
import InlineSnapshotTesting
import XCTesting


@XCTesting
@Suite
struct ReplaceVariableTests {
    @Test
    func variable() throws {
        let predicate = #Predicate<Person> { $0.isStarred }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()
        
        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func arithmetic() throws {
        let predicate = #Predicate<Person> {
            ($0.age + $0.age) > 17
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func comparison() throws {
        let predicate = #Predicate<Person> { $0.age < $0.age }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func conditional() throws {
        let predicate = #Predicate<Person> {
            if $0.age < $0.age { true } else { false }
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func conjunction() throws {
        let predicate = #Predicate<Person> {
            $0.age > 18 && $0.isStarred
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func disjunction() throws {
        let predicate = #Predicate<Person> {
            $0.age > 18 || $0.isStarred
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func dictionaryKeySubscript() throws {
        let dict = ["Joe": 0]

        let predicate = #Predicate<Person> {
            (dict[$0.firstName] ?? 0) == $0.age
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
            try compoundPred.fetch()
        })
    }

    @Test
    func dictionaryKeyDefaultValueSubscript() throws {
        let dict = ["Joe": 0]

        let predicate = #Predicate<Person> {
            dict[$0.firstName, default: 0] == $0.age
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
            try compoundPred.fetch()
        })
    }

    @Test
    func equal() throws {
        let predicate = #Predicate<Person> {
            $0.age == 18
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func notEqual() throws {
        let predicate = #Predicate<Person> {
            $0.age != 18
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func filter() throws {
        let predicate = #Predicate<Person> { person in
            [1,2,3].filter { i in
                person.age == i
            }.first == 0
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        #expect(throws: SwiftDataError.unsupportedKeyPath, performing: {
            try compoundPred.fetch()
        })
    }

    @Test
    func floatDivision() throws {
        let predicate = #Predicate<Person> {
            ($0.rating / 2) > 1
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func forceCast() throws {
        let predicate = #Predicate<Person> {
            (($0.rating as any Numeric) as! Int) > 1
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
            try compoundPred.fetch()
        })
    }

    @Test
    func intDivision() throws {
        let predicate = #Predicate<Person> {
            ($0.age / 2) > 1
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
            try compoundPred.fetch()
        })
    }

    @Test
    func intRemainder() throws {
        let predicate = #Predicate<Person> {
            ($0.age % 2) > 1
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
            try compoundPred.fetch()
        })
    }

    @Test
    func negation() throws {
        let predicate = #Predicate<Person> {
            !$0.isStarred
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }

    @Test
    func sequenceContains() throws {
        let predicate = #Predicate<Person> {
            [0,1,2].contains($0.age)
        }

        let oldVariable = try #require(try predicate.variableID())

        let compoundPred = [.true, predicate].conjunction()

        let variables = try #require(try compoundPred.recursiveVariables())

        #expect(!variables.contains(oldVariable))

        try compoundPred.fetch()
    }
}


@dynamicMemberLookup
struct Unknown: CustomStringConvertible {
    enum Key {
        case index(Int)
        case key(String)
    }

    let path: [Key] = []
    private let value: Any?

    init(_ predicate: Predicate<Person>) throws {
        let data = try JSONEncoder().encode(predicate, configuration: .shared)
        let json = try JSONSerialization.jsonObject(with: data)
        self.init(json)
    }

    public init(_ value: Any) {
        self.init(value: value, path: [])
    }

    private init(value: Any?, path: [Key]) {
        self.value = value
    }

    subscript(dynamicMember key: String) -> Self {
        let path = path+[.key(key)]

        guard let dict = value as? [String: Any] else {
            return Unknown(value: nil, path: path)
        }
        print(dict.keys)

        return Unknown(value: dict[key], path: path)
    }

    subscript(_ index: Int) -> Self {
        let path = path+[.index(index)]

        guard let value,
              let array = value as? [Any],
              array.startIndex <= index, index < array.endIndex
        else {
            return Unknown(value: nil, path: path)
        }

        return Unknown(value: array[index], path: path)
    }

    func `as`<T>(_ type: T.Type = T.self) -> T? {
        value as? T
    }

    var description: String {
        guard let value,
              let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted),
              let string = String(data: data, encoding: .utf8)
        else {
            return String(describing: value)
        }
        
        return string
    }
}


extension Predicate {
    func variableID() throws -> Int? {
        let data = try JSONEncoder().encode(self, configuration: .shared)

        let json = try JSONSerialization.jsonObject(with: data)

        return Unknown(json)[0]
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


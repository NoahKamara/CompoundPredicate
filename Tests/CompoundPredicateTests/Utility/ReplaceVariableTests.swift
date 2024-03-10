//import XCTest
//import SwiftData
//import InlineSnapshotTesting
//import XCTesting
//
//
//@XCTesting
//@Suite
//struct ReplaceVariableTests {
//    @Test
//    func variable() throws {
//        let predicate = #Predicate<Person> { $0.isStarred }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//        
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func arithmetic() throws {
//        let predicate = #Predicate<Person> {
//            ($0.age + $0.age) > 17
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func comparison() throws {
//        let predicate = #Predicate<Person> { $0.age < $0.age }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func conditional() throws {
//        let predicate = #Predicate<Person> {
//            if $0.age < $0.age { true } else { false }
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func conjunction() throws {
//        let predicate = #Predicate<Person> {
//            $0.age > 18 && $0.isStarred
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func disjunction() throws {
//        let predicate = #Predicate<Person> {
//            $0.age > 18 || $0.isStarred
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func dictionaryKeySubscript() throws {
//        let dict = ["Joe": 0]
//
//        let predicate = #Predicate<Person> {
//            (dict[$0.firstName] ?? 0) == $0.age
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
//            try compoundPred.fetch()
//        })
//    }
//
//    @Test
//    func dictionaryKeyDefaultValueSubscript() throws {
//        let dict = ["Joe": 0]
//
//        let predicate = #Predicate<Person> {
//            dict[$0.firstName, default: 0] == $0.age
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
//            try compoundPred.fetch()
//        })
//    }
//
//    @Test
//    func equal() throws {
//        let predicate = #Predicate<Person> {
//            $0.age == 18
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func notEqual() throws {
//        let predicate = #Predicate<Person> {
//            $0.age != 18
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func filter() throws {
//        let predicate = #Predicate<Person> { person in
//            [1,2,3].filter { i in
//                person.age == i
//            }.first == 0
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        #expect(throws: SwiftDataError.unsupportedKeyPath, performing: {
//            try compoundPred.fetch()
//        })
//    }
//
//    @Test
//    func floatDivision() throws {
//        let predicate = #Predicate<Person> {
//            ($0.rating / 2) > 1
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func forceCast() throws {
//        let predicate = #Predicate<Person> {
//            (($0.rating as any Numeric) as! Int) > 1
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
//            try compoundPred.fetch()
//        })
//    }
//
//    @Test
//    func intDivision() throws {
//        let predicate = #Predicate<Person> {
//            ($0.age / 2) > 1
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
//            try compoundPred.fetch()
//        })
//    }
//
//    @Test
//    func intRemainder() throws {
//        let predicate = #Predicate<Person> {
//            ($0.age % 2) > 1
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        #expect(throws: SwiftDataError.unsupportedPredicate, performing: {
//            try compoundPred.fetch()
//        })
//    }
//
//    @Test
//    func negation() throws {
//        let predicate = #Predicate<Person> {
//            !$0.isStarred
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//
//    @Test
//    func sequenceContains() throws {
//        let predicate = #Predicate<Person> {
//            [0,1,2].contains($0.age)
//        }
//
//        let oldVariable = try #require(try predicate.variableID())
//
//        let compoundPred = [.true, predicate].conjunction()
//
//        let variables = try #require(try compoundPred.recursiveVariables())
//
//        #expect(!variables.contains(oldVariable))
//
//        try compoundPred.fetch()
//    }
//}
//

@dynamicMemberLookup
struct Unknown: CustomStringConvertible {
    enum Key: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, Equatable, CustomStringConvertible {
        case index(Int)
        case key(String)

        init(stringLiteral key: String) {
            self = .key(key)
        }

        init(integerLiteral index: Int) {
            self = .index(index)
        }

        var description: String {
            switch self {
                case .index(let index): "Index \(index)"
                case .key(let key): key
            }
        }
    }

    let path: [Key]
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
        self.path = path
    }

    subscript(dynamicMember key: String) -> Self {
        let childPath = path+[.key(key)]

        guard let dict = value as? [String: Any] else {
            return Unknown(value: nil, path: childPath)
        }

        return Unknown(value: dict[key], path: childPath)
    }

    subscript(_ index: Int) -> Self {
        let childPath = path+[.index(index)]

        guard let value,
              let array = value as? [Any],
              array.startIndex <= index, index < array.endIndex
        else {
            return Unknown(value: nil, path: childPath)
        }

        return Unknown(value: array[index], path: childPath)
    }

    func `as`<T>(_ type: T.Type = T.self) -> T? {
        value as? T
    }
    
    func walk(_ handler: (Unknown) -> Void) {
        handler(self)

        guard let value else {
            return
        }

        if let dict = value as? [String: Any] {
            for key in dict.keys {
                self[dynamicMember: key].walk(handler)
            }
        } else if let array = value as? [Any]{
            for index in array.indices {
                self[index].walk(handler)
            }
        }
    }

    var description: String {
        guard let value,
              let data = try? JSONSerialization.data(withJSONObject: value, options: [.prettyPrinted, .fragmentsAllowed]),
              let string = String(data: data, encoding: .utf8)
        else {
            return String(describing: value)
        }
        
        return string
    }
}
import Foundation

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

extension StandardPredicateExpression {
    func recursiveVariables() throws -> Set<Int> {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data)
        return walkObject(Unknown(json))
    }

    private func walkObject(_ json: Unknown) -> Set<Int> {
        var ids = Set<Int>()

        json.walk { unknown in
            guard unknown.path.last == .key("key") else { return }
            let id = unknown.as(Int.self)!

            ids.insert(id)
        }

//        if let dict = json as? [String:Any] {
//            for (key, value) in dict {
//                if key == "key", let value = value as? Int {
//                    ids.insert(value)
//                }
//
//                ids.formUnion(walkObject(value))
//            }
//        } else if let array = json as? [Any] {
//            for value in array {
//                ids.formUnion(walkObject(value))
//            }
//        }
//
        return ids
    }
}




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


import Foundation

// MARK: Person
struct Person: PredicateCodableKeyPathProviding {
    static var predicateCodableKeyPaths: [String : PartialKeyPath<Person>] = [
        "Person.name": \.name,
        "Person.age": \.age,
        "Person.isStarred": \.isStarred,
    ]

    let name: String
    let age: Int
    let isStarred: Bool
}


// MARK: Predicate Encoding
extension Predicate<Person>.EncodingConfiguration {
    static var shared: Self {
        var config = Predicate<Person>.EncodingConfiguration.standardConfiguration
        config.allowKeyPathsForPropertiesProvided(by: Person.self, recursive: true)
        return config
    }
}


// MARK: Variable IDs
extension Predicate {
    /// Return the Int Key of this predicates variable
    /// - Returns: VariableID key
    func variableID() throws -> Int? {
        let data = try JSONEncoder().encode(self, configuration: .shared)

        let json = try JSONSerialization.jsonObject(with: data)

        return Unknown(json)[0]
            .variable[0]
            .key
            .as(Int.self)
    }
}

extension StandardPredicateExpression {
    /// Recursively walk an expression to find variable IDs
    /// - Returns: set of discovered variable ids
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

        return ids
    }
}



@dynamicMemberLookup
fileprivate struct Unknown: CustomStringConvertible {
    enum Key: Equatable, CustomStringConvertible {
        case index(Int)
        case key(String)

        var description: String {
            switch self {
                case .index(let index): "Index \(index)"
                case .key(let key): key
            }
        }
    }

    let path: [Key]
    private let value: Any?

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


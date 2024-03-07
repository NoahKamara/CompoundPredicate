import XCTest
@testable import CompoundPredicate
import SwiftData

enum JSONKey: Hashable {
    case index(Int)
    case key(String)

    var description: String {
        switch self {
            case .index(let index): "[\(index)]"
            case .key(let key): key
        }
    }
}

extension Predicate<Person> {
    func fetch() throws {
        let descriptor = FetchDescriptor(predicate: (self as! Predicate<Person>))
        _ = try ModelContext(.shared).fetch(descriptor)
    }
}

extension Predicate<Person>.EncodingConfiguration {
    static var shared: Self {
        var config = Predicate<Person>.EncodingConfiguration.standardConfiguration
        config.allowKeyPathsForPropertiesProvided(by: Person.self, recursive: true)
        config.allowType(Int.self)
        config.allowType(Float.self)
        config.allowType(String.self)
        config.allowType(Bool.self)
        config.allowType((any Numeric).self)
        return config
    }
}



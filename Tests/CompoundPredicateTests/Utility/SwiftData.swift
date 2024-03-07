//
//  File.swift
//  
//
//  Created by Noah Kamara on 03.03.24.
//

import Foundation
import SwiftData

extension ModelContainer {
    static var shared: ModelContainer {
        let configuration = ModelConfiguration(
            isStoredInMemoryOnly: true,
            allowsSave: true
        )

        let _ = configuration.url.startAccessingSecurityScopedResource()

        let container = try! ModelContainer(for: Person.self, configurations: configuration)
        return container
    }
}

@Model
final class Post: PredicateCodableKeyPathProviding {
    static var predicateCodableKeyPaths: [String : PartialKeyPath<Post>] = [
        "Person.content": \.content,
        "Person.date": \.date
    ]

    let date: Date
    let content: String

    init(date: Date, content: String) {
        self.date = date
        self.content = content
    }
}

@Model
final class Person: PredicateCodableKeyPathProviding {
    static var predicateCodableKeyPaths: [String : PartialKeyPath<Person>] = [
        "Person.firstName": \.firstName,
        "Person.lastName": \.lastName,
        "Person.age": \.age,
        "Person.isStarred": \.isStarred,
        "Person.rating": \.rating
    ]

    let firstName: String
    let lastName: String

    let age: Int
    let isStarred: Bool

    var rating: Float = 0

    init(firstName: String, lastName: String, age: Int, isStarred: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.isStarred = isStarred
        self.age = age
    }
}


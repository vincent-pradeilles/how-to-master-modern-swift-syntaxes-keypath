//: [Previous](@previous)

import Foundation

// We're doing pretty good, but let's try an keep pushing the limits!

// Consider the following data:

struct Person {
    let id: Int
    let firstName: String
    let lastName: String
}

let contacts = [
    Person(id: 1, firstName: "Charlie", lastName: "Webb"),
    Person(id: 2, firstName: "Alexia", lastName: "Elexson"),
    Person(id: 3, firstName: "Charles", lastName: "Webb"),
    Person(id: 4, firstName: "Alex", lastName: "Zunino"),
    Person(id: 5, firstName: "Alex", lastName: "Alexson"),
    Person(id: 6, firstName: "John", lastName: "Webb"),
    Person(id: 7, firstName: "Webb", lastName: "Elexson")
]

struct Login {
    let userId: Int
    let loginTime: Date
}

let logins = [
    Login(userId: 4, loginTime: Date().addingTimeInterval(-3600)), // one hour ago
    Login(userId: 5, loginTime: Date().addingTimeInterval(-3600 * 2)), // two hours ago
    Login(userId: 7, loginTime: Date().addingTimeInterval(-3600 * 3)) // three hours ago
]

// Say that we need to implement a join operation
// We want to achieve it with this syntax:
// contacts.join(with: logins, .where(\.id == \.userId)

struct DoubleTypePredicate<Element, OtherElement> {
    
    private let evaluator: (Element, OtherElement) -> Bool
    
    public init(evaluator: @escaping (Element, OtherElement) -> Bool) {
        self.evaluator = evaluator
    }
    
    public func evaluate(for leftElement: Element, and rightElement: OtherElement) -> Bool {
        return evaluator(leftElement, rightElement)
    }
}

func == <Element, OtherElement, T: Equatable>(_ leftAttribute: KeyPath<Element, T>, _ rightAttribute: KeyPath<OtherElement, T>) -> DoubleTypePredicate<Element, OtherElement> {
    return DoubleTypePredicate(evaluator: { lhs, rhs in lhs[keyPath: leftAttribute] == rhs[keyPath: rightAttribute] })
}

extension Sequence {
    func join<OtherElement>(with sequence: Array<OtherElement>,
                                   where predicate: DoubleTypePredicate<Element, OtherElement>) -> [(Element, OtherElement)] {
        var result: [(Element, OtherElement)] = []
        
        for leftValue in self {
            for rightValue in sequence {
                if predicate.evaluate(for: leftValue, and: rightValue) {
                    result.append((leftValue, rightValue))
                }
            }
        }
        
        return result
    }
}

contacts.join(with: logins, where: \.id == \.userId)

//: [Next](@next)

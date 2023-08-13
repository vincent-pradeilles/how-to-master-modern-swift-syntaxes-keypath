//: [Previous](@previous)

import Foundation

// What's a KeyPath?

let keyPath = \String.count

// or, with type inference

let typeInferedKeyPath: KeyPath<String, Int> = \.count

// A KeyPath takes two generic parameters KeyPath<Root, Value>
//
// Root is the type on which the KeyPath is invoked
// Value is the type of the property the KeyPath refers to

// Here's how a KeyPath is invoked

let string = "Hello, YouTube!"

string[keyPath: \String.count]
string[keyPath: keyPath]

// You can think of a KeyPath as a "reference" to some property

// KeyPaths can also be composed

let firstKeyPath = \String.count
let secondKeyPath = \Int.byteSwapped

let composedKeyPath = firstKeyPath.appending(path: secondKeyPath)

string[keyPath: composedKeyPath]

// Finally, every type has a special KeyPath called \.self

string[keyPath: \.self]

// \.self is called the Identity KeyPath

// For more information KeyPaths API -> https://developer.apple.com/documentation/swift/keypath

//: [Next](@next)

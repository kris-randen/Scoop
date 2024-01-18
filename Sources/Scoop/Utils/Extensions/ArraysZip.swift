//
//  ArraysZip.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//

import Foundation
import OrderedCollections

public extension Array {
    func zipLeft<Value>(_ values: [Value]) -> [(Element, Value)] {
        var zipped = [(Element, Value)]()
        for (index, element) in self.enumerated() where index < values.count {
            zipped.append((element, values[index]))
        }
        return zipped
    }
    
    func zipRight<Value>(_ values: [Value]) -> [(Element, Value)] {
        var zipped = [(Element, Value)]()
        for (index, value) in values.enumerated() where index < self.count {
            zipped.append((self[index], value))
        }
        return zipped
    }
    
    func shorter<Value>(than values: [Value]) -> Bool {
        return self.count < values.count
    }
    
    func zip<Value>(_ values: [Value]) -> [(Element, Value)] {
        return self.shorter(than: values) ? self.zipLeft(values) : self.zipRight(values)
    }
}

public extension Array where Element: Hashable {
    func zipDict<Value>(_ values: [Value]) -> [Element: Value] {
        return Dictionary(uniqueKeysWithValues: self.zip(values))
    }
}

public extension Array {
    static func *(lhs: Int, rhs: Self) -> Self {
        (0..<lhs).reduce(into: []) { sum, _ in
            sum += rhs
        }
    }
    
    static func *(lhs: Self, rhs: Int) -> Self {
        rhs * lhs
    }
}

public extension Array where Element: ComparableHash {
    func zipOrderedDictByKeys<Value>(_ values: [Value], ascending: Bool = true) -> OrderedDictionary<Element, Value> {
        return OrderedDictionary(uniqueKeysWithValues: self.zip(values))
            .sortedByKeys(ascending: ascending)
    }
 }

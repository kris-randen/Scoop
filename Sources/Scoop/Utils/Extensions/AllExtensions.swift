//
//  Extensions.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI
import Foundation
import UIKit
import OrderedCollections

public protocol ComparableHash: Comparable, Hashable {}

public extension RawRepresentable where RawValue: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool { lhs.rawValue < rhs.rawValue }
}

public protocol EnumTypeKey: Hashable, CaseIterable, RawRepresentable where RawValue: Hashable {}

public protocol EnumTypeOrderedKey: ComparableHash, CaseIterable, RawRepresentable where RawValue: Comparable {}


public extension Array where Element: Hashable {
    var set: Set<Element> { Set(self) }
    
    func union(with other: Set<Element>) -> Set<Element> {
        set.union(other)
    }
    
    func union(with others: any Sequence<Set<Element>>) -> Set<Element> {
        set.union(with: others)
    }
    
    func union(with other: Self) -> Self {
        Array(union(with: other.set))
    }
    
    func union(with others: any Sequence<Self>) -> Self {
        Array(union(with: others.map { Set($0) }))
    }

}

public extension CaseIterable where Self: Hashable {
    static func valuesDict<Value>(value: Value) -> [Self: Value] {
        let zeros = Array(repeating: value, count: allCases.count)
        return Dictionary(uniqueKeysWithValues: zip(allCases, zeros))
    }
    static var zeroDict: [Self: Double] { valuesDict(value: 0.0) }
}

public extension CaseIterable where Self: ComparableHash {
    static func valuesOrderedDict<Value>(value: Value) -> OrderedDictionary<Self, Value> {
        OrderedDictionary(uniqueKeysWithValues: self.valuesDict(value: value))
    }
    
    static var zeroOrderedDict: OrderedDictionary<Self, Double> { valuesOrderedDict(value: 0.0) }
}


public extension String {
    func doesContain(_ other: String) -> Bool {
        other.isEmpty || self.contains(other)
    }
}

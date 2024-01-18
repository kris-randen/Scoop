//
//  DictionariesSetOperations.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//

import Foundation
import OrderedCollections


// Defining the KeyValuepublic protocol so that I don't have to repeat the extensions of Dictionary for both Dictionary and OrderedDictionary

public protocol KeyValueCollection {
    associatedtype Key: Hashable
    associatedtype Value
    var keySet: Set<Key> { get }
    subscript(key: Key) -> Value? { get set }
    
    mutating func update(value: Value, forKey key: Key)
}

extension Dictionary: KeyValueCollection {
    public var keySet: Set<Key> { Set(self.keys) }
    
    mutating public func update(value: Value, forKey key: Key) {
        self.updateValue(value, forKey: key)
    }
}

extension OrderedDictionary: KeyValueCollection {
    public var keySet: Set<Key> { Set(self.keys) }
    
    mutating public func update(value: Value, forKey key: Key) {
        self.updateValue(value, forKey: key)
    }
}

public extension KeyValueCollection {
    func keysUnion(with other: Self) -> Set<Key> {
        keySet.union(other.keySet)
    }
    
    func keysUnion(with others: any Sequence<Self>) -> Set<Key> {
        keySet.union(with: others.map { $0.keySet })
    }
    
    func keysIntersection(with other: Self) -> Set<Key> {
        keySet.intersection(other.keySet)
    }
    
    func keysIntersection(with others: any Sequence<Self>) -> Set<Key> {
        keySet.intersection(with: others.map { $0.keySet } )
    }
}

public extension KeyValueCollection {
    
    func valueMerge(forKey key: Key, with dict: Self) -> Value? { self[key] ?? dict[key] }
    
    func valueUpdate(forKey key: Key, with dict: Self) -> Value? { dict[key] ?? self[key] }
    
    func merged(withNonintersecting dict: Self) -> Self {
        keysUnion(with: dict).reduce(into: self) {
            $0.update(value: valueMerge(forKey: $1, with: dict)!, forKey: $1)}
    }
    
    mutating func merge(nonintersecting dict: Self) {
        self = merged(withNonintersecting: dict)
    }
    
    func updated(with dict: Self) -> Self {
        keysUnion(with: dict).reduce(into: self) {
            $0.update(value: valueUpdate(forKey: $1, with: dict)!, forKey: $1)
        }
    }
    
    mutating func update(with dict: Self) {
        self = updated(with: dict)
    }
    
    func replaced(with dict: Self) -> Self {
        keySet.reduce(into: self) {
            $0.update(value: valueUpdate(forKey: $1, with: dict)!, forKey: $1)
        }
    }
    
    mutating func replace(with dict: Self) {
        self = replaced(with: dict)
    }
    
    func merging(nonintersecting dicts: any Sequence<Self>) -> Self {
        dicts.reduce(into: self) { $0.merge(nonintersecting: $1) }
    }
    
    func merging(nonintersecting dict: Self) -> Self {
        merging(nonintersecting: [dict])
    }
    
    static func merge(dicts: [[Key: Value]]) -> [Key: Value] {
        return dicts.last?.merging(nonintersecting: dicts.dropLast()) ?? [:]
    }
}


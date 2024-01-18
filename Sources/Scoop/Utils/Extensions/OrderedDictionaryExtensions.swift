//
//  OrderedDictionary.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//

import Foundation
import OrderedCollections

public extension OrderedDictionary where Key: Comparable {
    mutating func sortByKeys(ascending: Bool = true) {
        ascending ? self.sort { $0.key < $1.key } : self.sort {$0.key > $1.key }
    }
    
    func sortedByKeys(ascending: Bool = true) -> Self {
        var result = self
        result.sortByKeys(ascending: ascending)
        return result
    }
    
    func elementsSortedByKeys(ascending: Bool = true) -> [(key: Key, value: Value)] {
        return ascending ? sorted { $0.key < $1.key } : sorted { $0.key > $1.key }
    }
    
    var elementsKeysAscending: [(key: Key, value: Value)] { elementsSortedByKeys(ascending: true) }
    
    var elementsKeysDescending: [(key: Key, value: Value)] { elementsSortedByKeys(ascending: false) }
    
    func mapD<NewKey, NewValue>(_ transform: ((key: Key, value: Value)) -> (NewKey, NewValue)) -> OrderedDictionary<NewKey, NewValue> {
            return OrderedDictionary<NewKey, NewValue>(uniqueKeysWithValues: self.map(transform))
        }
}

public extension Dictionary {
    func mapD<NewKey, NewValue>(_ transform: ((key: Key, value: Value)) -> (NewKey, NewValue)) -> [NewKey: NewValue] {
            return Dictionary<NewKey, NewValue>(uniqueKeysWithValues: self.map(transform))
        }
}


public extension OrderedDictionary where Value: Comparable {
    mutating func sortByValues(ascending: Bool = true) {
        ascending ? self.sort { $0.value < $1.value } : self.sort {$0.value > $1.value }
    }
    
    func sortedByValues(ascending: Bool = true) -> Self {
        var result = self
        result.sortByValues(ascending: ascending)
        return result
    }
    
    func elementsSortedByValues(ascending: Bool = true) -> [(key: Key, value: Value)] {
        return ascending ? sorted { $0.value < $1.value } : sorted { $0.value > $1.value }
    }
    
    var elementsValuesAscending:  [(key: Key, value: Value)]  { elementsSortedByValues(ascending: true) }
    var elementsValuesDescending:  [(key: Key, value: Value)]  { elementsSortedByValues(ascending: false) }
}

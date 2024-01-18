//
//  Sets.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//

import Foundation

public extension Set {
    mutating func union(_ other: Self) {
        self = self.union(other)
    }
    
    mutating func union(with others: any Sequence<Self>) {
        self = self.union(with: others)
    }
    
    mutating func intersection(_ other: Self) {
        self = self.intersection(other)
    }
    
    mutating func intersection(with others: any Sequence<Self>) {
        self = self.intersection(with: others)
    }
    
    func union(with others: any Sequence<Self>) -> Self {
        others.reduce(into: self) { $0.union($1) }
    }
    
    func intersection(with others: any Sequence<Self>) -> Self {
        others.reduce(into: self) { $0.intersection($1) }
    }
    
    static func union(of sets: any Sequence<Self>) -> Self {
        Self().union(with: sets)
    }
    
    static func intersection(of sets: any Sequence<Self>) -> Self {
        Self().intersection(with: sets)
    }
    
    static func union(lhs: Self, rhs: Self) -> Self {
        Set.union(of: [lhs, rhs])
    }
    
    static func intersection(lhs: Self, rhs: Self) -> Self {
        Set.intersection(of: [lhs, rhs])
    }
}

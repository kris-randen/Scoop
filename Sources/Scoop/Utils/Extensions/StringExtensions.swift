//
//  Strings.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import Foundation

public extension Array where Element == String {
    var capitalized: Self {
        self.map{$0.capitalized}
    }
}

public extension String {
    static func join<S: Sequence>(_ strings: S, using delimiter: Self) -> Self where S.Element == Self {
        return strings.joined(separator: delimiter)
    }
    
    func split(using delimiter: String = " ") -> [Self] {
        return self.components(separatedBy: delimiter)
    }
    
    func join<S: Sequence>(_ strings: S, using delimiter: Self) -> Self where S.Element == Self {
        return String.join(strings, using: delimiter)
    }
    
    var camelCased: Self {
        return self.split().capitalized.joined(separator: " ")
    }
}

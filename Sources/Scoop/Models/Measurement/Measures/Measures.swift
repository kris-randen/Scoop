//
//  Measures.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

@available(iOS 15.0, *)
public protocol Measureable {
    associatedtype Unit: UnitType
    var unit: Unit { get }
    var value: Double { get set }
}

@available(iOS 15.0, *)
public protocol ConvertibleMeasure: Measureable, Convertible {
    static func factor(from lhs: Self, to rhs: Self) -> Double
    func factor(to rhs: Self) -> Double
}

@available(iOS 15.0, *)
public protocol SummableConvertibleMeasure: ConvertibleMeasure, Summable {}


@available(iOS 15.0, *)
public extension SummableConvertibleMeasure {
    mutating func add(_ other: Self) {
        self.value += other.conversion(to: unit)
    }
}

@available(iOS 15.0, *)
public extension ConvertibleMeasure {
    static func factor(from lhs: Self, to rhs: Self) -> Double {
        (rhs.value / lhs.value) * (rhs.unit.conversion(to: lhs.unit))
    }
    
    func factor(to rhs: Self) -> Double {
        Self.factor(from: self, to: rhs)
    }
    
    func conversion(to: Unit) -> Double {
        return self.value * self.unit.conversion(to: to)
    }
    
    func conversion(to: Self) -> Double {
        return conversion(to: to.unit)
    }
}

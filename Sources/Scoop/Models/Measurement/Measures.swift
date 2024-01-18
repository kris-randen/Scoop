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
}

@available(iOS 15.0, *)
public extension ConvertibleMeasure {
    func conversion(to: Unit) -> Double {
        return self.value * self.unit.conversion(to: to)
    }
    
    func conversion(to: Self) -> Double {
        return conversion(to: to.unit)
    }
}

@available(iOS 15.0, *)
public struct Mass: ConvertibleMeasure {
    public typealias Unit = Units.Mass
    public let unit: Units.Mass
    public var value: Double
}

@available(iOS 15.0, *)
public struct Length: ConvertibleMeasure {
    public typealias Unit = Units.Length
    public let unit: Units.Length
    public var value: Double
}

@available(iOS 15.0, *)
public struct Volume: ConvertibleMeasure {
    public typealias Unit = Units.Volume
    public let unit: Units.Volume
    public var value: Double
}

@available(iOS 15.0, *)
public struct Energy: ConvertibleMeasure {
    public typealias Unit = Units.Energy
    public let unit: Units.Energy
    public var value: Double
    public static var dailyValue: Double = 2000
}

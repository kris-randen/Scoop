//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

@available(iOS 15.0, *)
public typealias Energy = EnergyMeasure

@available(iOS 15.0, *)
public struct EnergyMeasure: SummableConvertibleMeasure {
    public typealias Unit = Units.Energy
    public var value: Double = 0
    public var unit: Units.Energy = .kcal
    public static var dailyValue: Double = 2000
    
    public init(value: Double = 0, unit: Units.Energy = .kcal) {
        self.value = value
        self.unit = unit
    }
}

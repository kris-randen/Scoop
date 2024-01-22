//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

@available(iOS 15.0, *)
public typealias Length = LengthMeasure

@available(iOS 15.0, *)
public struct LengthMeasure: SummableConvertibleMeasure {
    public typealias Unit = Units.Length
    public var value: Double
    public let unit: Units.Length
    
    public init(value: Double, unit: Units.Length) {
        self.value = value
        self.unit = unit
    }
}

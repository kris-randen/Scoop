//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

@available(iOS 15.0, *)
public extension Serving {
    typealias Mass = MassMeasure
}

@available(iOS 15.0, *)
public struct MassMeasure: SummableConvertibleMeasure {
    public typealias Unit = Units.Mass
    public var value: Double = 100
    public var unit: Unit = .gm
    
    public init(value: Double = 100, unit: Unit = .gm) {
        self.value = value
        self.unit = unit
    }
}

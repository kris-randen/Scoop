//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

@available(iOS 15.0, *)
public extension Serving {
    typealias Volume = VolumeMeasure
}

@available(iOS 15.0, *)
public struct VolumeMeasure: SummableConvertibleMeasure {
    public typealias Unit = Units.Volume
    public var value: Double = 1000
    public var unit: Unit = .ml
    
    public init(value: Double = 1000, unit: Unit = .ml) {
        self.value = value
        self.unit = unit
    }
}

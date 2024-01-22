//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

@available(iOS 15.0, *)
public extension Units {
    typealias Ratio = RatioUnit
}

@available(iOS 15.0, *)
public enum RatioUnit: ExponentInterconvertible, Codable, Hashable {

    case density(mass: Units.Mass, volume: Units.Volume)
    
    var logBase: Int8 {
        switch self {
        case .density(let mass, let volume):
            return mass.rawValue - volume.rawValue
        }
    }
    
    public func conversionExponent(to: Units.Ratio) -> Int8 {
        self.logBase - to.logBase
    }
}

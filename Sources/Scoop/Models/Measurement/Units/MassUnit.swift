//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

@available(iOS 15.0, *)
public extension Units {
    typealias Mass = MassUnit
}

@available(iOS 15.0, *)
public enum MassUnit: Int8, NutrientUnitEnumOrderedKey {
    case pg = -12
    case ng = -9
    case ug = -6
    case mg = -3
    case gm = 0
    case kg = 3
    
    public static var table: [String: Units.Mass] = [
        "ug"    : .ug,
        "mg"    : .mg,
        "g"     : .gm,
        "kg"    : .kg,
        "gm"    :.gm,
        "grm"   : .gm
    ]
    
    public var description: String {
        switch self {
        case .pg: Constants.Units.Mass.pg
        case .ng: Constants.Units.Mass.ng
        case .ug: Constants.Units.Mass.ug
        case .mg: Constants.Units.Mass.mg
        case .gm: Constants.Units.Mass.gm
        case .kg: Constants.Units.Mass.kg
        }
    }
    
    public var badgeName: String {
        name.capitalized
    }
    
    public static var display: [Units.Mass] {
        [.gm, .kg]
    }
    
    public func toggle() -> Units.Mass {
        switch self {
        case .gm: .kg
        case .kg: .gm
        default: .gm
        }
    }
}

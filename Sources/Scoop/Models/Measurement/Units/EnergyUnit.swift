//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation


@available(iOS 15.0, *)
public extension Units {
    typealias Energy = EnergyUnit
}

@available(iOS 15.0, *)
public enum EnergyUnit: Int8, NutrientUnitEnumOrderedKey {
    case cal = -3
    case kcal = 0
    
    public static var table: [String: Units.Energy] = [
        "cal" : .cal,
        "kcal": .kcal
    ]
    
    public var description: String {
        switch self {
        case .cal: Constants.Units.Energy.cal
        case .kcal: Constants.Units.Energy.kcal
        }
    }
}

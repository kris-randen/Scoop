//
//  Unitss.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/23/23.
//

import Foundation

public protocol ExponentInterconvertible: Convertible {
    func conversionExponent(to: Self) -> Int8
}

public extension ExponentInterconvertible {
    func conversion(to: Self) -> Double {
        pow(10, Double(conversionExponent(to: to)))
    }
}

public protocol Convertible {
    func conversion(to: Self) -> Double
}

public protocol UnitType: Convertible, Codable, Hashable {
    var description: String { get }
}

public extension UnitType {
    var name: String { description }
}

public protocol ExponentUnitType: UnitType, ExponentInterconvertible {}

public protocol NutrientUnitType: ExponentUnitType {}

public protocol NutrientUnitEnumOrderedKey: NutrientUnitType, EnumTypeOrderedKey {}

public protocol UnitEnumOrderedKey: UnitType, EnumTypeOrderedKey {}

public extension NutrientUnitEnumOrderedKey where RawValue == Int8 {
    func conversionExponent(to: Self) -> Int8 {
        self.rawValue - to.rawValue
    }
}

@available(iOS 15.0, *)
public enum Units {
    public static let table: [String: any NutrientUnitType] = [
        "g": Units.Mass.gm,
        "mg": Units.Mass.mg,
        "ug": Units.Mass.ug,
        "kg": Units.Mass.kg,
        "iu": Units.Mass.mg,
        "kcal": Units.Energy.kcal
    ]
}

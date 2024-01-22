//
//  Nutrients.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import Foundation
import OrderedCollections

/// A public protocol representing entities with a FoodData Central (FDC) identifier.
/// - Conforms To: Typically used by food items or nutrients with a unique identifier in the FDC database.
/// - Example Usage: `public struct Vitamin: FDCable { var fdcID: Int ... }`
/// - Conforming Types: `Vitamin`, `Mineral`, `FoodProduct`, etc.

public protocol FDCidAble: Codable, Hashable {
    var fdcID: Int { get }
}





@available(iOS 15.0, *)
public protocol DailyValueable {
    associatedtype DailyIntakes: Intakeable
    static var dailyIntakes: DailyIntakes { get }
    var dailyValue: Double { get }
}

@available(iOS 15.0, *)
public extension DailyValueable {
    var dailyValue: Double {
        Self.dailyIntakes.intakes[self as! Self.DailyIntakes.NutrientKey]!
    }
}

@available(iOS 15.0, *)
public protocol NQIndexable: DailyValueable {
    var dailyValueEnergy: Double { get }
    func nqiFactor(with energy: Energy) -> Double
    func nqi(for value: Double, with energy: Energy) -> Double
}

@available(iOS 15.0, *)
public extension NQIndexable {
    var dailyValueEnergy: Double {
        Energy.dailyValue
    }
    
    func nqiFactor(with energy: Energy) -> Double {
        dailyValueEnergy / energy.value
    }
    
    func nqi(for value: Double, with energy: Energy) -> Double {
        nqiFactor(with: energy) * value / dailyValue
    }
}

@available(iOS 15.0, *)
public protocol NutrientType: ComparableHash, NQIndexable, Codable, Equatable {
    var name: String { get }
    var display: String { get }
    var compound: String { get }
    var unit: Units.Mass { get }
    var compareKey: Int8 { get }
}

@available(iOS 15.0, *)
public extension NutrientType {
    var details: (name: String, unit: String, daily: Double) {
        (name, unit.name, dailyValue)
    }
    var required: Bool {
        Nutrient.required.contains(nutrient: self)
    }
    var nqiMultiplier: Double { required ? 1 : -1 }
    static func ==(lhs: Self, rhs: Self) -> Bool { lhs.name == rhs.name }
}

@available(iOS 15.0, *)
public extension Array where Element == any NutrientType {
    func contains(nutrient: any NutrientType) -> Bool {
        self.map{ $0.name }.contains(nutrient.name)
    }
}

public protocol Glycemic {
    var glycemicIndex: UInt { get }
}

@available(iOS 15.0, *)
public struct Nutrient {
    public typealias Grams = Double
    public typealias FDCMap = [Int: any NutrientType]
    
    static let dailyValue = Profiles.profile
    
    public static let fdcMap: FDCMap = Dictionary.merge(dicts: [
        Nutrient.Macro.fdcMap,
        Nutrient.Micro.Vitamin.fdcMap,
        Nutrient.Micro.Mineral.fdcMap
    ])
    
    public static let fdcMapper: [Nutrient.Kind: FDCMap] = [
        Nutrient.Kind.macro : Nutrient.Macro.fdcMap,
        Nutrient.Kind.vitamin: Nutrient.Micro.Vitamin.fdcMap,
        Nutrient.Kind.mineral: Nutrient.Micro.Mineral.fdcMap
    ]
    
    public static var zeroIntakes: NutrientIntakes {
        NutrientIntakes(intakes: [
            .macro : Macro.zeroIntakes,
            .vitamin: Micro.Vitamin.zeroIntakes,
            .mineral: Micro.Mineral.zeroIntakes
        ])
    }
    
    static var required: [any NutrientType] {
        Micro.Vitamin.allCases + Micro.Mineral.allCases.filter{$0 != .Na} + [Macro.energy, Macro.fiber, Macro.protein, Macro.fats, Macro.water, Macro.epa, Macro.dha]
    }
    
    static var restricted: [any NutrientType] {
        [Macro.sugar, Macro.transFat, Macro.cholesterol, Macro.saturatedFat, Macro.fats, Micro.Mineral.Na]
    }
}

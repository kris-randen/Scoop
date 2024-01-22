//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation
import OrderedCollections

@available(iOS 15.0, *)
public extension Nutrient.Macro {
    typealias Sugar = NutrientMacroSugar
}

@available(iOS 15.0, *)
public enum NutrientMacroSugar: Int8, EnumTypeOrderedKey, Glycemic, NutrientType {
    case sucrose
    case glucose
    case fructose
    case lactose
    case hfcs
    case honey
    case brown
    case jaggery
    case agave
    case maple
    
    public var compareKey: Int8 { return self.rawValue }
    
    func nqI(for value: Double, with energy: Energy) -> Double {
        0
    }
    
    public typealias DailyIntakes = MacroIntakes
    
    public static var dailyIntakes: MacroIntakes {
        Nutrient.dailyValue.intakes.intakes[.macro] as! MacroIntakes
    }
    
    public var glycemicIndex: UInt {
        switch self {
        case .glucose: return 100
        default: return 0
        }
    }
    
    public var name: String { "" }
    
    public var display: String { name }
    
    public var unit: Units.Mass { .gm }
    
    public var compound: String { "" }
}

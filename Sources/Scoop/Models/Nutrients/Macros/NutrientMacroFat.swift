//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation


@available(iOS 15.0, *)
public extension Nutrient.Macro {
    typealias Fat = NutrientMacroFat
}

@available(iOS 15.0, *)
public enum NutrientMacroFat: Int8, EnumTypeOrderedKey, NutrientType {
    case sfa
    case mufa
    case pufa
    case trans
    case cholesterol
    
    public var compareKey: Int8 { return self.rawValue }
    
    public typealias DailyIntakes = MacroIntakes
    
    public static var dailyIntakes: MacroIntakes {
        Nutrient.dailyValue.intakes.intakes[.macro] as! MacroIntakes
    }
    
    public var dailyValue: Double { 0 }
    
    public var name: String { "" }
    
    public var display: String { name }
    
    public var compound: String { "" }
    
    public var unit: Units.Mass { .gm }
    
    var fdcID: Int { 1 }
}

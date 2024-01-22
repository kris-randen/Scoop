//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation


@available(iOS 15.0, *)
public extension Nutrient.Macro {
    typealias Carb = NutrientMacroCarb
}


@available(iOS 15.0, *)
public enum NutrientMacroCarb: Int8, EnumTypeOrderedKey, NutrientType {
    public enum Rice: CaseIterable {
        case white
        case brown
    }
    
    public enum Wheat: CaseIterable {
        case whole
        case processed
    }
    
    case starch
    case rice
    case wheat
    
    
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
}

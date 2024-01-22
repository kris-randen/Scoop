//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

@available(iOS 15.0, *)
public extension Nutrient {
    typealias Kind = NutrientKind
}

@available(iOS 15.0, *)
public enum NutrientKind: String, EnumTypeOrderedKey {
    case macro = "Macro"
    case vitamin = "Vitamin"
    case mineral = "Mineral"
    case vitaminA = "Vitamin A"
    case vitaminD = "Vitamin D"
    case vitaminE = "Vitamin E"
    case vitaminK = "Vitamin K"
    
    var fdcMap: Nutrient.FDCMap { Nutrient.fdcMapper[self]! }
    
    static func get(from nutrientID: Int) -> Self? {
        allCases.filter {$0.fdcMap.keySet.contains(nutrientID)}.first
    }
    
    static var micros: String {"Micros"}
    static var macros: String {"Macros"}
    
    var chartTitle: (title: String, subtitle: String) {
        switch self {
        case .macro: (NutrientKind.macros, "Carbs, Protein, Fat")
        case .vitamin: (NutrientKind.micros, name)
        case .mineral: (NutrientKind.micros, name)
        case .vitaminA: (NutrientKind.micros, name)
        case .vitaminD: (NutrientKind.micros, name)
        case .vitaminE: (NutrientKind.micros, name)
        case .vitaminK: (NutrientKind.micros, name)
        }
    }
    
    public var name: String { self.rawValue }
    
    public var navigationTitle: String { self.name + " " + "Profile" }
    
    public func toggle() -> NutrientKind {
        switch self {
        case .vitamin: .mineral
        case .mineral: .macro
        case .macro: .vitamin
        default: .macro
        }
    }
}

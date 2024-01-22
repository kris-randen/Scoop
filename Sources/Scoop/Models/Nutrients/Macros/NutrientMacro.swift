//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation
import OrderedCollections


@available(iOS 15.0, *)
public extension Nutrient {
    typealias Macro = NutrientMacro
}

@available(iOS 15.0, *)
public enum NutrientMacro: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
    case energy
    case protein
    case fiber
    case carbs
    case sugar
    case fats
    case water
    case epa
    case dha
    case linoleicAcid
    case aLinoleicAcid
    case saturatedFat
    case transFat
    case cholesterol
    
    public var compareKey: Int8 { return self.rawValue }
    
    public typealias DailyIntakes = MacroIntakes
    
    public static var dailyIntakes: MacroIntakes {
        Nutrient.dailyValue.intakes.intakes[.macro] as! MacroIntakes
    }
    
    static var zero: OrderedDictionary<NutrientMacro, Double> {
        zeroOrderedDict.filter { fdcMap.keySet.contains($0.key.fdcID) }
    }
    
    static var zeroIntakes: MacroIntakes {
        MacroIntakes(intakes: NutrientMacro.zero)
    }
    
    public var name: String {
        switch self {
        case .energy:       CNName.calories
        case .protein:      CNName.protein
        case .sugar:        CNName.sugar
        case .water:        CNName.water
        case .carbs:        CNName.carbs
        case .fiber:        CNName.fiber
        case .cholesterol:  CNName.cholesterol
        case .linoleicAcid: CNName.linoleicAcid
        case .aLinoleicAcid:CNName.aLinoleicAcid
        case .epa:          CNName.epa
        case .dha:          CNName.dha
        case .fats:         CNName.fats
        case .saturatedFat: CNName.saturatedFat
        case .transFat:     CNName.transFat
        }
    }
    
    public var display: String {
        switch self {
        case .energy:       CNDisplay.calories
        case .sugar:        CNDisplay.sugar
        case .water:        CNDisplay.water
        case .carbs:        CNDisplay.carbs
        case .fiber:        CNDisplay.fiber
        case .fats:         CNDisplay.fats
        case .saturatedFat: CNDisplay.saturatedFat
        case .transFat:     CNDisplay.transFat
        case .cholesterol:  CNDisplay.cholesterol
        case .epa:          CNName.epa
        case .dha:          CNName.dha
        case .linoleicAcid: CNDisplay.linoleicAcid
        case .aLinoleicAcid:CNDisplay.aLinoleicAcid
        case .protein:      CNDisplay.protein
        }
    }
    
    public var unit: Units.Mass {
        switch self {
        case .cholesterol: return .mg
        default: return .gm
        }
    }
    
    public var compound: String {
        switch self {
        case .energy:       CNCompound.calories
        case .protein:      CNCompound.protein
        case .sugar:        CNCompound.sugar
        case .water:        CNCompound.water
        case .carbs:        CNCompound.carbs
        case .fiber:        CNCompound.fiber
        case .cholesterol:  CNCompound.cholesterol
        case .linoleicAcid: CNCompound.linoleicAcid
        case .aLinoleicAcid:CNCompound.aLinoleicAcid
        case .epa:          CNCompound.epa
        case .dha:          CNCompound.dha
        case .fats:         CNCompound.fats
        case .saturatedFat: CNCompound.saturatedFat
        case .transFat:     CNCompound.transFat
        }
    }
    
    public var fdcID: Int {
        switch self {
        case .energy:           CNFDCid.energy
        case .protein:          CNFDCid.protein
        case .sugar:            CNFDCid.sugar
        case .water:            CNFDCid.water
        case .carbs:            CNFDCid.carbs
        case .fiber:            CNFDCid.fiber
        case .cholesterol:      CNFDCid.cholesterol
        case .linoleicAcid:     CNFDCid.linAcid
        case .aLinoleicAcid:    CNFDCid.aLinAcid
        case .epa:              CNFDCid.epa
        case .dha:              CNFDCid.dha
        case .fats:             CNFDCid.fats
        case .saturatedFat:     CNFDCid.saturatedFat
        case .transFat:         CNFDCid.transFat
        }
    }
    
    static let fdcMap: Nutrient.FDCMap = Constants.Nutrients.FDCmap.macro
}

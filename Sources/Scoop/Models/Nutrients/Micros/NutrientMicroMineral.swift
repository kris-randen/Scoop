//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation
import OrderedCollections

@available(iOS 15.0, *)
public enum NutrientMicroMineral: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
    case Ca
    case Cl
    case Cr
    case Cu
    case F
    case I
    case Fe
    case Mg
    case Mn
    case Mo
    case P
    case K
    case Se
    case Na
    case Zn
//            case S
    
    public var compareKey: Int8 { return self.rawValue }
    
    public typealias DailyIntakes = MineralIntakes
    
    public static var dailyIntakes: DailyIntakes {
        Nutrient.dailyValue.intakes.intakes[.mineral] as! MineralIntakes
    }
    
    static var zero: OrderedDictionary<NutrientMicroMineral, Double> {
        NutrientMicroMineral.zeroOrderedDict.filter{fdcMap.keySet.contains($0.key.fdcID)}
    }
    
    static var zeroIntakes: MineralIntakes {
        MineralIntakes(intakes: NutrientMicroMineral.zero)
    }
    
    public var unit: Units.Mass {
        switch self {
        case .Cl:
            return .gm
        case .Cr, .Cu, .I, .Mo, .Se:
            return .ug
        default:
            return .mg
        
        
        }
    }
    
    public var name: String {
        switch self {
        case .Ca:   CNName.calcium
        case .Cl:   CNName.chloride
        case .Cr:   CNName.chromium
        case .Cu:   CNName.copper
        case .F:    CNName.fluoride
        case .Fe:   CNName.iron
        case .Mg:   CNName.magnesium
        case .Mn:   CNName.manganese
        case .Mo:   CNName.molybdenum
        case .P:    CNName.phosphorous
        case .I:    CNName.iodine
        case .K:    CNName.potassium
        case .Se:   CNName.selenium
        case .Na:   CNName.sodium
        case .Zn:   CNName.zinc
//                case .S:    CNName.sulfur
        }
    }
    
    public var display: String { name }
    
    public var compound: String {
        switch self {
        case .Ca:   CNCompound.calcium
        case .Cl:   CNCompound.chloride
        case .Cr:   CNCompound.chromium
        case .Cu:   CNCompound.copper
        case .F:    CNCompound.fluoride
        case .I:    CNCompound.iodine
        case .Fe:   CNCompound.iron
        case .Mg:   CNCompound.magnesium
        case .Mn:   CNCompound.manganese
        case .Mo:   CNCompound.molybdenum
        case .P:    CNCompound.phosphorous
        case .K:    CNCompound.potassium
        case .Se:   CNCompound.selenium
        case .Na:   CNCompound.sodium
        case .Zn:   CNCompound.zinc
//                case .S:    CNCompound.sulfur
        }
    }
    
    public var fdcID: Int {
        switch self {
        case .Ca:   CNFDCid.calcium
        case .Cl:   CNFDCid.chloride
        case .Fe:   CNFDCid.iron
        case .Mg:   CNFDCid.magnesium
        case .P:    CNFDCid.phosphorous
        case .K:    CNFDCid.potassium
        case .Na:   CNFDCid.sodium
        case .Zn:   CNFDCid.zinc
        case .Cr:   CNFDCid.chromium
        case .Cu:   CNFDCid.copper
        case .F:    CNFDCid.fluoride
        case .I:    CNFDCid.iodine
        case .Mn:   CNFDCid.manganese
        case .Mo:   CNFDCid.molybdenum
        case .Se:   CNFDCid.selenium
//                case .S:    CNFDCid.sulphur
        }
    }
    
    static let fdcMap: Nutrient.FDCMap = Constants.Nutrients.FDCmap.mineral
    
    func DRI(nutrient: Nutrient.Micro.Mineral, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
        0
    }
}

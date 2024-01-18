//
//  FDCUnit.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation
import OrderedCollections

public typealias FDCUnit = String

@available(iOS 15.0, *)
public struct FDCUnits {
    public static let energies: Set = Constants.FDCunits.energy
    public static let masses: Set = Constants.FDCunits.mass
    public static let ius: Set = Constants.FDCunits.iu
    public static let lengths: Set = Constants.FDCunits.length
    public static let volumes: Set = Constants.FDCunits.volume
    
    public static func unit(for intake: FDCfoodNutrientIntake) -> any NutrientUnitEnumOrderedKey {
        intake.nutrient.unit
    }
    
    public static func conversion(for intake: FDCfoodNutrientIntake) -> Double {
        let (fdcUnitName, unit) = (intake.unitName.lowercased(), intake.unit)
        let unitName = unit.description.lowercased()
    
        if energies.contains(fdcUnitName) {
            return 1
        }
        else if masses.contains(fdcUnitName) {
            return Units.Mass.table[fdcUnitName]!.conversion(to: Units.Mass.table[unitName]!)
        }
        else if lengths.contains(fdcUnitName) {
            return Units.Length.table[fdcUnitName]!.conversion(to: Units.Length.table[unitName]!)
        }
        else if volumes.contains(fdcUnitName) {
            return Units.Volume.table[fdcUnitName]!.conversion(to: Units.Volume.table[unitName]!)
        }
        else if ius.contains(fdcUnitName) {
            guard let vitamin = intake.nutrient as? Nutrient.Micro.Vitamin else { return 0 }
            if vitamin == .aiu {
                return Units.IU.vitaminA.conversion(to: .mg)
            } else if vitamin == .diu {
                return Units.IU.vitaminD.conversion(to: .mg)
            } else if vitamin == .eiu {
                return Units.IU.vitaEnat.conversion(to: .mg)
            }
        }
        return 0
    }
    
    public static func chart(contains intake: FDCfoodNutrientIntake) -> Bool {
        Nutrient.fdcMap.keySet.contains(intake.nutrientId)
    }
    
    public static func value(for intake: FDCfoodNutrientIntake) -> Double {
        intake.value * conversion(for: intake)
    }
    
    public static func convert(_ intake: FDCfoodNutrientIntake) -> Intake {
        (intake.nutrient, value(for: intake))
    }
    
    public static func convert(_ intakes: [FDCfoodNutrientIntake]) -> [Intake] {
        intakes.filter{chart(contains: $0)}.map{convert($0)}
    }
    
    public static func isAmacro(_ intake: FDCfoodNutrientIntake) -> Bool {
        Nutrient.Macro.fdcMap.keySet.contains(intake.nutrientId)
    }
    
    public static func isAvitamin(_ intake: FDCfoodNutrientIntake) -> Bool {
        Nutrient.Micro.Vitamin.fdcMap.keySet.contains(intake.nutrientId)
    }
    
    public static func isAmineral(_ intake: FDCfoodNutrientIntake) -> Bool {
        Nutrient.Micro.Mineral.fdcMap.keySet.contains(intake.nutrientId)
    }
    
    public static func macros(from intakes: [FDCfoodNutrientIntake]) -> [MacroIntake] {
        convert(intakes.filter {isAmacro($0)}) as! [MacroIntake]
    }
    
    public static func vitamins(from intakes: [FDCfoodNutrientIntake]) -> [VitaminIntake] {
        convert(intakes.filter {isAvitamin($0)}) as! [VitaminIntake]
    }
    
    public static func minerals(from intakes: [FDCfoodNutrientIntake]) -> [MineralIntake] {
        convert(intakes.filter {isAmineral($0)}) as! [MineralIntake]
    }
    
    public static func macroIntakes(from intakes: [FDCfoodNutrientIntake]) -> MacroIntakes {
        MacroIntakes(intakes: OrderedDictionary(uniqueKeysWithValues: macros(from: intakes)))
    }
    
    public static func macroIntakesAll(from intakes: [FDCfoodNutrientIntake]) -> MacroIntakes {
        MacroIntakes(intakes: Nutrient.Macro.zero.updated(with: macroIntakes(from: intakes).intakes))
    }
    
    public static func vitaminIntakes(from intakes: [FDCfoodNutrientIntake]) -> VitaminIntakes {
        VitaminIntakes(intakes: OrderedDictionary(uniqueKeysWithValues: vitamins(from: intakes)))
    }
    
    public static func vitaminIntakesAll(from intakes: [FDCfoodNutrientIntake]) -> VitaminIntakes {
        VitaminIntakes(intakes: Nutrient.Micro.Vitamin.zero.updated(with: vitaminIntakes(from: intakes).intakes))
    }
    
    public static func mineralIntakes(from intakes: [FDCfoodNutrientIntake]) -> MineralIntakes {
        MineralIntakes(intakes: OrderedDictionary(uniqueKeysWithValues: minerals(from: intakes)))
    }
    
    public static func mineralIntakesAll(from intakes: [FDCfoodNutrientIntake]) -> MineralIntakes {
        MineralIntakes(intakes: Nutrient.Micro.Mineral.zero.updated(with: mineralIntakes(from: intakes).intakes))
    }
    
    public static func nutrientIntakes(from intakes: [FDCfoodNutrientIntake]) -> NutrientIntakes {
        NutrientIntakes(intakes: [
            .macro: macroIntakes(from: intakes),
            .vitamin: vitaminIntakes(from: intakes),
            .mineral: mineralIntakes(from: intakes)
        ])
    }
    
    public static func nutrientIntakesAll(from intakes: [FDCfoodNutrientIntake]) -> NutrientIntakes {
        NutrientIntakes(intakes: [
            .macro: macroIntakesAll(from: intakes),
            .vitamin: vitaminIntakesAll(from: intakes),
            .mineral: mineralIntakesAll(from: intakes)
        ])
    }
    
    public static func nutrientProfile(from intakes: [FDCfoodNutrientIntake]) -> NutrientProfile {
        NutrientProfile(intakes: nutrientIntakesAll(from: intakes), description: "FDC Data", type: .nqi)
    }
}

//
//  NutrientProfiles.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/23/23.
//

//
//  NutrientProfile.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation
//import Collections
import OrderedCollections

@available(iOS 15.0, *)
public protocol NutrientProfileable: Multipliable {
    var description: String { get }
    var type: NutrientValueType { get }
    var intakes: NutrientIntakes { get set }
    var serving: Serving { get }
    
    var nqi: Double { get }
}

@available(iOS 15.0, *)
public extension NutrientProfileable {
    var nqi: Double {
        nqi(for: macroIntakes) +
        nqi(for: vitaminIntakes) +
        nqi(for: mineralIntakes)
    }
    
    var energy: Double {
        let macros = intakes.intakes[.macro] as! MacroIntakes
        return macros.intakes[.energy]!
    }
    
    var nqiFactor: Double {
        Constants.DRI.energy / energy
    }
    
    mutating func multiply(_ factor: Double) {
        self.intakes = factor * self.intakes
    }
    
    var food: String {
        description.capitalized
    }
    
    var servingDescription: String {
        "\(serving.value) \(serving.unit.description)"
    }
    
    var macroIntakes: MacroIntakes {
        intakes.intakes[.macro]! as! MacroIntakes
    }
    
    var vitaminIntakes: VitaminIntakes {
        intakes.intakes[.vitamin]! as! VitaminIntakes
    }
    
    var mineralIntakes: MineralIntakes {
        intakes.intakes[.mineral]! as! MineralIntakes
    }
    
    var intakesMacro: IntakesMacro { macroIntakes.intakes }
    
    var intakesVitamin: IntakesVitamin { vitaminIntakes.intakes }
    
    var intakesMineral: IntakesMineral { mineralIntakes.intakes }
    
    var intakesAndScaledMacro: [MacroIntakeAndScaled] {
        intakesMacro.map{($0.key, $0.value, scaled(for: $0.key))}
    }
    
    var intakesAndScaledVitamin: [VitaminIntakeAndScaled] {
        intakesVitamin.map{($0.key, $0.value, scaled(for: $0.key))}
    }
    
    var intakesAndScaledMineral: [MineralIntakeAndScaled] {
        intakesMineral.map{($0.key, $0.value, scaled(for: $0.key))}
    }
    
    var scaledIntakes: NutrientIntakes {
        NutrientIntakes(intakes: [
            .macro: scaledMacroIntakes,
            .vitamin: scaledVitaminIntakes,
            .mineral: scaledMineralIntakes
        ])
    }
    
    var scaledMacroIntakes: MacroIntakes {
        MacroIntakes(intakes: intakesMacro.mapD{($0.key, scaled(for: $0.key))})
    }
    
    var scaledVitaminIntakes: VitaminIntakes {
        VitaminIntakes(intakes: intakesVitamin.mapD{($0.key, scaled(for: $0.key))})
    }
    
    var scaledMineralIntakes: MineralIntakes {
        MineralIntakes(intakes: intakesMineral.mapD{($0.key, scaled(for: $0.key))})
    }
    
    func value(for nutrient: Nutrient.Macro) -> Double {
        macroIntakes.intakes[nutrient]!
    }
    
    func value(for nutrient: Nutrient.Micro.Vitamin) -> Double {
        vitaminIntakes.intakes[nutrient]!
    }
    
    func value(for nutrient: Nutrient.Micro.Mineral) -> Double {
        mineralIntakes.intakes[nutrient]!
    }
    
    func factor(for nutrient: any NutrientType) -> Double {
        switch type {
        case .value: nqiFactor
        case .nqi: nutrient.dailyValue
        case .scaled: 1
        }
    }
    
    func scaled(for nutrient: Nutrient.Macro) -> Double {
        factor(for: nutrient) * value(for: nutrient)
    }
    
    func scaled(for nutrient: Nutrient.Micro.Vitamin) -> Double {
        factor(for: nutrient) * value(for: nutrient)
    }
    
    func scaled(for nutrient: Nutrient.Micro.Mineral) -> Double {
        factor(for: nutrient) * value(for: nutrient)
    }
    
    func scale(for nutrient: Nutrient.Macro) -> Double {
        scaled(for: nutrient) / nutrient.dailyValue
    }
    
    func scale(for nutrient: Nutrient.Micro.Vitamin) -> Double {
        scaled(for: nutrient) / nutrient.dailyValue
    }
    
    func scale(for nutrient: Nutrient.Micro.Mineral) -> Double {
        scaled(for: nutrient) / nutrient.dailyValue
    }
    
    func multiple(for nutrient: Nutrient.Macro) -> Double {
        if nutrient == .sugar {
            return (value(for: .fiber) > 0) ? 0 : -29
        }
        if nutrient == .carbs {
            return (value(for: .fiber) > 0) ? 0 : -29
        }
        return nutrient.required ? 1 : -29
    }
    
    func multiple(for nutrient: Nutrient.Micro.Vitamin) -> Double {
        nutrient.required ? 1 : -29
    }
    
    func multiple(for nutrient: Nutrient.Micro.Mineral) -> Double {
        nutrient.required ? 1 : -29
    }
    
    func nqi(for nutrient: Nutrient.Macro) -> Double {
        multiple(for: nutrient) * scale(for: nutrient)
    }
    
    func nqi(for nutrient: Nutrient.Micro.Vitamin) -> Double {
        multiple(for: nutrient) * scale(for: nutrient)
    }
    
    func nqi(for nutrient: Nutrient.Micro.Mineral) -> Double {
        multiple(for: nutrient) * scale(for: nutrient)
    }
    
    func nqi(for intakes: MacroIntakes) -> Double {
        intakes.intakes.reduce(0) { $0 + nqi(for: $1.key) }
    }
    
    func nqi(for intakes: VitaminIntakes) -> Double {
        intakes.intakes.reduce(0) { $0 + nqi(for: $1.key) }
    }
    
    func nqi(for intakes: MineralIntakes) -> Double {
        intakes.intakes.reduce(0) { $0 + nqi(for: $1.key) }
    }
}


@available(iOS 15.0, *)
public protocol ServeableNutrientProfile: NutrientProfileable {
    var serving: Serving { get }
}

@available(iOS 15.0, *)
public struct NutrientProfile: NutrientProfileable, NQIconvertible, Scalable, DailyValueScaleable {
    public var intakes: NutrientIntakes
    public var description: String
    public var type: NutrientValueType
    public var serving: Serving = Serving(value: 100, unit: .gm)
    var energy = Energy(unit: .kcal, value: 0)
}

@available(iOS 15.0, *)
public extension NutrientProfile {
    static func convertValueToNQI(valueProfile: NutrientProfile) -> NutrientProfile {
        var result = valueProfile
        result = valueProfile.nqiFactor * result
        result.type = .nqi
        return result
    }
    
    func convertedToNQI() -> NutrientProfile {
        if self.type == .nqi { return self }
        return self.convertedToNQI(for: self.energy)
    }
    
    func scaledTo(servingSize: Serving) -> Self {
        let factor = serving.factor(to: servingSize)
        return scaledTo(factor: factor)
    }
    
    func scaledTo(factor: Double) -> Self {
        return self * factor
    }
    
    func scaledByDV() -> Self {
        return Self.init(intakes: self.intakes.scaledByDV(), description: self.description, type: .scaled)
    }
    
    func convertedToNQI(for energy: Energy) -> Self {
        var nqiProfile = self
        nqiProfile.type = .nqi
        nqiProfile.intakes = intakes.convertedToNQI(for: energy)
        return nqiProfile
    }
}

@available(iOS 15.0, *)
public protocol Multipliable {
    mutating func multiply(_ factor: Double)
    func multiplied(by factor: Double) -> Self
    static func *(lhs: Double, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Double) -> Self
}

@available(iOS 15.0, *)
public extension Multipliable {
    func multiplied(by factor: Double) -> Self {
        var result = self
        result.multiply(factor)
        return result
    }
    static func *(lhs: Double, rhs: Self) -> Self {
        rhs.multiplied(by: lhs)
    }
    static func *(lhs: Self, rhs: Double) -> Self {
        lhs.multiplied(by: rhs)
    }
}

@available(iOS 15.0, *)
extension Double: Multipliable {
    mutating public func multiply(_ factor: Double) { self = self * factor }
}

@available(iOS 15.0, *)
extension OrderedDictionary: Multipliable where Value: Multipliable {
    mutating public func multiply(_ factor: Double) {
        for (key, value) in self {
            self[key] = value.multiplied(by: factor)
        }
    }
}

@available(iOS 15.0, *)
extension Dictionary: Multipliable where Value: Multipliable {
    mutating public func multiply(_ factor: Double) {
        for (key, value) in self {
            self[key] = value.multiplied(by: factor)
        }
    }
}

@available(iOS 15.0, *)
public struct NutrientProfileServed: ServeableNutrientProfile {
    public var intakes: NutrientIntakes
    public var serving: Serving = Serving(value: 100, unit: .gm)
    public var description: String
    public var type: NutrientValueType
}


@available(iOS 15.0, *)
public struct Profiles {
    static let dict: [String: NutrientProfile] = [
                "boost": boostHighProteinDrink,
                "boost high protein drink": boostHighProteinDrink,
                "sugar": sugarWhite,
                "arugula": arugula,
                "carrot": carrot
    ]
    static let profile = NutrientProfile(
        intakes: NutrientIntakes(intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 900, .c: 90, .d: 20, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                .b3: 16, .b6: 1.7, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
            ]),
            .mineral: MineralIntakes(intakes: [
                .Ca: 1300, .Cr: 35, .Cu: 900, .F: 4, .I: 150, .Fe: 18, .Mg: 420, .Mn: 2.3,
                .Mo: 45, .P: 1250, .Se: 55, .Zn: 11, .K: 4700, .Na: 2300, .Cl: 2.3
            ]),
            .macro: MacroIntakes(intakes: [
                .water: 3700, .carbs: 130, .sugar: 20, .fats: 78, .fiber: 38, .linoleicAcid: 17, .aLinoleicAcid: 1.6, .protein: 56, .energy: Constants.DRI.energy, .cholesterol: 300.0, .saturatedFat: 13.0, .transFat: 2.0, .epa: 0.5, .dha: 0.5
            ])
        ]), description: "Daily Value",
        type: .value)
    
    static let boostHighProteinDrink = NutrientProfile(
        intakes: NutrientIntakes(intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 1.6, .c: 8, .d: 4.8, .e: 8, .k: 2, .b1: 2, .b2: 3.2,
                .b3: 1.6, .b4: 0.8, .b5: 2, .b6: 2.8, .b7: 4, .b9: 2, .b12: 3.6
            ]),
            .mineral: MineralIntakes(intakes: [
                .Ca: 2.4, .Cr: 4, .Cu: 3.6,.F: 0, .I: 2, .Fe: 2, .Mg: 2, .Mn: 2.8,
                .Mo: 2, .P: 2, .Se: 2.8, .Zn: 3.2, .K: 0.8, .Na: 0.8, .Cl: 1.2
            ]),
            .macro: MacroIntakes(intakes: [
                .fats: 0.64, .carbs: 0.8, .fiber: 0, .sugar: 4.4, .protein: 3.2
            ])
        ]), description: Constants.Food.boostHighProteinDrink,
        type: .nqi)
    
    static let sugarWhite = NutrientProfile(
        intakes: NutrientIntakes(intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 0, .c: 0, .d: 0, .e: 0, .k: 0, .b1: 0, .b2: 0,
                .b3: 0, .b4: 0, .b5: 0, .b6: 0, .b7: 0, .b9: 0, .b12: 0
            ]),
            .mineral: MineralIntakes(intakes: [
                .Ca: 0, .Cr: 0, .Cu: 0,.F: 0, .I: 0, .Fe: 0, .Mg: 0, .Mn: 0,
                .Mo: 0, .P: 0, .Se: 0, .Zn: 0, .K: 0, .Na: 0, .Cl: 0
            ]),
            .macro: MacroIntakes(intakes: [
                .fats: 0, .carbs: 2, .fiber: 0, .sugar: 25, .protein: 0
            ])
        ]), description: Constants.Food.sugarWhite,
        type: .nqi)
    
    static let arugula = NutrientProfile(
        intakes: NutrientIntakes(intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 10.6, .c: 13.3, .d: 0, .e: 0, .k: 72.7, .b1: 2.9, .b2: 5.3,
                .b3: 1.5, .b4: 2.2, .b5: 7, .b6: 3.4, .b7: 0, .b9: 19.4, .b12: 0
            ]),
            .mineral: MineralIntakes(intakes: [
                .Ca: 9.8, .Cr: 0, .Cu: 6.8,.F: 0, .I: 0, .Fe: 6.5, .Mg: 9, .Mn: 11.2,
                .Mo: 0, .P: 3.33, .Se: 0.44, .Zn: 3.4, .K: 6.3, .Na: 0.94, .Cl: 0
            ]),
            .macro: MacroIntakes(intakes: [
                .fats: 0.68, .carbs: 1.06, .fiber: 4.57, .sugar: 0, .protein: 4.13
            ])
        ]), description: Constants.Food.arugula,
        type: .nqi)
    
    static let carrot = NutrientProfile(intakes: NutrientIntakes(intakes: [
        .macro: MacroIntakes(intakes: [
            .carbs: 1.70,
            .fiber: 4.88,
            .sugar: 0,
            .protein: 0.91,
            .fats: 0.15,
            .linoleicAcid: 0.0,
            .aLinoleicAcid: 0.0,
            .cholesterol: 0.0,
            .saturatedFat: 0.0,
            .water: 1.2
        ]),
        .vitamin: VitaminIntakes(intakes: [
            .a: 45.3,
            .c: 3.2,
            .d: 0,
            .e: 2.15,
            .k: 5.37,
            .b1: 2.68,
            .b2: 2.18,
            .b3: 3,
            .b4: 0.78,
            .b5: 2.7,
            .b6: 4,
            .b7: 0,
            .b9: 2.32,
            .b12: 0
        ]),
        .mineral: MineralIntakes(intakes: [
            .Ca: 1.24,
            .Cr: 0,
            .Cu: 2.44,
            .F: 0.04,
            .I: 0,
            .Fe: 0.81,
            .Mg: 1.39,
            .Mn: 3,
            .Mo: 0,
            .P: 1.4,
            .Se: 0.09,
            .Zn: 1.06,
            .K: 3.32,
            .Na: 1.46,
            .Cl: 0
        ])
    ]), description: Constants.Food.carrot, type: .nqi)
}

public struct FoodItemProfiles {
    static let boostHighProteinDrink = "Boost High Protein Drink"
    static let boostVeryHighEnergyDrink = "Boost Very High Energy Drink"
    static let boostMaxMenShake = "Boost Max Men Shake"
}


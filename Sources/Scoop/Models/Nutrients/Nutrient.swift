//
//  Nutrients.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import Foundation
//import Collections
import OrderedCollections

/// A public protocol representing entities with a FoodData Central (FDC) identifier.
/// - Conforms To: Typically used by food items or nutrients with a unique identifier in the FDC database.
/// - Example Usage: `public struct Vitamin: FDCable { var fdcID: Int ... }`
/// - Conforming Types: `Vitamin`, `Mineral`, `FoodProduct`, etc.

public protocol FDCidAble: Codable, Hashable {
    var fdcID: Int { get }
}

/// Represents a measurable value with a unit, typically used for nutrient content or ingredient measurements.
/// - Conforms To: `ConvertibleMeasure` public protocol for quantifiable elements that are interconvertible to different units
/// - Example Usage: `let sugarContent = Value(value: 5.0, unit: .grams)`
/// - Conforming Types: Used as a base structure for representing measurable quantities in various contexts.

@available(iOS 15.0, *)
public struct Value: ConvertibleMeasure {
    public typealias Unit = Units.Mass
    public var unit: Unit
    public var value: Double
    
    public init(unit: Unit, value: Double) {
        self.unit = unit
        self.value = value
    }
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
    
    public typealias Micrograms = Double
    public typealias Milligrams = Double
    
    static var required: [any NutrientType] {
        Micro.Vitamin.allCases + Micro.Mineral.allCases.filter{$0 != .Na} + [Macro.energy, Macro.fiber, Macro.protein, Macro.fats, Macro.water, Macro.epa, Macro.dha]
    }
    
    static var restricted: [any NutrientType] {
        [Macro.sugar, Macro.transFat, Macro.cholesterol, Macro.saturatedFat, Macro.fats, Micro.Mineral.Na]
    }
}


//    public enum Kind: String, EnumTypeOrderedKey {
//        case macro = "Macro"
//        case vitamin = "Vitamin"
//        case mineral = "Mineral"
//        case vitaminA = "Vitamin A"
//        case vitaminD = "Vitamin D"
//        case vitaminE = "Vitamin E"
//        case vitaminK = "Vitamin K"
//
//        var fdcMap: FDCMap { Nutrient.fdcMapper[self]! }
//
//        static func get(from nutrientID: Int) -> Self? {
//            allCases.filter {$0.fdcMap.keySet.contains(nutrientID)}.first
//        }
//
//        static var micros: String {"Micros"}
//        static var macros: String {"Macros"}
//
//        var chartTitle: (title: String, subtitle: String) {
//            switch self {
//            case .macro: (Kind.macros, "Carbs, Protein, Fat")
//            case .vitamin: (Kind.micros, name)
//            case .mineral: (Kind.micros, name)
//            case .vitaminA: (Kind.micros, name)
//            case .vitaminD: (Kind.micros, name)
//            case .vitaminE: (Kind.micros, name)
//            case .vitaminK: (Kind.micros, name)
//            }
//        }
//
//        public var name: String { self.rawValue }
//
//        public var navigationTitle: String { self.name + " " + "Profile" }
//
//        public func toggle() -> Kind {
//            switch self {
//            case .vitamin: .mineral
//            case .mineral: .macro
//            case .macro: .vitamin
//            default: .macro
//            }
//        }
//    }


//    public enum Macro: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
//        case energy
//        case protein
//        case fiber
//        case carbs
//        case sugar
//        case fats
//        case water
//        case epa
//        case dha
//        case linoleicAcid
//        case aLinoleicAcid
//        case saturatedFat
//        case transFat
//        case cholesterol
//
//        public var compareKey: Int8 { return self.rawValue }
//
//        public typealias DailyIntakes = MacroIntakes
//
//        public static var dailyIntakes: MacroIntakes {
//            Nutrient.dailyValue.intakes.intakes[.macro] as! MacroIntakes
//        }
//
//        static var zero: OrderedDictionary<Macro, Double> {
//            zeroOrderedDict.filter { fdcMap.keySet.contains($0.key.fdcID) }
//        }
//
//        static var zeroIntakes: MacroIntakes {
//            MacroIntakes(intakes: Macro.zero)
//        }
//
//        public var name: String {
//            switch self {
//            case .energy:       CNName.calories
//            case .protein:      CNName.protein
//            case .sugar:        CNName.sugar
//            case .water:        CNName.water
//            case .carbs:        CNName.carbs
//            case .fiber:        CNName.fiber
//            case .cholesterol:  CNName.cholesterol
//            case .linoleicAcid: CNName.linoleicAcid
//            case .aLinoleicAcid:CNName.aLinoleicAcid
//            case .epa:          CNName.epa
//            case .dha:          CNName.dha
//            case .fats:         CNName.fats
//            case .saturatedFat: CNName.saturatedFat
//            case .transFat:     CNName.transFat
//            }
//        }
//
//        public var display: String {
//            switch self {
//            case .energy:       CNDisplay.calories
//            case .sugar:        CNDisplay.sugar
//            case .water:        CNDisplay.water
//            case .carbs:        CNDisplay.carbs
//            case .fiber:        CNDisplay.fiber
//            case .fats:         CNDisplay.fats
//            case .saturatedFat: CNDisplay.saturatedFat
//            case .transFat:     CNDisplay.transFat
//            case .cholesterol:  CNDisplay.cholesterol
//            case .epa:          CNName.epa
//            case .dha:          CNName.dha
//            case .linoleicAcid: CNDisplay.linoleicAcid
//            case .aLinoleicAcid:CNDisplay.aLinoleicAcid
//            case .protein:      CNDisplay.protein
//            }
//        }
//
//        public var unit: Units.Mass {
//            switch self {
//            case .cholesterol: return .mg
//            default: return .gm
//            }
//        }
//
//        public var compound: String {
//            switch self {
//            case .energy:       CNCompound.calories
//            case .protein:      CNCompound.protein
//            case .sugar:        CNCompound.sugar
//            case .water:        CNCompound.water
//            case .carbs:        CNCompound.carbs
//            case .fiber:        CNCompound.fiber
//            case .cholesterol:  CNCompound.cholesterol
//            case .linoleicAcid: CNCompound.linoleicAcid
//            case .aLinoleicAcid:CNCompound.aLinoleicAcid
//            case .epa:          CNCompound.epa
//            case .dha:          CNCompound.dha
//            case .fats:         CNCompound.fats
//            case .saturatedFat: CNCompound.saturatedFat
//            case .transFat:     CNCompound.transFat
//            }
//        }
//
//        public var fdcID: Int {
//            switch self {
//            case .energy:           CNFDCid.energy
//            case .protein:          CNFDCid.protein
//            case .sugar:            CNFDCid.sugar
//            case .water:            CNFDCid.water
//            case .carbs:            CNFDCid.carbs
//            case .fiber:            CNFDCid.fiber
//            case .cholesterol:      CNFDCid.cholesterol
//            case .linoleicAcid:     CNFDCid.linAcid
//            case .aLinoleicAcid:    CNFDCid.aLinAcid
//            case .epa:              CNFDCid.epa
//            case .dha:              CNFDCid.dha
//            case .fats:             CNFDCid.fats
//            case .saturatedFat:     CNFDCid.saturatedFat
//            case .transFat:         CNFDCid.transFat
//            }
//        }
//
//        static let fdcMap: FDCMap = Constants.Nutrients.FDCmap.macro
//
//        public enum Sugar: Int8, EnumTypeOrderedKey, Glycemic, NutrientType {
//            case sucrose
//            case glucose
//            case fructose
//            case lactose
//            case hfcs
//            case honey
//            case brown
//            case jaggery
//            case agave
//            case maple
//
//            public var compareKey: Int8 { return self.rawValue }
//
//            func nqI(for value: Double, with energy: Energy) -> Double {
//                0
//            }
//
//            public typealias DailyIntakes = MacroIntakes
//
//            public static var dailyIntakes: MacroIntakes {
//                Nutrient.dailyValue.intakes.intakes[.macro] as! MacroIntakes
//            }
//
//            public var glycemicIndex: UInt {
//                switch self {
//                case .glucose: return 100
//                default: return 0
//                }
//            }
//
//            public var name: String { "" }
//
//            public var display: String { name }
//
//            public var unit: Units.Mass { .gm }
//
//            public var compound: String { "" }
//        }
//
//        public enum Carb: Int8, EnumTypeOrderedKey, NutrientType {
//            public enum Rice: CaseIterable {
//                case white
//                case brown
//            }
//
//            public enum Wheat: CaseIterable {
//                case whole
//                case processed
//            }
//
//            case starch
//            case rice
//            case wheat
//
//
//            public var compareKey: Int8 { return self.rawValue }
//
//            public typealias DailyIntakes = MacroIntakes
//
//            public static var dailyIntakes: MacroIntakes {
//                Nutrient.dailyValue.intakes.intakes[.macro] as! MacroIntakes
//            }
//
//            public var dailyValue: Double { 0 }
//            public var name: String { "" }
//            public var display: String { name }
//            public var compound: String { "" }
//            public var unit: Units.Mass { .gm }
//        }
//
//        public enum Fat: Int8, EnumTypeOrderedKey, NutrientType {
//            case sfa
//            case mufa
//            case pufa
//            case trans
//            case cholesterol
//
//            public var compareKey: Int8 { return self.rawValue }
//
//            public typealias DailyIntakes = MacroIntakes
//
//            public static var dailyIntakes: MacroIntakes {
//                Nutrient.dailyValue.intakes.intakes[.macro] as! MacroIntakes
//            }
//
//            public var dailyValue: Double { 0 }
//
//            public var name: String { "" }
//
//            public var display: String { name }
//
//            public var compound: String { "" }
//
//            public var unit: Units.Mass { .gm }
//
//            var fdcID: Int { 1 }
//        }
//    }


//        public enum Vitamin: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
//            case a      //(total: Micrograms, retinol: Micrograms? = nil, betaCarotene: Micrograms? = nil)
//            case aiu
//            case b1     //(thiamin: Milligrams)
//            case b2     //(riboflavin: Milligrams)
//            case b3     //(niacin: Milligrams)
//            case b4     //(choline: Milligrams)
//            case b5     //(pantothenicAcid: Milligrams)
//            case b6     //(total: Milligrams, pyridoxal: Milligrams? = nil, pyridoxine: Milligrams? = nil, pyridoxamine: Milligrams? = nil)
//            case b7     //(biotin: Micrograms)
//            case b9     //(folate: Micrograms)
//            case b12    //(cobalamin: Micrograms)
//            case c      //(ascorbicAcid: Milligrams)
//            case d      //(total: Micrograms, cholecalciferol: Micrograms? = nil, ergocalciferol: Micrograms? = nil)
//            case diu
//            case e      //(alphaTocopherol: Milligrams)
//            case eiu
//            case k      //(total: Micrograms, phylloquinone: Micrograms? = nil, menadione: Micrograms? = nil)
//
//            public var compareKey: Int8 { return self.rawValue }
//
//            public typealias DailyIntakes = VitaminIntakes
//
//            public static var dailyIntakes: VitaminIntakes {
//                Nutrient.dailyValue.intakes.intakes[.vitamin] as! VitaminIntakes
//            }
//
//            static var zero: OrderedDictionary<Vitamin, Double> {
//                Vitamin.zeroOrderedDict.filter{fdcMap.keySet.contains($0.key.fdcID)}
//            }
//
//            static var zeroIntakes: VitaminIntakes {
//                VitaminIntakes(intakes: Vitamin.zero)
//            }
//
//            public var unit: Units.Mass {
//                switch self {
//                case .a, .aiu, .b7, .b9, .b12, .d, .diu, .k:
//                    return .ug
//                case .b1, .b2, .b3, .b4, .b5, .b6, .c, .e, .eiu:
//                    return .mg
//                }
//            }
//
//            public var name: String {
//                switch self {
//                case .a:    CNName.vitaminA
//                case .aiu:  CNName.vitaminAiu
//                case .b1:   CNName.vitaminB1
//                case .b2:   CNName.vitaminB2
//                case .b3:   CNName.vitaminB3
//                case .b4:   CNName.vitaminB4
//                case .b5:   CNName.vitaminB5
//                case .b6:   CNName.vitaminB6
//                case .b7:   CNName.vitaminB7
//                case.b9:    CNName.vitaminB9
//                case .b12:  CNName.vitaminB12
//                case .c:    CNName.vitaminC
//                case .d:    CNName.vitaminD
//                case .diu:  CNName.vitaminDiu
//                case .e:    CNName.vitaminE
//                case .eiu:  CNName.vitaminEiu
//                case .k:    CNName.vitaminK
//                }
//            }
//
//            public var display: String { name }
//
//            public var compound: String {
//                switch self {
//                case .a:    CNCompound.vitaminA
//                case .aiu:  CNCompound.vitaminA
//                case .b1:   CNCompound.vitaminB1
//                case .b2:   CNCompound.vitaminB2
//                case .b3:   CNCompound.vitaminB3
//                case .b4:   CNCompound.vitaminB4
//                case .b5:   CNCompound.vitaminB5
//                case .b6:   CNCompound.vitaminB6
//                case .b7:   CNCompound.vitaminB7
//                case.b9:    CNCompound.vitaminB9
//                case .b12:  CNCompound.vitaminB12
//                case .c:    CNCompound.vitaminC
//                case .d:    CNCompound.vitaminD
//                case .diu:  CNCompound.vitaminD
//                case .e:    CNCompound.vitaminE
//                case .eiu:  CNCompound.vitaminE
//                case .k:    CNCompound.vitaminK
//                }
//            }
//
//            public var fdcID: Int {
//                switch self {
//                case .a:    CNFDCid.vitaminA
//                case .aiu:  CNFDCid.vitaminAiu
//                case .c:    CNFDCid.vitaminC
//                case .d:    CNFDCid.vitaminD
//                case .diu:  CNFDCid.vitaminDiu
//                case .e:    CNFDCid.vitaminE
//                case .eiu:  CNFDCid.vitaminEiu
//                case .k:    CNFDCid.vitaminK
//                case .b1:   CNFDCid.vitaminB1
//                case .b2:   CNFDCid.vitaminB2
//                case .b3:   CNFDCid.vitaminB3
//                case .b4:   CNFDCid.vitaminB4
//                case .b5:   CNFDCid.vitaminB5
//                case .b6:   CNFDCid.vitaminB6
//                case .b7:   CNFDCid.vitaminB7
//                case .b9:   CNFDCid.vitaminB9
//                case .b12:  CNFDCid.vitaminB12
//                }
//            }
//
//            public static let fdcMap: FDCMap = Constants.Nutrients.FDCmap.vitamin
//
//
//            public func DRI(nutrient: Nutrient.Micro.Vitamin, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
//                0
//            }
//
//            public enum A: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
//                case retinol
//                case caroteneBeta
//                case caroteneAlpha
//                case caroteneBetaCis
//                case caroteneBetaTrans
//                case cryptoxanthinBeta
//                case cryptoxanthinAlpha
//
//
//                public var name: String { "" }
//
//                public var display: String { "" }
//
//                public var compound: String { "" }
//
//                public var unit: Units.Mass { .ug }
//
//                public var compareKey: Int8 { self.rawValue }
//
//                public var fdcID: Int {
//                    switch self {
//                    case .retinol: 1105
//                    case .caroteneBeta: 1107
//                    case .caroteneAlpha: 1108
//                    case .cryptoxanthinBeta: 1120
//                    case .caroteneBetaCis: 1159
//                    case .caroteneBetaTrans: 2028
//                    case .cryptoxanthinAlpha: 2032
//                    }
//                }
//
//                public typealias DailyIntakes = VitaminAIntakes
//
//                public static var dailyIntakes: DailyIntakes  = VitaminAIntakes()
//
//            }
//
//            public enum D: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
//                case ergocalciferol
//                case cholecalciferol
//                case hydroxycholecalciferol25
//                case hydroxyergocalciferol25
//
//                public var name: String { "" }
//
//                public var display: String { "" }
//
//                public var compound: String { "" }
//
//                public var unit: Units.Mass { .ug }
//
//                public var compareKey: Int8 { self.rawValue }
//
//                public var fdcID: Int {
//                    switch self {
//                    case .ergocalciferol: 1111
//                    case .cholecalciferol: 1112
//                    case .hydroxycholecalciferol25: 1113
//                    case .hydroxyergocalciferol25: 1115
//                    }
//                }
//
//                public typealias DailyIntakes = VitaminDIntakes
//
//                public static var dailyIntakes: DailyIntakes  = VitaminDIntakes()
//
//            }
//
//            public enum E: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
//                case tocopherolAlpha
//                case tocopherolBeta
//                case tocopherolGamma
//                case tocopherolDelta
//
//                case tocotrienolAlpha
//                case tocotrienolBeta
//                case tocotrienolGamma
//                case tocotrienolDelta
//
//                public var name: String { "" }
//
//                public var display: String { "" }
//
//                public var compound: String { "" }
//
//                public var unit: Units.Mass { .mg }
//
//                public var compareKey: Int8 { rawValue }
//
//                public var fdcID: Int {
//                    switch self {
//                    case .tocopherolAlpha: 1109
//                    case .tocopherolBeta: 1125
//                    case .tocopherolGamma: 1126
//                    case .tocopherolDelta: 1127
//                    case .tocotrienolAlpha: 1128
//                    case .tocotrienolBeta: 1129
//                    case .tocotrienolGamma: 1130
//                    case .tocotrienolDelta: 1131
//                    }
//                }
//
//                public typealias DailyIntakes = VitaminEIntakes
//
//                public static var dailyIntakes: DailyIntakes  = VitaminEIntakes()
//
//            }
//
//            public enum K: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
//                case menaquinone4
//                case dihydrophylloquinone
//                case phylloquinone
//
//                public var name: String { "" }
//
//                public var display: String { "" }
//
//                public var compound: String { "" }
//
//                public var unit: Units.Mass { .ug }
//
//                public var compareKey: Int8 { rawValue }
//
//                public var fdcID: Int {
//                    switch self {
//                    case .menaquinone4: 1183
//                    case .dihydrophylloquinone: 1184
//                    case .phylloquinone: 1185
//                    }
//                }
//
//                public typealias DailyIntakes = VitaminKIntakes
//
//                public static var dailyIntakes: DailyIntakes  = VitaminKIntakes()
//
//            }
//
//        }

//        public enum Mineral: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
//            case Ca
//            case Cl
//            case Cr
//            case Cu
//            case F
//            case I
//            case Fe
//            case Mg
//            case Mn
//            case Mo
//            case P
//            case K
//            case Se
//            case Na
//            case Zn
////            case S
//
//            public var compareKey: Int8 { return self.rawValue }
//
//            public typealias DailyIntakes = MineralIntakes
//
//            public static var dailyIntakes: DailyIntakes {
//                Nutrient.dailyValue.intakes.intakes[.mineral] as! MineralIntakes
//            }
//
//            static var zero: OrderedDictionary<Mineral, Double> {
//                Mineral.zeroOrderedDict.filter{fdcMap.keySet.contains($0.key.fdcID)}
//            }
//
//            static var zeroIntakes: MineralIntakes {
//                MineralIntakes(intakes: Mineral.zero)
//            }
//
//            public var unit: Units.Mass {
//                switch self {
//                case .Cl:
//                    return .gm
//                case .Cr, .Cu, .I, .Mo, .Se:
//                    return .ug
//                default:
//                    return .mg
//
//
//                }
//            }
//
//            public var name: String {
//                switch self {
//                case .Ca:   CNName.calcium
//                case .Cl:   CNName.chloride
//                case .Cr:   CNName.chromium
//                case .Cu:   CNName.copper
//                case .F:    CNName.fluoride
//                case .Fe:   CNName.iron
//                case .Mg:   CNName.magnesium
//                case .Mn:   CNName.manganese
//                case .Mo:   CNName.molybdenum
//                case .P:    CNName.phosphorous
//                case .I:    CNName.iodine
//                case .K:    CNName.potassium
//                case .Se:   CNName.selenium
//                case .Na:   CNName.sodium
//                case .Zn:   CNName.zinc
////                case .S:    CNName.sulfur
//                }
//            }
//
//            public var display: String { name }
//
//            public var compound: String {
//                switch self {
//                case .Ca:   CNCompound.calcium
//                case .Cl:   CNCompound.chloride
//                case .Cr:   CNCompound.chromium
//                case .Cu:   CNCompound.copper
//                case .F:    CNCompound.fluoride
//                case .I:    CNCompound.iodine
//                case .Fe:   CNCompound.iron
//                case .Mg:   CNCompound.magnesium
//                case .Mn:   CNCompound.manganese
//                case .Mo:   CNCompound.molybdenum
//                case .P:    CNCompound.phosphorous
//                case .K:    CNCompound.potassium
//                case .Se:   CNCompound.selenium
//                case .Na:   CNCompound.sodium
//                case .Zn:   CNCompound.zinc
////                case .S:    CNCompound.sulfur
//                }
//            }
//
//            public var fdcID: Int {
//                switch self {
//                case .Ca:   CNFDCid.calcium
//                case .Cl:   CNFDCid.chloride
//                case .Fe:   CNFDCid.iron
//                case .Mg:   CNFDCid.magnesium
//                case .P:    CNFDCid.phosphorous
//                case .K:    CNFDCid.potassium
//                case .Na:   CNFDCid.sodium
//                case .Zn:   CNFDCid.zinc
//                case .Cr:   CNFDCid.chromium
//                case .Cu:   CNFDCid.copper
//                case .F:    CNFDCid.fluoride
//                case .I:    CNFDCid.iodine
//                case .Mn:   CNFDCid.manganese
//                case .Mo:   CNFDCid.molybdenum
//                case .Se:   CNFDCid.selenium
////                case .S:    CNFDCid.sulphur
//                }
//            }
//
//            static let fdcMap: FDCMap = Constants.Nutrients.FDCmap.mineral
//
//            func DRI(nutrient: Nutrient.Micro.Mineral, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
//                0
//            }
//        }

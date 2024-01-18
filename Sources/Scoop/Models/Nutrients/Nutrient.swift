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
    
    public enum Kind: String, EnumTypeOrderedKey {
        case macro = "Macro"
        case vitamin = "Vitamin"
        case mineral = "Mineral"
        case vitaminA = "Vitamin A"
        case vitaminD = "Vitamin D"
        case vitaminE = "Vitamin E"
        case vitaminK = "Vitamin K"
        
        var fdcMap: FDCMap { Nutrient.fdcMapper[self]! }
        
        static func get(from nutrientID: Int) -> Self? {
            allCases.filter {$0.fdcMap.keySet.contains(nutrientID)}.first
        }
        
        static var micros: String {"Micros"}
        static var macros: String {"Macros"}
        
        var chartTitle: (title: String, subtitle: String) {
            switch self {
            case .macro: (Kind.macros, "Carbs, Protein, Fat")
            case .vitamin: (Kind.micros, name)
            case .mineral: (Kind.micros, name)
            case .vitaminA: (Kind.micros, name)
            case .vitaminD: (Kind.micros, name)
            case .vitaminE: (Kind.micros, name)
            case .vitaminK: (Kind.micros, name)
            }
        }
        
        var name: String { self.rawValue }
        
        var navigationTitle: String { self.name + " " + "Profile" }
        
        func toggle() -> Kind {
            switch self {
            case .vitamin: .mineral
            case .mineral: .macro
            case .macro: .vitamin
            default: .macro
            }
        }
    }
    
    static let fdcMap: FDCMap = Dictionary.merge(dicts: [
        Nutrient.Macro.fdcMap,
        Nutrient.Micro.Vitamin.fdcMap,
        Nutrient.Micro.Mineral.fdcMap
    ])
    
    static let fdcMapper: [Nutrient.Kind: FDCMap] = [
        Nutrient.Kind.macro : Nutrient.Macro.fdcMap,
        Nutrient.Kind.vitamin: Nutrient.Micro.Vitamin.fdcMap,
        Nutrient.Kind.mineral: Nutrient.Micro.Mineral.fdcMap
    ]
    
    static var zeroIntakes: NutrientIntakes {
        NutrientIntakes(intakes: [
            .macro : Macro.zeroIntakes,
            .vitamin: Micro.Vitamin.zeroIntakes,
            .mineral: Micro.Mineral.zeroIntakes
        ])
    }
    
    public enum Macro: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
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
        
        static var zero: OrderedDictionary<Macro, Double> {
            zeroOrderedDict.filter { fdcMap.keySet.contains($0.key.fdcID) }
//            zeroOrderedDict
        }
        
        static var zeroIntakes: MacroIntakes {
            MacroIntakes(intakes: Macro.zero)
        }
        
        public var name: String {
            switch self {
            case .energy:       Constants.Nutrients.Name.calories
            case .protein:      Constants.Nutrients.Name.protein
            case .sugar:        Constants.Nutrients.Name.sugar
            case .water:        Constants.Nutrients.Name.water
            case .carbs:        Constants.Nutrients.Name.carbs
            case .fiber:        Constants.Nutrients.Name.fiber
            case .cholesterol:  Constants.Nutrients.Name.cholesterol
            case .linoleicAcid: Constants.Nutrients.Name.linoleicAcid
            case .aLinoleicAcid:Constants.Nutrients.Name.aLinoleicAcid
            case .epa:          Constants.Nutrients.Name.epa
            case .dha:          Constants.Nutrients.Name.dha
            case .fats:         Constants.Nutrients.Name.fats
            case .saturatedFat: Constants.Nutrients.Name.saturatedFat
            case .transFat:     Constants.Nutrients.Name.transFat
            }
        }
        
        public var display: String {
            switch self {
            case .energy:       Constants.Nutrients.Display.calories
            case .sugar:        Constants.Nutrients.Display.sugar
            case .water:        Constants.Nutrients.Display.water
            case .carbs:        Constants.Nutrients.Display.carbs
            case .fiber:        Constants.Nutrients.Display.fiber
            case .fats:         Constants.Nutrients.Display.fats
            case .saturatedFat: Constants.Nutrients.Display.saturatedFat
            case .transFat:     Constants.Nutrients.Display.transFat
            case .cholesterol:  Constants.Nutrients.Display.cholesterol
            case .epa:          Constants.Nutrients.Name.epa
            case .dha:          Constants.Nutrients.Name.dha
            case .linoleicAcid: Constants.Nutrients.Display.linoleicAcid
            case .aLinoleicAcid:Constants.Nutrients.Display.aLinoleicAcid
            case .protein:      Constants.Nutrients.Display.protein
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
            case .energy:       Constants.Nutrients.Compound.calories
            case .protein:      Constants.Nutrients.Compound.protein
            case .sugar:        Constants.Nutrients.Compound.sugar
            case .water:        Constants.Nutrients.Compound.water
            case .carbs:        Constants.Nutrients.Compound.carbs
            case .fiber:        Constants.Nutrients.Compound.fiber
            case .cholesterol:  Constants.Nutrients.Compound.cholesterol
            case .linoleicAcid: Constants.Nutrients.Compound.linoleicAcid
            case .aLinoleicAcid:Constants.Nutrients.Compound.aLinoleicAcid
            case .epa:          Constants.Nutrients.Compound.epa
            case .dha:          Constants.Nutrients.Compound.dha
            case .fats:         Constants.Nutrients.Compound.fats
            case .saturatedFat: Constants.Nutrients.Compound.saturatedFat
            case .transFat:     Constants.Nutrients.Compound.transFat
            }
        }
        
        public var fdcID: Int {
            switch self {
            case .protein: Constants.Nutrients.FDCid.protein
            case .fats: Constants.Nutrients.FDCid.fats
            case .carbs: Constants.Nutrients.FDCid.carbs
            case .energy: Constants.Nutrients.FDCid.energy
            case .sugar: Constants.Nutrients.FDCid.sugar
            case .fiber: Constants.Nutrients.FDCid.fiber
            default: -1
            }
        }
        
        static let fdcMap: FDCMap = Constants.Nutrients.FDCmap.macro
        
        public enum Sugar: Int8, EnumTypeOrderedKey, Glycemic, NutrientType {
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
        
        public enum Carb: Int8, EnumTypeOrderedKey, NutrientType {
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
        
        public enum Fat: Int8, EnumTypeOrderedKey, NutrientType {
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
    }
    
    public typealias Micrograms = Double
    public typealias Milligrams = Double
    
    public enum Micro: CaseIterable {
        public enum Vitamin: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
            case a      //(total: Micrograms, retinol: Micrograms? = nil, betaCarotene: Micrograms? = nil)
            case aiu
            case b1     //(thiamin: Milligrams)
            case b2     //(riboflavin: Milligrams)
            case b3     //(niacin: Milligrams)
            case b4     //(choline: Milligrams)
            case b5     //(pantothenicAcid: Milligrams)
            case b6     //(total: Milligrams, pyridoxal: Milligrams? = nil, pyridoxine: Milligrams? = nil, pyridoxamine: Milligrams? = nil)
            case b7     //(biotin: Micrograms)
            case b9     //(folate: Micrograms)
            case b12    //(cobalamin: Micrograms)
            case c      //(ascorbicAcid: Milligrams)
            case d      //(total: Micrograms, cholecalciferol: Micrograms? = nil, ergocalciferol: Micrograms? = nil)
            case diu
            case e      //(alphaTocopherol: Milligrams)
            case eiu
            case k      //(total: Micrograms, phylloquinone: Micrograms? = nil, menadione: Micrograms? = nil)
            
            public var compareKey: Int8 { return self.rawValue }
            
            public typealias DailyIntakes = VitaminIntakes
            
            public static var dailyIntakes: VitaminIntakes {
                Nutrient.dailyValue.intakes.intakes[.vitamin] as! VitaminIntakes
            }
            
            static var zero: OrderedDictionary<Vitamin, Double> {
                Vitamin.zeroOrderedDict.filter{fdcMap.keySet.contains($0.key.fdcID)}
            }
            
            static var zeroIntakes: VitaminIntakes {
                VitaminIntakes(intakes: Vitamin.zero)
            }
            
            public var unit: Units.Mass {
                switch self {
                case .a, .aiu, .b7, .b9, .b12, .d, .diu, .k:
                    return .ug
                case .b1, .b2, .b3, .b4, .b5, .b6, .c, .e, .eiu:
                    return .mg
                }
            }
            
            public var name: String {
                switch self {
                case .a:    Constants.Nutrients.Name.vitaminA
                case .aiu:  Constants.Nutrients.Name.vitaminAiu
                case .b1:   Constants.Nutrients.Name.vitaminB1
                case .b2:   Constants.Nutrients.Name.vitaminB2
                case .b3:   Constants.Nutrients.Name.vitaminB3
                case .b4:   Constants.Nutrients.Name.vitaminB4
                case .b5:   Constants.Nutrients.Name.vitaminB5
                case .b6:   Constants.Nutrients.Name.vitaminB6
                case .b7:   Constants.Nutrients.Name.vitaminB7
                case.b9:    Constants.Nutrients.Name.vitaminB9
                case .b12:  Constants.Nutrients.Name.vitaminB12
                case .c:    Constants.Nutrients.Name.vitaminC
                case .d:    Constants.Nutrients.Name.vitaminD
                case .diu:  Constants.Nutrients.Name.vitaminDiu
                case .e:    Constants.Nutrients.Name.vitaminE
                case .eiu:  Constants.Nutrients.Name.vitaminEiu
                case .k:    Constants.Nutrients.Name.vitaminK
                }
            }
            
            public var display: String { name }
            
            public var compound: String {
                switch self {
                case .a:    Constants.Nutrients.Compound.vitaminA
                case .aiu:  Constants.Nutrients.Compound.vitaminA
                case .b1:   Constants.Nutrients.Compound.vitaminB1
                case .b2:   Constants.Nutrients.Compound.vitaminB2
                case .b3:   Constants.Nutrients.Compound.vitaminB3
                case .b4:   Constants.Nutrients.Compound.vitaminB4
                case .b5:   Constants.Nutrients.Compound.vitaminB5
                case .b6:   Constants.Nutrients.Compound.vitaminB6
                case .b7:   Constants.Nutrients.Compound.vitaminB7
                case.b9:    Constants.Nutrients.Compound.vitaminB9
                case .b12:  Constants.Nutrients.Compound.vitaminB12
                case .c:    Constants.Nutrients.Compound.vitaminC
                case .d:    Constants.Nutrients.Compound.vitaminD
                case .diu:  Constants.Nutrients.Compound.vitaminD
                case .e:    Constants.Nutrients.Compound.vitaminE
                case .eiu:  Constants.Nutrients.Compound.vitaminE
                case .k:    Constants.Nutrients.Compound.vitaminK
                }
            }
            
            public var fdcID: Int {
                switch self {
                case .a:    Constants.Nutrients.FDCid.vitaminA
                case .aiu:  Constants.Nutrients.FDCid.vitaminAiu
                case .c:    Constants.Nutrients.FDCid.vitaminC
                case .d:    Constants.Nutrients.FDCid.vitaminD
                case .diu:  Constants.Nutrients.FDCid.vitaminDiu
                case .e:    Constants.Nutrients.FDCid.vitaminE
                case .eiu:  Constants.Nutrients.FDCid.vitaminEiu
                case .k:    Constants.Nutrients.FDCid.vitaminK
                case .b1:   Constants.Nutrients.FDCid.vitaminB1
                case .b2:   Constants.Nutrients.FDCid.vitaminB2
                case .b3:   Constants.Nutrients.FDCid.vitaminB3
                case .b4:   Constants.Nutrients.FDCid.vitaminB4
                case .b5:   Constants.Nutrients.FDCid.vitaminB5
                case .b6:   Constants.Nutrients.FDCid.vitaminB6
                case .b7:   Constants.Nutrients.FDCid.vitaminB7
                case .b9:   Constants.Nutrients.FDCid.vitaminB9
                case .b12:  Constants.Nutrients.FDCid.vitaminB12
                }
            }
            
            static let fdcMap: FDCMap = Constants.Nutrients.FDCmap.vitamin
            
            
            func DRI(nutrient: Nutrient.Micro.Vitamin, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
                0
            }
            
            public enum A: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
                case retinol
                case caroteneBeta
                case caroteneAlpha
                case caroteneBetaCis
                case caroteneBetaTrans
                case cryptoxanthinBeta
                case cryptoxanthinAlpha
                
                
                public var name: String { "" }
                
                public var display: String { "" }
                
                public var compound: String { "" }
                
                public var unit: Units.Mass { .ug }
                
                public var compareKey: Int8 { self.rawValue }
                
                public var fdcID: Int {
                    switch self {
                    case .retinol: 1105
                    case .caroteneBeta: 1107
                    case .caroteneAlpha: 1108
                    case .cryptoxanthinBeta: 1120
                    case .caroteneBetaCis: 1159
                    case .caroteneBetaTrans: 2028
                    case .cryptoxanthinAlpha: 2032
                    }
                }
                
                public typealias DailyIntakes = VitaminAIntakes
                
                public static var dailyIntakes: DailyIntakes  = VitaminAIntakes()
                
            }
            
            public enum D: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
                case ergocalciferol
                case cholecalciferol
                case hydroxycholecalciferol25
                case hydroxyergocalciferol25
                
                public var name: String { "" }
                
                public var display: String { "" }
                
                public var compound: String { "" }
                
                public var unit: Units.Mass { .ug }
                
                public var compareKey: Int8 { self.rawValue }
                
                public var fdcID: Int {
                    switch self {
                    case .ergocalciferol: 1111
                    case .cholecalciferol: 1112
                    case .hydroxycholecalciferol25: 1113
                    case .hydroxyergocalciferol25: 1115
                    }
                }
                
                public typealias DailyIntakes = VitaminDIntakes
                
                public static var dailyIntakes: DailyIntakes  = VitaminDIntakes()
                
            }
            
            public enum E: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
                case tocopherolAlpha
                case tocopherolBeta
                case tocopherolGamma
                case tocopherolDelta
                
                case tocotrienolAlpha
                case tocotrienolBeta
                case tocotrienolGamma
                case tocotrienolDelta
                
                public var name: String { "" }
                
                public var display: String { "" }
                
                public var compound: String { "" }
                
                public var unit: Units.Mass { .mg }
                
                public var compareKey: Int8 { rawValue }
                
                public var fdcID: Int {
                    switch self {
                    case .tocopherolAlpha: 1109
                    case .tocopherolBeta: 1125
                    case .tocopherolGamma: 1126
                    case .tocopherolDelta: 1127
                    case .tocotrienolAlpha: 1128
                    case .tocotrienolBeta: 1129
                    case .tocotrienolGamma: 1130
                    case .tocotrienolDelta: 1131
                    }
                }
                
                public typealias DailyIntakes = VitaminEIntakes
                
                public static var dailyIntakes: DailyIntakes  = VitaminEIntakes()
                
            }
            
            public enum K: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
                case menaquinone4
                case dihydrophylloquinone
                case phylloquinone
                
                public var name: String { "" }
                
                public var display: String { "" }
                
                public var compound: String { "" }
                
                public var unit: Units.Mass { .ug }
                
                public var compareKey: Int8 { rawValue }
                
                public var fdcID: Int {
                    switch self {
                    case .menaquinone4: 1183
                    case .dihydrophylloquinone: 1184
                    case .phylloquinone: 1185
                    }
                }
                
                public typealias DailyIntakes = VitaminKIntakes
                
                public static var dailyIntakes: DailyIntakes  = VitaminKIntakes()
                
            }
            
        }
        
        public enum Mineral: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
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
            
            static var zero: OrderedDictionary<Mineral, Double> {
                Mineral.zeroOrderedDict.filter{fdcMap.keySet.contains($0.key.fdcID)}
            }
            
            static var zeroIntakes: MineralIntakes {
                MineralIntakes(intakes: Mineral.zero)
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
                case .Ca:   Constants.Nutrients.Name.calcium
                case .Cl:   Constants.Nutrients.Name.chloride
                case .Cr:   Constants.Nutrients.Name.chromium
                case .Cu:   Constants.Nutrients.Name.copper
                case .F:    Constants.Nutrients.Name.fluoride
                case .Fe:   Constants.Nutrients.Name.iron
                case .Mg:   Constants.Nutrients.Name.magnesium
                case .Mn:   Constants.Nutrients.Name.manganese
                case .Mo:   Constants.Nutrients.Name.molybdenum
                case .P:    Constants.Nutrients.Name.phosphorous
                case .I:    Constants.Nutrients.Name.iodine
                case .K:    Constants.Nutrients.Name.potassium
                case .Se:   Constants.Nutrients.Name.selenium
                case .Na:   Constants.Nutrients.Name.sodium
                case .Zn:   Constants.Nutrients.Name.zinc
//                case .S:    Constants.Nutrients.Name.sulfur
                }
            }
            
            public var display: String { name }
            
            public var compound: String {
                switch self {
                case .Ca:   Constants.Nutrients.Compound.calcium
                case .Cl:   Constants.Nutrients.Compound.chloride
                case .Cr:   Constants.Nutrients.Compound.chromium
                case .Cu:   Constants.Nutrients.Compound.copper
                case .F:    Constants.Nutrients.Compound.fluoride
                case .I:    Constants.Nutrients.Compound.iodine
                case .Fe:   Constants.Nutrients.Compound.iron
                case .Mg:   Constants.Nutrients.Compound.magnesium
                case .Mn:   Constants.Nutrients.Compound.manganese
                case .Mo:   Constants.Nutrients.Compound.molybdenum
                case .P:    Constants.Nutrients.Compound.phosphorous
                case .K:    Constants.Nutrients.Compound.potassium
                case .Se:   Constants.Nutrients.Compound.selenium
                case .Na:   Constants.Nutrients.Compound.sodium
                case .Zn:   Constants.Nutrients.Compound.zinc
//                case .S:    Constants.Nutrients.Compound.sulfur
                }
            }
            
            public var fdcID: Int {
                switch self {
                case .Ca:   Constants.Nutrients.FDCid.calcium
                case .Cl:   Constants.Nutrients.FDCid.chloride
                case .Fe:   Constants.Nutrients.FDCid.iron
                case .Mg:   Constants.Nutrients.FDCid.magnesium
                case .P:    Constants.Nutrients.FDCid.phosphorous
                case .K:    Constants.Nutrients.FDCid.potassium
                case .Na:   Constants.Nutrients.FDCid.sodium
                case .Zn:   Constants.Nutrients.FDCid.zinc
                case .Cr:   Constants.Nutrients.FDCid.chromium
                case .Cu:   Constants.Nutrients.FDCid.copper
                case .F:    Constants.Nutrients.FDCid.fluoride
                case .I:    Constants.Nutrients.FDCid.iodine
                case .Mn:   Constants.Nutrients.FDCid.manganese
                case .Mo:   Constants.Nutrients.FDCid.molybdenum
                case .Se:   Constants.Nutrients.FDCid.selenium
//                case .S:    Constants.Nutrients.FDCid.sulphur
                }
            }
            
            static let fdcMap: FDCMap = Constants.Nutrients.FDCmap.mineral
            
            func DRI(nutrient: Nutrient.Micro.Mineral, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
                0
            }
        }
    }
    
    static var required: [any NutrientType] {
        Micro.Vitamin.allCases + Micro.Mineral.allCases.filter{$0 != .Na} + [Macro.energy, Macro.fiber, Macro.protein, Macro.fats, Macro.water, Macro.epa, Macro.dha]
    }
    
    static var restricted: [any NutrientType] {
        [Macro.sugar, Macro.transFat, Macro.cholesterol, Macro.saturatedFat, Macro.fats, Micro.Mineral.Na]
    }
}


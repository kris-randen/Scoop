//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation
import OrderedCollections

@available(iOS 15.0, *)
public enum NutrientMicroVitamin: Int8, EnumTypeOrderedKey, NutrientType, FDCidAble {
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
    
    static var zero: OrderedDictionary<NutrientMicroVitamin, Double> {
        NutrientMicroVitamin.zeroOrderedDict.filter{fdcMap.keySet.contains($0.key.fdcID)}
    }
    
    static var zeroIntakes: VitaminIntakes {
        VitaminIntakes(intakes: NutrientMicroVitamin.zero)
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
        case .a:    CNName.vitaminA
        case .aiu:  CNName.vitaminAiu
        case .b1:   CNName.vitaminB1
        case .b2:   CNName.vitaminB2
        case .b3:   CNName.vitaminB3
        case .b4:   CNName.vitaminB4
        case .b5:   CNName.vitaminB5
        case .b6:   CNName.vitaminB6
        case .b7:   CNName.vitaminB7
        case.b9:    CNName.vitaminB9
        case .b12:  CNName.vitaminB12
        case .c:    CNName.vitaminC
        case .d:    CNName.vitaminD
        case .diu:  CNName.vitaminDiu
        case .e:    CNName.vitaminE
        case .eiu:  CNName.vitaminEiu
        case .k:    CNName.vitaminK
        }
    }
    
    public var display: String { name }
    
    public var compound: String {
        switch self {
        case .a:    CNCompound.vitaminA
        case .aiu:  CNCompound.vitaminA
        case .b1:   CNCompound.vitaminB1
        case .b2:   CNCompound.vitaminB2
        case .b3:   CNCompound.vitaminB3
        case .b4:   CNCompound.vitaminB4
        case .b5:   CNCompound.vitaminB5
        case .b6:   CNCompound.vitaminB6
        case .b7:   CNCompound.vitaminB7
        case.b9:    CNCompound.vitaminB9
        case .b12:  CNCompound.vitaminB12
        case .c:    CNCompound.vitaminC
        case .d:    CNCompound.vitaminD
        case .diu:  CNCompound.vitaminD
        case .e:    CNCompound.vitaminE
        case .eiu:  CNCompound.vitaminE
        case .k:    CNCompound.vitaminK
        }
    }
    
    public var fdcID: Int {
        switch self {
        case .a:    CNFDCid.vitaminA
        case .aiu:  CNFDCid.vitaminAiu
        case .c:    CNFDCid.vitaminC
        case .d:    CNFDCid.vitaminD
        case .diu:  CNFDCid.vitaminDiu
        case .e:    CNFDCid.vitaminE
        case .eiu:  CNFDCid.vitaminEiu
        case .k:    CNFDCid.vitaminK
        case .b1:   CNFDCid.vitaminB1
        case .b2:   CNFDCid.vitaminB2
        case .b3:   CNFDCid.vitaminB3
        case .b4:   CNFDCid.vitaminB4
        case .b5:   CNFDCid.vitaminB5
        case .b6:   CNFDCid.vitaminB6
        case .b7:   CNFDCid.vitaminB7
        case .b9:   CNFDCid.vitaminB9
        case .b12:  CNFDCid.vitaminB12
        }
    }
    
    public static let fdcMap: Nutrient.FDCMap = Constants.Nutrients.FDCmap.vitamin
    
    
    public func DRI(nutrient: Nutrient.Micro.Vitamin, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
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

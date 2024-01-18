//
//  Unitss.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/23/23.
//

//
//  Units.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

public protocol ExponentInterconvertible: Convertible {
    func conversionExponent(to: Self) -> Int8
}

public extension ExponentInterconvertible {
    func conversion(to: Self) -> Double {
        pow(10, Double(conversionExponent(to: to)))
    }
}

public protocol Convertible {
    func conversion(to: Self) -> Double
}

public protocol UnitType: Convertible, Codable, Hashable {
    var description: String { get }
}

public extension UnitType {
    var name: String { description }
}

public protocol ExponentUnitType: UnitType, ExponentInterconvertible {}

public protocol NutrientUnitType: ExponentUnitType {}

public protocol NutrientUnitEnumOrderedKey: NutrientUnitType, EnumTypeOrderedKey {}

public protocol UnitEnumOrderedKey: UnitType, EnumTypeOrderedKey {}

public extension NutrientUnitEnumOrderedKey where RawValue == Int8 {
    func conversionExponent(to: Self) -> Int8 {
        self.rawValue - to.rawValue
    }
}

@available(iOS 15.0, *)
public enum Units {
    public enum Kind: Int8, EnumTypeOrderedKey {
        case energy
        case mass
        case length
        case volume
        
        public var fdcUnits: Set<String> {
            switch self {
            case .energy:   Constants.FDCunits.energy
            case .mass:     Constants.FDCunits.mass
            case .length:   Constants.FDCunits.length
            case .volume:   Constants.FDCunits.volume
            }
        }
        
        public static func get(from fdcUnit: String) -> Self? {
            allCases.filter {$0.fdcUnits.contains(fdcUnit.lowercased())}.first
        }
    }
    
    public static let table: [String: any NutrientUnitType] = [
        "g": Units.Mass.gm,
        "mg": Units.Mass.mg,
        "ug": Units.Mass.ug,
        "kg": Units.Mass.kg,
        "iu": Units.Mass.mg,
        "kcal": Units.Energy.kcal
    ]
    
    public enum Energy: Int8, NutrientUnitEnumOrderedKey {
        case cal = -3
        case kcal = 0
        
        public static var table: [String: Units.Energy] = [
            "cal" : .cal,
            "kcal": .kcal
        ]
        
        public var description: String {
            switch self {
            case .cal: Constants.Units.Energy.cal
            case .kcal: Constants.Units.Energy.kcal
            }
        }
    }
    
    public enum Mass: Int8, NutrientUnitEnumOrderedKey {
        case pg = -12
        case ng = -9
        case ug = -6
        case mg = -3
        case gm = 0
        case kg = 3
        
        public static var table: [String: Units.Mass] = [
            "ug"    : .ug,
            "mg"    : .mg,
            "g"     : .gm,
            "kg"    : .kg,
            "gm"    :.gm,
            "grm"   : .gm
        ]
        
        public var description: String {
            switch self {
            case .pg: Constants.Units.Mass.pg
            case .ng: Constants.Units.Mass.ng
            case .ug: Constants.Units.Mass.ug
            case .mg: Constants.Units.Mass.mg
            case .gm: Constants.Units.Mass.gm
            case .kg: Constants.Units.Mass.kg
            }
        }
        
        public var badgeName: String {
            name.capitalized
        }
        
        public static var display: [Units.Mass] {
            [.gm, .kg]
        }
        
        public func toggle() -> Units.Mass {
            switch self {
            case .gm: .kg
            case .kg: .gm
            default: .gm
            }
        }
    }
    
    public enum IU: Int, UnitEnumOrderedKey {
        case vitaminA
        case retinol
        case dietbetac
        case suppbetac
        case alphcarot
        case betacrypt
        case vitaminD
        case vitaEnat
        case vitaEsyn
        
        public var description: String {
            return ""
        }
        
        public func conversion(to: Units.IU) -> Double {
            return 0
        }

        public func conversion(to: Units.Mass) -> Double {
            switch self {
            case .vitaminA, .retinol, .suppbetac:
                switch to {
                case .ng:
                    return 300
                default:
                    return conversion(to: .ng) / to.conversion(to: .ng)
                }
            case .dietbetac:
                switch to {
                case .ng:
                    return 50
                default:
                    return conversion(to: .ng) / to.conversion(to: .ng)
                }
            case .alphcarot, .betacrypt:
                switch to {
                case .ng:
                    return 25
                default:
                    return conversion(to: .ng) / to.conversion(to: .ng)
                }
            case .vitaminD:
                switch to {
                case .ng:
                    return 25
                default:
                    return conversion(to: .ng) / to.conversion(to: .ng)
                }
            case .vitaEnat:
                switch to {
                case .ug:
                    return 670
                default:
                    return conversion(to: .ug) / to.conversion(to: .ug)
                }
            case .vitaEsyn:
                switch to {
                case .ug:
                    return 450
                default:
                    return conversion(to: .ug) / to.conversion(to: .ug)
                }
            }
        }
    }
    
    public enum Length: Int8, NutrientUnitEnumOrderedKey {
        case pm = -10
        case ag = -8
        case nm = -7
        case um = -4
        case mm = -1
        case cm = 0
        case m = 2
        case km = 5
        
        public static var table: [String: Units.Length] = [
            "mm"    : .mm,
            "m"     : .m,
            "km"    : .km
        ]
        
        public var description: String {
            switch self {
            case .pm: Constants.Units.Length.pm
            case .ag: Constants.Units.Length.ag
            case .nm: Constants.Units.Length.nm
            case .um: Constants.Units.Length.um
            case .mm: Constants.Units.Length.mm
            case .cm: Constants.Units.Length.cm
            case .m:  Constants.Units.Length.m
            case .km: Constants.Units.Length.km
            }
        }
    }
    
    public enum Volume: Int8, NutrientUnitEnumOrderedKey {
        case pl = -9
        case nl = -6
        case ul = -3
        case ml = 0
        case cl = 1
        case dl = 2
        case l = 3
        case kl = 6
        
        public static var table: [String: Units.Volume] = [
            "ml" : .ml,
            "dl" : .dl,
            "l"  : .l
        ]
        
        public var description: String {
            switch self {
            case .pl: Constants.Units.Volume.pl
            case .nl: Constants.Units.Volume.nl
            case .ul: Constants.Units.Volume.ul
            case .ml: Constants.Units.Volume.ml
            case .cl: Constants.Units.Volume.cl
            case .dl: Constants.Units.Volume.dl
            case .l:  Constants.Units.Volume.l
            case .kl: Constants.Units.Volume.kl
            }
        }
        
        public static var display: [Units.Volume] {
            [.ml, .l]
        }
    }
    
    public enum Ratio: ExponentInterconvertible, Codable, Hashable {

        case density(mass: Mass, volume: Volume)
        
        var logBase: Int8 {
            switch self {
            case .density(let mass, let volume):
                return mass.rawValue - volume.rawValue
            }
        }
        
        public func conversionExponent(to: Units.Ratio) -> Int8 {
            self.logBase - to.logBase
        }
    }
}

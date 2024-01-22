//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation


@available(iOS 15.0, *)
public extension Units {
    typealias IU = IUUnit
}

@available(iOS 15.0, *)
public enum IUUnit: Int, UnitEnumOrderedKey {
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

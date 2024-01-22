//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

@available(iOS 15.0, *)
public extension Units {
    typealias Volume = VolumeUnit
}

@available(iOS 15.0, *)
public enum VolumeUnit: Int8, NutrientUnitEnumOrderedKey {
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

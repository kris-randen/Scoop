//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

@available(iOS 15.0, *)
public extension Units {
    typealias Length = LengthUnit
}


@available(iOS 15.0, *)
public enum LengthUnit: Int8, NutrientUnitEnumOrderedKey {
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

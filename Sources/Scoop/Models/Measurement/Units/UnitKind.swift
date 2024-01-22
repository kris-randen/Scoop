//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation


@available(iOS 15.0, *)
public extension Units {
    typealias Kind = UnitKind
}

@available(iOS 15.0, *)
public enum UnitKind: Int8, EnumTypeOrderedKey {
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

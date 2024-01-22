//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation


@available(iOS 15.0, *)
public extension Serving {
    typealias Kind = ServingKind
}

public enum ServingKind {
    case gm100, kcal2000, list
    
    var name: String {
        switch self {
        case .gm100: "100 gm"
        case .kcal2000: "2000 Cal"
        case .list: "List"
        }
    }
    
    func toggle() -> ServingKind {
        switch self {
        case .gm100:
            return .kcal2000
        case .kcal2000:
            return .gm100
        case .list:
            return .list
        }
    }
}

//
//  Serving.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/16/23.
//

import Foundation

@available(iOS 15.0, *)
public struct Serving {
    public enum Kind {
        case gm100, kcal2000, list
        
        var name: String {
            switch self {
            case .gm100: "100 gm"
            case .kcal2000: "2000 Cal"
            case .list: "List"
            }
        }
        
        func toggle() -> Kind {
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
    
    var value: Double = 100
    var unit: Units.Mass = .gm
    
    public init(value: Double = 100, unit: Units.Mass = .gm) {
        self.value = value
        self.unit = unit
    }
    
    public struct Volume: ConvertibleMeasure {
        public typealias Unit = Units.Volume
        public var unit: Unit = .ml
        public var value: Double = 1000
        
        public init(unit: Unit, value: Double) {
            self.unit = unit
            self.value = value
        }
    }

    public struct Mass: ConvertibleMeasure {
        public typealias Unit = Units.Mass
        public var unit: Unit = .gm
        public var value: Double = 100
        
        public init(unit: Unit, value: Double) {
            self.unit = unit
            self.value = value
        }
    }
    
    static func factor(from lhs: Serving, to rhs: Serving) -> Double {
        (rhs.value / lhs.value) * (rhs.unit.conversion(to: lhs.unit))
    }
    
    func factor(to rhs: Serving) -> Double {
        Serving.factor(from: self, to: rhs)
    }
    
    static var mapper: [Units.Kind : Serving] {
        [
            .mass: Serving()
        ]
    }
    
    static func get(from food: FDCFood) -> Serving {
        print("The food is:\n\(food)")
        guard food.servingSizeUnit != nil else { return Serving() }
        var serving = mapper[Units.Kind.get(from: food.servingSizeUnit!.lowercased())!]!
        serving.value = food.servingSize!
        return serving
    }
}

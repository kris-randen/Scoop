//
//  Serving.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/16/23.
//

import Foundation

/// Represents a measurable value with a unit, typically used for nutrient content or ingredient measurements.
/// - Conforms To: `ConvertibleMeasure` public protocol for quantifiable elements that are interconvertible to different units
/// - Example Usage: `let sugarContent = Value(value: 5.0, unit: .grams)`
/// - Conforming Types: Used as a base structure for representing measurable quantities in various contexts.


@available(iOS 15.0, *)
public struct Serving {
    static var mapper: [Units.Kind : Serving.Mass] {
        [
            .mass: Serving.Mass()
        ]
    }
    
    static func get(from food: FDCFood) -> Serving.Mass {
        print("The food is:\n\(food)")
        guard food.servingSizeUnit != nil else { return Serving.Mass() }
        var serving = mapper[Units.Kind.get(from: food.servingSizeUnit!.lowercased())!]!
        serving.value = food.servingSize!
        return serving
    }
}

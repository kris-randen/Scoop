//
//  NQICalculator.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/19/23.
//

import Foundation

@available(iOS 15.0, *)
public struct FoodScoring {
    public typealias Score = Double
    public enum Types {
        case nqi
        case nmb
    }
    
    public struct NQI {
        var profile: NutrientProfile
        var total: Score = 0
        var macros = [Nutrient.Macro: Score]()
        var vitamins = [Nutrient.Micro.Vitamin: Score]()
        var minerals = [Nutrient.Micro.Mineral: Score]()
        
        var food: String { profile.food }
        var serving: String { profile.servingDescription }
        var factor: Double { profile.nqiFactor }
        
        
        private func requiredAllowed(_ nutrient: any NutrientType) -> String {
            nutrient.required ? "required" : "allowed"
        }
        
        private func aNotA(_ nutrient: any NutrientType) -> String {
            nutrient.required ? "a" : "not a"
        }
        
        private func genericReason(for nutrient: any NutrientType) -> String {
            let (name, unit, daily) = nutrient.details
            let requiredReason = "\(name) is \(aNotA(nutrient)) required nutrient."
            let dailyReason = "The daily \(requiredAllowed(nutrient)) value is \(daily) \(unit)"
            return "\(requiredReason)\n\(dailyReason)"
        }
        
        private func scaled(value: Double, daily: Double, factor: Double) -> (value: Double, scale: Double) {
            (
                factor * value,
                factor * value / daily
            )
        }
        
        private func scaledReason(for food: String, nutrient: any NutrientType, value: Double, daily: Double, factor: Double) -> String {
            let (scaled, scale) = scaled(value: value, daily: daily, factor: factor)
            return "If you had \(Energy.dailyValue) of \(food) you would get \(scaled) \(nutrient.unit.name) which is \(scale)X of daily \(requiredAllowed(nutrient)) value"
        }
        
        private func valueReason(for food: String, value: Double, unit: String, nutrient: String, serving: String) -> String {
            "\(food) provides \(value) \(unit) of \(nutrient) in a \(serving) serving"
        }
        
        private func combineReasons(generic: String, value: String, scale: String) -> String {
            "\(generic)\n\(value)\n\(scale)"
        }
        
        func reason(for macro: Nutrient.Macro) -> String {
            let (
                (nutrient, unit, daily),
                 value
            ) = (
                    macro.details,
                    profile.value(for: macro)
                )
            let genericReason = genericReason(for: macro)
            let valueReason = valueReason(for: food, value: value, unit: unit, nutrient: nutrient, serving: serving)
            let scaleReason = scaledReason(for: food, nutrient: macro, value: value, daily: daily, factor: factor)
            return combineReasons(generic: genericReason, value: valueReason, scale: scaleReason)
        }
        
        func calculate(for profile: NutrientProfile) {
            
        }
        
        private func nqi(for profile: NutrientProfile) {}
    }
}

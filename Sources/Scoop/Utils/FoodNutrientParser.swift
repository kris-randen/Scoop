//
//  FoodNutrientParser.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/16/23.
//

import Foundation

@available(iOS 15.0, *)
public struct FoodNutrientParser {
    public static func parseFoods(from data: Data) -> [FDCFood]? {
        do {
            let decodedData = try JSONDecoder().decode(FDCFoodDataResponse.self, from: data)
            return decodedData.foods
        } catch {
            print("Error parsing foods from Data: \(error)")
            return nil
        }
    }
    
    public static func select(from foods: [FDCFood]) -> FDCFood? { foods.first }
    
    public static func extract(from food: FDCFood) -> Serving.Mass {
        Serving.get(from: food)
    }
    
    public static func extract(from food: FDCFood) -> NutrientIntakes {
        FDCUnits.nutrientIntakesAll(from: food.foodNutrients)
    }
    
    public static func extractValueProfile(from food: FDCFood) -> NutrientProfile {
        NutrientProfile(
            intakes: extract(from: food),
            description: food.description,
            type: .value,
            serving: extract(from: food),
            energy: food.energy
        )
    }
    
    public static func energy(from food: FDCFood) -> Energy {
        food.energy
    }
    
    public static func extract(from food: FDCFood) -> NutrientProfile {
        extractValueProfile(from: food)
    }
    
    public static func extractScaledByDV(from food: FDCFood) -> NutrientProfile {
        extractValueProfile(from: food).scaledByDV()
    }
    
    public static func extract(from data: Data) -> NutrientProfile {
        extract(from: select(from: parseFoods(from: data)!)!)
    }
}

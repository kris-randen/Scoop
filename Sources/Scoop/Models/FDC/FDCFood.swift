//
//  FDCFood.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/12/23.
//

import Foundation

@available(iOS 15.0, *)
public struct FDCFood: Decodable {
    public let fdcId: Int
    public let foodNutrients: [FDCfoodNutrientIntake]
    public let servingSize: Double?
    public let servingSizeUnit: String?
    public let description: String
    
    public init(fdcId: Int, foodNutrients: [FDCfoodNutrientIntake], servingSize: Double?, servingSizeUnit: String?, description: String) {
        self.fdcId = fdcId
        self.foodNutrients = foodNutrients
        self.servingSize = servingSize
        self.servingSizeUnit = servingSizeUnit
        self.description = description
    }
    
    public var energy: Energy {
        let foodNutrient = foodNutrients.first { $0.nutrientName.lowercased() == "energy" }!
        return Energy(value: foodNutrient.value, unit: .kcal)
    }
}

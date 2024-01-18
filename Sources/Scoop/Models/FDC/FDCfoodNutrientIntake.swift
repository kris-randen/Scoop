//
//  FDCNutrientIntake.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/12/23.
//

import Foundation

@available(iOS 15.0, *)
public struct FDCfoodNutrientIntake: Decodable {
    public let nutrientId: Int
    public let nutrientNumber: String
    public let nutrientName: String
    public let value: Double
    public let unitName: String
    
    public init(nutrientId: Int, nutrientNumber: String, nutrientName: String, value: Double, unitName: String) {
        self.nutrientId = nutrientId
        self.nutrientNumber = nutrientNumber
        self.nutrientName = nutrientName
        self.value = value
        self.unitName = unitName
    }
    
    public var foodNutrient: FDCfoodNutrient {
        return FDCfoodNutrient(nutrientId: nutrientId, nutrientNumber: nutrientNumber, nutrientName: nutrientName)
    }
    public var nutrient: any NutrientType {
        return foodNutrient.nutrient
    }
    public var unit: any NutrientUnitType {
        return Units.table[unitName.lowercased()]!
    }
}

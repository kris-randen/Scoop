//
//  FDCfoodNutrient.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

@available(iOS 15.0, *)
public struct FDCfoodNutrient: Decodable {
    public let nutrientId: Int
    public let nutrientNumber: String
    public let nutrientName: String
    
    public init(nutrientId: Int, nutrientNumber: String, nutrientName: String) {
        self.nutrientId = nutrientId
        self.nutrientNumber = nutrientNumber
        self.nutrientName = nutrientName
    }
    
    public var nutrient: any NutrientType {
        return Nutrient.fdcMap[nutrientId]!
    }
}

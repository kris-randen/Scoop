//
//  File.swift
//  
//
//  Created by Krishnaswami Rajendren on 1/22/24.
//

import Foundation

public enum NutrientMicro: CaseIterable {}

@available(iOS 15.0, *)
public extension Nutrient {
    typealias Micro = NutrientMicro
}

@available(iOS 15.0, *)
public extension Nutrient.Micro {
    typealias Vitamin = NutrientMicroVitamin
    typealias Mineral = NutrientMicroMineral
}

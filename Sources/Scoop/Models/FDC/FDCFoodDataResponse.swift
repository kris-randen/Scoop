//
//  FDCFood.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/12/23.
//

import Foundation

@available(iOS 15.0, *)
public struct FDCFoodDataResponse: Decodable {
    public let foods: [FDCFood]
}

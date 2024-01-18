//
//  GroceryItem.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/9/24.
//

import Foundation

@available(iOS 15.0, *)
public typealias GroceryItems = [GroceryItem]

@available(iOS 15.0, *)
public struct GroceryItem: Identifiable, Codable {
    public var id: UUID
    var name: String
    var quantity: Double
    var unit: Units.Mass
    
    public init(id: UUID = UUID(), name: String, quantity: Double, unit: Units.Mass = .gm) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}

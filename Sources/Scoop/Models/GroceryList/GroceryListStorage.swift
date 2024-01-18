//
//  GroceryListStorage.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/9/24.
//

import Foundation

@available(iOS 15.0, *)
public class GroceryListStorage {
    private let defaults: UserDefaults
    private let key = "GroceryList"
    
    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    public func save(_ list: GroceryItems) {
        if let encoded = try? JSONEncoder().encode(list) {
            defaults.setValue(encoded, forKey: key)
        }
    }
    
    public func load() -> GroceryItems {
        guard let data = defaults.data(forKey: key),
              let list = try? JSONDecoder().decode(GroceryItems.self, from: data) else {
            return []
        }
        return list
    }
}

//
//  GroceryList.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/9/24.
//

import Foundation

@available(iOS 15.0, *)
public actor GroceryList {
    private var items: GroceryItems
    
    public init(items: GroceryItems = []) {
        if let savedItems = UserDefaults.standard.data(forKey: "groceryItems"),
           let decodedItems = try? JSONDecoder().decode(GroceryItems.self, from: savedItems) {
            self.items = decodedItems
        } else {
            self.items = items
        }
    }
    
    private func save() async {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.setValue(encodedData, forKey: "groceryItems")
        }
    }
    
    public func add(_ item: GroceryItem) async {
        items.append(item)
        await save()
    }
    
    public func remove(_ id: UUID) async {
        items.removeAll {$0.id == id}
        await save()
    }
    
    public func update(_ item: GroceryItem) async {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index] = item
        await save()
    }
    
    public func all() async -> [GroceryItem] {
        items
    }
}

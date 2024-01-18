//
//  GroceryListViewModel.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/9/24.
//

import Foundation

@available(iOS 15.0, *)
@MainActor
class GroceryListViewModel: ObservableObject {
    @Published private(set) var items: GroceryItems = []
    private let list: GroceryList
    
    init(groceryList: GroceryList = GroceryList()) {
        self.list = groceryList
        load()
    }
    
    func load() {
        Task {
            self.items = await list.all()
        }
    }
    
    func add(name: String, quantity: Double, unit: Units.Mass) {
        let item = GroceryItem(name: name, quantity: quantity, unit: unit)
        Task {
            await list.add(item)
            load()
        }
    }
    
    func add(_ item: GroceryItem) {
        Task {
            await list.add(item)
            load()
        }
    }
    
    func remove(_ id: UUID) {
        Task {
            await list.remove(id)
            load()
        }
    }
    
    func update(_ item: GroceryItem) {
        Task {
            await list.update(item)
            load()
        }
    }
    
    func save() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: "groceryItems")
        }
    }
    
}

//
//  AddGroceryItemView.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/11/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct AddGroceryItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = GroceryListViewModel()
    @State var item: String = "Beef Liver Raw"
    @State var quantity: Double = 1.25
    @State var unit: Units.Mass = .kg
    
    public var body: some View {
        VStack {
            AddGroceryItemCellView(item: $item, quantity: $quantity, unit: $unit)
                .padding(.bottom)
            Button {
                saveItem()
                presentationMode.wrappedValue.dismiss()
            } label: {
                ScoopButtonLabelView(name: "Add Item")
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
    
    private func saveItem() {
        let newItem = GroceryItem(name: item, quantity: quantity, unit: unit)
        vm.add(newItem)
    }
}

@available(iOS 16.0, *)
#Preview {
    AddGroceryItemView(item: "Beef Liver Raw", quantity: 1.5, unit: .kg)
}

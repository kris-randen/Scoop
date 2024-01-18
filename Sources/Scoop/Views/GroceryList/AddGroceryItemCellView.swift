//
//  GroceryItemCell.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/9/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct AddGroceryItemCellView: View {
    @Binding var item: String
    @Binding var quantity: Double
    @Binding var unit: Units.Mass
    
    var quantityString: String {
        "\(quantity)"
    }
    
    public var body: some View {
        VStack {
            HStack {
                ScoopTextField(text: $item)
                    .fontWeight(.regular)
                ScoopNumField(value: $quantity)
                    .fontWeight(.regular)
                    .frame(width: Constants.Width/8)
                    .multilineTextAlignment(.center)
                Button {
                    unit = unit.toggle()
                } label: {
                    BadgeView(badge: Badge(kind: .mass(unit: unit)))
                        .textFieldify(withHeightScaling: Dimensions.HeightScaling.textField)
                }
                .frame(width: Constants.Width / 7)
            }
            .foregroundColor(Colors.scoopRed)
        }
        .textFieldify(withHeightScaling: Dimensions.HeightScaling.textField / 3)
        .padding()
    }
}

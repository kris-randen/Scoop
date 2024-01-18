//
//  GroceryListCellView.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/11/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct GroceryListCellView: View {
    var item: String = "Beef Liver Raw"
    var quantity: String = "1.3"
    var unit: String = "kg"
    
    public init(item: String = "Beef Liver Raw", quantity: String = "1.3", unit: String = "kg") {
        self.item = item
        self.quantity = quantity
        self.unit = unit
    }
    
    public var body: some View {
        HStack {
            ScoopTextLabelView(text: item)
                .frame(width: Constants.Width / 2)
                .fontWeight(.black)
            ScoopTextLabelView(text: "\(quantity)", alignment: .trailing)
                .frame(width: Constants.Width / 7)
            ScoopTextLabelView(text: "\(unit)", alignment: .trailing)
                .fontWeight(.black)
                .frame(width: Constants.Width / 8)
        }
        .foregroundColor(Colors.scoopRed)
        .padding([.vertical, .leading])
    }
}

//
//  ScoopTextLabel.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/10/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct ScoopTextLabel: View {
    var text: String
    var shape = Shapes.textField
    
    public init(text: String, shape: Modifiers.Shapes = Shapes.textField) {
        self.text = text
        self.shape = shape
    }
    
    public var body: some View {
        Text(text)
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .font(Fonts.signInTextField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .shadowify()
        .fontWeight(.black)
        .foregroundColor(Colors.scoopRed)
    }
}

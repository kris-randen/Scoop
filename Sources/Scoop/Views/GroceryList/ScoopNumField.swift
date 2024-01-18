//
//  ScoopNumField.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/11/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ScoopNumField: View {
    @Binding var value: Double
    var shape = Shapes.textField
    
    public init(value: Binding<Double>, shape: Modifiers.Shapes = Shapes.textField) {
        self._value = value
        self.shape = shape
    }
    
    public var body: some View {
        TextField("", value: $value, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                    .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
                    .font(Fonts.signInTextField)
                    .borderify(shape: shape, color: Colors.scoopYellow)
                    .clippify(shape: shape)
                    .shadowify()
                    .foregroundColor(Colors.scoopRed)
    }
}

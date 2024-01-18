////
////  ScoopTextField.swift
////  messaging
////
////  Created by Krishnaswami Rajendren on 12/20/23.
////
//
//import SwiftUI


import SwiftUI

@available(iOS 15.0, *)
public struct ScoopTextField: View {
    @Binding var text: String
    @Binding var kind: Nutrient.Kind
    var shape = Shapes.textField
    
    public init(text: Binding<String>, kind: Binding<Nutrient.Kind>, shape: Modifiers.Shapes = Shapes.textField) {
        self._text = text
        self._kind = kind
        self.shape = shape
    }
    
    public var body: some View {
        TextField(text: $text, prompt: Text("")
            .foregroundColor(Colors.scoopRedPlaceholder)) {
            Text("Maggie...")
                    .foregroundColor(Colors.scoopRedPlaceholder)
        }
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .font(Fonts.signInTextField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .shadowify()
    }
}

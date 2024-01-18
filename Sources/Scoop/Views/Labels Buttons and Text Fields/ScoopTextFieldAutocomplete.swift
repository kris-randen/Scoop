//
//  ScoopTextFieldAutocomplete.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ScoopTextFieldAutocomplete: View {
    @Binding var text: String
    @Binding var kind: Nutrient.Kind
    var shape = Shapes.textField
    
    public init(text: Binding<String>, kind: Binding<Nutrient.Kind>, shape: Modifiers.Shapes = Shapes.textField) {
        self._text = text
        self._kind = kind
        self.shape = shape
    }
    
    public var body: some View {
        
        TextField(text: $text, prompt: Text("Maggi Noodles...").foregroundColor(Colors.scoopRedPlaceholder)) {
            Text("").foregroundColor(Colors.scoopRedPlaceholder)
        }
        .foregroundColor(Colors.scoopRed)
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .font(Fonts.signInTextField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .shadowify()
        .overlay(alignment: .trailing) {
            Button {
                kind = kind.toggle()
            } label: {
                BadgeView(badge: Badge(kind: .kind(kind: kind), nqi: -47))
            }
            .padding(.trailing, -25)
        }
    }
}

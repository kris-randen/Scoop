//
//  ProfileAndServingToggleView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/8/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ProfileAndServingToggleView: View {
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    var shape = Shapes.textField
    
    public init(kind: Binding<Nutrient.Kind>, serving: Binding<Serving.Kind>, shape: Modifiers.Shapes = Shapes.textField) {
            self._kind = kind
            self._serving = serving
            self.shape = shape
        }
    
    public var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Spacer()
            ProfileToggleView(kind: $kind, shape: shape)
            Spacer()
            ServingToggleView(serving: $serving, shape: shape)
            Spacer()
        }
        .foregroundColor(Colors.scoopRed)
    }
}

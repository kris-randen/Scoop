//
//  ToggleView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/8/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ServingToggleView: View {
    @Binding var serving: Serving.Kind
    var shape = Shapes.textField
    
    public init(serving: Binding<Serving.Kind>, shape: Modifiers.Shapes = Shapes.textField) {
        self._serving = serving
        self.shape = shape
    }
    
    public var body: some View {
        HStack {
            Text("serving")
                .font(Fonts.badgeFont)
                .padding(.trailing)
            Button {
                serving = serving.toggle()
            } label: {
                BadgeView(badge: Badge(kind: .serving(kind: serving)))
            }
            .frame(width: 30)
            .padding(.trailing)
        }
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .font(Fonts.signInTextField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .shadowify()
    }
}

//#Preview {
//    ToggleView()
//}

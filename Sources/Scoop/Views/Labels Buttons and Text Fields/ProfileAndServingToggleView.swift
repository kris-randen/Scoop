//
//  ProfileAndServingToggleView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/8/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ProfileAndServingToggleView: View {
    var shape = Shapes.textField
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    public var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Spacer()
            ProfileToggleView(shape: shape, kind: $kind)
            Spacer()
            ServingToggleView(shape: shape, serving: $serving)
            Spacer()
        }
        .foregroundColor(Colors.scoopRed)
    }
}

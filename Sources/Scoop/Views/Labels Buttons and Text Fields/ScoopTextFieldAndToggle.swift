//
//  ScoopTextFieldAndToggle.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/8/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ScoopTextFieldAndToggle: View {
    var shape = Shapes.textField
    @Binding var text: String
    @Binding var kind: Nutrient.Kind
    @Binding var quantity: String
    @Binding var serving: Serving.Kind

    public var body: some View {
        VStack {
            ScoopTextField(shape: shape, text: $text, kind: $kind)
            ProfileAndServingToggleView(shape: shape, kind: $kind, serving: $serving)
        }
        .foregroundColor(Colors.scoopRed)
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
    }
}

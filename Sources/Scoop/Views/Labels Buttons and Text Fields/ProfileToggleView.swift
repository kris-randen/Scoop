//
//  ProfileTypeToggleView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/8/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ProfileToggleView: View {
    var shape = Shapes.textField
    @Binding var kind: Nutrient.Kind
    public var body: some View {
        HStack {
            Text("profile")
                .font(Fonts.badgeFont)
                .padding(.trailing)
            Button {
                kind = kind.toggle()
            } label: {
                BadgeView(badge: Badge(kind: .kind(kind: kind)))
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

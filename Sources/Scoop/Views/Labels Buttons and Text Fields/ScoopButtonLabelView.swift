//
//  ScoopButtonLabelView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ScoopButtonLabelView: View {
    var name: String = "Scoop"
    var shape: Modifiers.Shapes = Shapes.textField
    
    public var body: some View {
        Text(name)
            .foregroundColor(Colors.scoopRed)
            .font(Fonts.fullWidthButtonLabel)
            .fullYellowButtonify(height: .height(scaling: Dimensions.HeightScaling.button, tolerance: 0))
            .borderify(shape: shape, color: Colors.scoopYellow)
            .clippify(shape: shape)
            .shadowify()
    }
}

//
//  ScoopTextLabelView.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/11/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ScoopTextLabelView: View {
    var text: String = "Beef Liver Raw"
    var width: CGFloat = Constants.Width
    var alignment: Alignment = .leading
    
    public init(text: String = "Beef Liver Raw", width: CGFloat = Constants.Width, alignment: Alignment = .leading) {
        self.text = text
        self.width = width
        self.alignment = alignment
    }
    
    public var body: some View {
        Text(text)
            .frame(maxWidth: width, alignment: alignment)
            .lineLimit(1)
            .textFieldify(heightScaling: Dimensions.HeightScaling.textField, alignment: .center)
            .font(Fonts.signInTextField)
            .borderify(shape: Shapes.textField, color: Colors.scoopYellow)
            .clippify(shape: Shapes.textField)
            .shadowify()
            .foregroundColor(Colors.scoopRed)
    }
}

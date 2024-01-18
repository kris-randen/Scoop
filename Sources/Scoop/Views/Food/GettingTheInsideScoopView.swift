//
//  GettingTheInsideScoopView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct GettingTheInsideScoopView: View {
    var food: String = "arugula, raw"
    
    public init(food: String) {
        self.food = food
    }
    
    public var body: some View {
        Text("𝘨𝘦𝘵𝘵𝘪𝘯' 𝘵𝘩𝘦 𝘪𝘯𝘴𝘪𝘥𝘦 𝘀𝗰𝗼𝗼𝗽 🦉🌈 𝘰𝘯 \(food.camelCased)...")
            .multilineTextAlignment(.center)
            .font(Fonts.SignIn.labelButtonFull)
    }
}

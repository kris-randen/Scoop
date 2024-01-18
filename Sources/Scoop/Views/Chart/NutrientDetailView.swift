//
//  NutrientDetailViewNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/5/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct NutrientDetailView: View {
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    var profile = Profiles.arugula
    public var body: some View {
        HorizontalChartView(kind: $kind, serving: $serving, profile: profile)
    }
}

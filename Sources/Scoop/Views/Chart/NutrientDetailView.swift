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
    
    public init(kind: Binding<Nutrient.Kind>, serving: Binding<Serving.Kind>, profile: NutrientProfile) {
            self._kind = kind
            self._serving = serving
            self.profile = profile
        }
    
    public var body: some View {
        HorizontalChartView(kind: $kind, serving: $serving, profile: profile)
    }
}

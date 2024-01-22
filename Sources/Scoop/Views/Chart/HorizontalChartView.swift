//
//  HorizontalChartViewNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/5/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct HorizontalChartView: View {
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    var profile: NutrientProfile
    var orientation: Chart.Orientation {
        .horizontal
    }
    
    public init(kind: Binding<Nutrient.Kind>, serving: Binding<Serving.Kind>, profile: NutrientProfile) {
            self._kind = kind
            self._serving = serving
            self.profile = profile
        }
    
    var scaled: NutrientProfile {
        switch serving {
        case .gm100:
            profile.scaledByDV().scaledTo(servingSize:Serving.Mass(value: 100, unit: .gm))
        case .kcal2000:
            profile.convertedToNQI()
        case .list:
            profile.scaledByDV()
        }
    }
    
    var chart: Chart {
        Chart(profile: scaled, kind: kind, nqi: profile.nqi)
    }
    
    public var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in
                    CardView()
                    ScrollView {
                        VStack {
                            ItemDescriptionView(food: profile.food, nqi: profile.nqi)
                            ChartView(chart: chart, size: geo.size)
                        }
                    }
                }
                .padding(Constants.Width/35)
            }
            .navigationTitle(kind.navigationTitle)
            switch serving {
            case .gm100, .kcal2000:
                ProfileAndServingToggleView(kind: $kind, serving: $serving, shape: Shapes.textField)
            case .list:
                ProfileToggleView(kind: $kind)
            }
            
        }
    }
}

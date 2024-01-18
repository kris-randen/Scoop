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
    
    var scaled: NutrientProfile {
        switch serving {
        case .gm100:
            profile.scaledByDV().scaledTo(servingSize:Serving(value: 100, unit: .gm))
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
                ProfileAndServingToggleView(shape: Shapes.textField, kind: $kind, serving: $serving)
            case .list:
                ProfileToggleView(kind: $kind)
            }
            
        }
    }
}

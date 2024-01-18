//
//  VerticalChartViewFDCapiTest.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//


import SwiftUI

@available(iOS 15.0, *)
public struct VerticalChartView: View {
    @Binding var kind: Nutrient.Kind
    var profile: NutrientProfile
    var orientation: Chart.Orientation { .vertical }

    var chart: Chart {
        Chart(profile: profile, kind: kind, nqi: profile.nqi)
    }
    var food: String { profile.food }
    var nqi: Double { profile.nqi }
    
    public var body: some View {
        ZStack {
            GeometryReader { geo in
                CardView()
                VStack(alignment: .center) {
                    ItemDescriptionView(food: food, nqi: nqi)
                    ChartViewVariable(orientation: orientation, chart: chart, size: geo.size)
                }
            }
            .padding()
        }
        .navigationTitle(kind.navigationTitle)
    }
}

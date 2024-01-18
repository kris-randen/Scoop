//
//  BarsView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct BarsView: View {
    var chart: Chart
    var size: CGSize
    var orientation: Chart.Orientation = .horizontal
    public var body: some View {
        VStack(alignment: .leading) {
            ForEach(chart.bars, id: \.name) { bar in
                barView(for: bar, in: chart, with: size)
            }
        }
    }
    
    fileprivate func barView(for bar: Chart.Bar, in chart: Chart, with size: CGSize) -> some View
    {
//        VStack(alignment: .leading, spacing: 12){
        VStack(alignment: .leading){
            figure(for: bar, in: chart, with: size)
            legend(for: bar)
                .foregroundColor(Colors.scoopRed)
                .padding(.bottom, 6)
        }
    }
    
    fileprivate func figure(for bar: Chart.Bar, in chart: Chart, with size: CGSize) -> some View {
        FlexibleRoundedRect(
            orientation: .horizontal,
            alignment: .leading,
            scaling: scaling(for: bar),
            width: chart.barWidth(for: size),
            radiusScaling: 0.4
        )
        .foregroundColor(bar.color)
    }
    
    fileprivate func legend(for bar: Chart.Bar) -> some View {
        HStack(alignment: .bottom) {
            Text(bar.value == 0 ? "ZERO" : description(for: bar.value))
                .font(Fonts.CardNutrientSubtitle.weight(.black))
                .fixedSize(horizontal: true, vertical: false)
            Text(bar.legend)
                .font(Fonts.CardNutrientSubtitle)
                .fixedSize(horizontal: true, vertical: false)
            if bar.value >= 8 {
                Spacer()
                BadgeView(badge: Badge(kind: .nutrient, nqi: 8))
                    .padding(.horizontal, 5)
            }
        }
        .foregroundColor(bar.legendColor)
//        .padding(5)
    }
    
    fileprivate func scaling(for bar: Chart.Bar) -> Double {
        switch orientation {
        case .horizontal:
            bar.value < 0.6 ? 0.03 : 0.05 * (bar.value <= 18 ? bar.value : 18)
        case .vertical:
            bar.value < 0.6 ? 0.03 : 0.08 * bar.value
        }
    }
    
    func description(for value: Double) -> String {
        if value < 1 {
            return String(format: "%.0f%%", (value * 100))
        }
        switch (value - floor(value)) {
        case 0.25...0.75:
            return String(format: "%.0fX", (floor(value) + 0.5))
        case 0...0.25:
            return String(format: "%.0fX", floor(value))
        case 0.75...1:
            return String(format: "%.0fX", ceil(value))
        default:
            return String(format: "%.0fX", value)
        }
    }
}

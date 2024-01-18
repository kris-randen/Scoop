//
//  AxisTitleView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/26/23.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct AxisTitlesView: View {
    var chart: Chart
    public var body: some View {
        VStack(alignment: .trailing) {
            ForEach(chart.bars, id: \.name) { bar in
                axisTitle(bar)
            }
        }
    }
    
    fileprivate func axisTitle(_ bar: Chart.Bar) -> some View {
        VStack(alignment: .trailing) {
            Text(bar.name)
                .font(Fonts.CardNutrient)
                .multilineTextAlignment(.trailing)
            if chart.kind == .macro {
                HStack {
                    Text(String(format: "%.0f", bar.scaled))
                        .fontWeight(.black)
                    Text("\(bar.unit)")
                        .padding(.trailing, -3)
                }
                .font(Fonts.nutrientValue)
                .padding(.bottom, 5)
            } else {
                Text("(\(bar.compound))")
                    .font(Fonts.CardNutrientSubtitle)
                    .padding(.bottom, 5)
            }
            Spacer()
        }
        .multilineTextAlignment(.trailing)
    }
}

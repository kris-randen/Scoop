//
//  AxisTitleView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct AxisTitlesViewVariable: View {
    var chart: Chart
    public var body: some View {
        VStack {
            ForEach(chart.bars, id: \.name) { bar in
                axisTitleVariable(bar)
            }
        }
    }
    
    fileprivate func axisTitleVariable(_ bar: Chart.Bar) -> some View {
        VStack(alignment: .trailing) {
            Text(bar.name)
                .font(Fonts.CardNutrient)
            if chart.kind == .macro {
                HStack {
                    Text(String(format: "%.0f", bar.scaled))
                        .fontWeight(.black)
                    Text("\(bar.unit)")
                        .padding(.leading, -3)
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

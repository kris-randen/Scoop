//
//  ChartTitleView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ChartTitleView: View {
    var chart: Chart
    public var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Spacer()
            Text("\(chart.energy)")
                .font(Fonts.Card.food.weight(.bold))
            Text("Cal")
                .font(Fonts.Card.food.weight(.light))
                .underline()
            Spacer()
            Text("\(chart.title.title)")
                .font(Fonts.Card.food.weight(.bold))
            Text("(\(chart.title.subtitle))")
                .font(Fonts.Card.food.weight(.light))
                .underline()
            Spacer()
        }
    }
}


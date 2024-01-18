//
//  ChartView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/26/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ChartView: View {
    var chart: Chart
    var size: CGSize
    
    public init(chart: Chart, size: CGSize) {
        self.chart = chart
        self.size = size
    }
    
    public var body: some View {
        VStack {
            ChartTitleView(chart: chart)
            ChartBodyViewVariable(chart: chart, size: size, orientation: .horizontal)
            .chartFramify()
        }
    }
}

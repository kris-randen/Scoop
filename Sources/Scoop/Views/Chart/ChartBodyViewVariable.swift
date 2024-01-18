//
//  ChartBodyView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/26/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ChartBodyViewVariable: View {
    var chart: Chart
    var size: CGSize
    var orientation: Chart.Orientation
    
    public init(chart: Chart, size: CGSize, orientation: Chart.Orientation) {
        self.chart = chart
        self.size = size
        self.orientation = orientation
    }
    
    public var body: some View {
        HStack(alignment: .bottom) {
            AxisTitlesView(chart: chart)
                .frame(width: size.width/3.5, alignment: .trailing)
                .multilineTextAlignment(.trailing)
            axis()
                .padding(.horizontal, 5)
                .foregroundColor(Colors.scoopRed)
            BarsView(chart: chart, size: size, orientation: orientation)
        }
    }
    
    fileprivate func axis() -> some View {
        FlexibleRoundedLine(orientation: .vertical, scaling: 0.97, width: 10)
            .frame(width: 15)
    }
}

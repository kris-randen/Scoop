//
//  ChartView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ChartViewVariable: View {
    var orientation: Chart.Orientation = .vertical
    var chart: Chart
    var size: CGSize
    
    public var body: some View {
        VStack {
            ChartTitleView(chart: chart)
            if orientation == .vertical {
                Spacer()
            }
            ChartBodyViewVariable(chart: chart, size: size, orientation: orientation)
            .chartFramifyVariable(for: orientation)
            .rotatify(for: orientation)
        }
    }
}

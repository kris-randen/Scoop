//
//  RoundedRectTopLeftCap.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct RoundedRectTopLeftCap: View {
    var line: RoundedRect
    
    public var body: some View {
        Path { path in
            path.move(to: line.topLeftCenterGlobal)
            path.addArc(
                center: line.topLeftCenterGlobal,
                radius: line.radius,
                startAngle: 180.degrees,
                endAngle: 270.degrees,
                clockwise: false
            )
        }
    }
}

@available(iOS 15.0, *)
public struct RoundedRectTopLeftCap_Previews: PreviewProvider {
    public static var previews: some View {
        RoundedRectTopLeftCap(line: RoundedRect(x: 0, y: 0, width: 100, height: 400, radiusScaling: 0.3))
    }
}

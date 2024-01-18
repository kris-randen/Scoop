//
//  RoundedRectTopRightCap.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct RoundedRectTopRightCap: View {
    var line: RoundedRect
    
    public init(line: RoundedRect) {
        self.line = line
    }
    
    public var body: some View {
        Path { path in
            path.move(to: line.topRightCenterGlobal)
            path.addArc(
                center: line.topRightCenterGlobal,
                radius: line.radius,
                startAngle: 0.degrees,
                endAngle: 270.degrees,
                clockwise: true
            )
        }
    }
}

@available(iOS 15.0.0, *)
public struct RoundedRectTopRightCap_Previews: PreviewProvider {
    public static var previews: some View {
        RoundedRectTopRightCap(line: RoundedRect(x: 0, y: 0, width: 100, height: 400, radiusScaling: 0.3))
    }
}

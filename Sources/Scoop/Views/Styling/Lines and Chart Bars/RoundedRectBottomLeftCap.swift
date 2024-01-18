//
//  RoundedRectBottomLeftCap.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct RoundedRectBottomLeftCap: View {
    var line: RoundedRect
    
    public init(line: RoundedRect) {
        self.line = line
    }
    
    public var body: some View {
        Path { path in
            path.move(to: line.bottomLeftCenterGlobal)
            path.addArc(
                center: line.bottomLeftCenterGlobal,
                radius: line.radius,
                startAngle: 180.degrees,
                endAngle: 90.degrees,
                clockwise: true
            )
        }
    }
}

@available(iOS 15.0, *)
public struct RoundedRectBottomLeftCap_Previews: PreviewProvider {
    public static var previews: some View {
        RoundedRectBottomLeftCap(line: RoundedRect(x: 0, y: 0, width: 100, height: 400, radiusScaling: 0.3))
    }
}

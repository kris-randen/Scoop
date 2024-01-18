//
//  RoundedRectBottomRightCap.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct RoundedRectBottomRightCap: View {
    var line: RoundedRect
    
    public init(line: RoundedRect) {
        self.line = line
    }
    
    public var body: some View {
        Path { path in
            path.move(to: line.bottomRightCenterGlobal)
            path.addArc(
                center: line.bottomRightCenterGlobal,
                radius: line.radius,
                startAngle: 0.degrees,
                endAngle: 90.degrees,
                clockwise: false
            )
        }
    }
}

@available(iOS 15.0, *)
public struct RoundedRectBottomRightCap_Previews: PreviewProvider {
    public static var previews: some View {
        RoundedRectBottomRightCap(line: RoundedRect(x: 0, y: 0, width: 100, height: 400, radiusScaling: 0.3))
    }
}

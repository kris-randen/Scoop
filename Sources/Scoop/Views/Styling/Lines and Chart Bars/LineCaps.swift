//
//  LineCaps.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/25/22.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct LineCaps: View {
    var line: CGRect
    var orientation: CGRect.Orientation
    
    public init(line: CGRect, orientation: CGRect.Orientation) {
        self.line = line
        self.orientation = orientation
    }
    
    var radius: CGFloat {
        switch orientation {
        case .vertical:
            return line.width/2
        case .horizontal:
            return line.height/2
        }
    }
    public var body: some View {
        Path { path in
            switch orientation {
            case .vertical:
                path.move(to: line.topCenterGlobal)
                path.addLine(to: line.topRightGlobal)
                path.addArc(center: line.topCenterGlobal, radius: radius, startAngle: 0.degrees, endAngle: 180.degrees, clockwise: true)
                path.addLine(to: line.topCenterGlobal)
            case .horizontal:
                path.move(to: line.leftCenterGlobal)
                path.addLine(to: line.bottomLeftGlobal)
                path.addArc(center: line.leftCenterGlobal, radius: radius, startAngle: 270.degrees, endAngle: 90.degrees, clockwise: true)
                path.addLine(to: line.leftCenterGlobal)
            }
            switch orientation {
            case .vertical:
                path.move(to: line.bottomCenterGlobal)
                path.addLine(to: line.bottomRightGlobal)
                path.addArc(center: line.bottomCenterGlobal, radius: radius, startAngle: 0.degrees, endAngle: 180.degrees, clockwise: false)
                path.addLine(to: line.bottomCenterGlobal)
            case .horizontal:
                path.move(to: line.rightCenterGlobal)
                path.addLine(to: line.topRightGlobal)
                path.addArc(center: line.rightCenterGlobal, radius: radius, startAngle: 90.degrees, endAngle: 270.degrees, clockwise: true)
                path.addLine(to: line.rightCenterGlobal)
            }
        }
    }
}

@available(iOS 15.0, *)
public struct LineCaps_Previews: PreviewProvider {
    public static var previews: some View {
        LineCaps(line: CGRect(x: 100, y: 0, width: 20, height: 40), orientation: .vertical)
    }
}

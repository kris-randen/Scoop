//
//  HorizontalLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct HorizontalLine: View {
    var origin = CGPoint(x: 50, y: 25)
    var length = CGFloat(250)
    var width = CGFloat(10)
    public var body: some View {
        Path { path in
            path.move(to: origin)
            path.addLine(to: CGPoint(x: origin.x + length, y: origin.y))
            path.addArc(center: CGPoint(x: origin.x + length, y: origin.y + width/2), radius: width/2, startAngle: 90.degrees, endAngle: 270.degrees, clockwise: true)
            path.addLine(to: CGPoint(x: origin.x + length, y: origin.y + width))
            path.addLine(to: CGPoint(x: origin.x, y: origin.y + width))
            path.addArc(center: CGPoint(x: origin.x, y: origin.y + width/2), radius: width/2, startAngle: 90.degrees, endAngle: 270.degrees, clockwise: false)
            path.addLine(to: origin)
        }
    }
}

@available(iOS 15.0, *)
public struct HorizontalLine_Previews: PreviewProvider {
    public static var previews: some View {
        HorizontalLine()
    }
}

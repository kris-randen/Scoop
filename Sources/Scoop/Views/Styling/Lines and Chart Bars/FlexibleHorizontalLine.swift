//
//  FlexibleHorizontalLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/24/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct FlexibleHorizontalLine: View {
    var offset = CGPoint(x: 25, y: 25)
    var lengthScaling = CGFloat(0.5)
    var width = CGFloat(10)
    
    public var body: some View {
        GeometryReader { geo in
            Path { path in
                
                let origin = geo.frame(in: .local).origin + offset
                let length = geo.size.width*lengthScaling
                let bottomLeft = origin + CGPoint(x: 0, y: width)
                let bottomRight = bottomLeft + CGPoint(x: length, y: 0)
                let topRight = bottomRight + CGPoint(x: 0, y: -width)
                let leftArcCenter = origin + CGPoint(x: 0, y: width/2)
                let rightArcCenter = topRight + CGPoint(x: 0, y: width/2)
                
                path.move(to: origin)
                path.addLine(to: bottomLeft)
                path.addArc(center: leftArcCenter, radius: width/2, startAngle: 270.degrees, endAngle: 90.degrees, clockwise: true)
                path.addLine(to: bottomRight)
                path.addLine(to: topRight)
                path.addArc(center: rightArcCenter, radius: width/2, startAngle: 90.degrees, endAngle: 270.degrees, clockwise: true)
                path.addLine(to: origin)
            }
        }
    }
}

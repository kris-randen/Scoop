//
//  FlexibleVerticalLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct FlexibleVerticalLine: View {
//    var orientation: CGRect.Orientation
    var alignment = Alignment(horizontal: .center, vertical: .center)
    var offset = CGPoint(x: 25, y: 25)
    var lengthScaling = CGFloat(1)
    var width = CGFloat(10)
    
    public var body: some View {
        GeometryReader { geo in
            Path { path in
                let height = geo.height
                let length = height*lengthScaling
                let midGeo = CGPoint(x: geo.midX, y: geo.midY)
                let midLine = CGPoint(x: width/2, y: length/2)
            
                let origin = midGeo - midLine
                let bottomLeft = origin + CGPoint(x: 0, y: length)
                let bottomRight = origin + CGPoint(x: width, y: length)
                let topRight = origin + CGPoint(x: width, y: 0)
                let bottomArcCenter = bottomLeft + CGPoint(x: width/2, y: 0)
                let topArcCenter = origin + CGPoint(x: width/2, y: 0)
                
                path.move(to: origin)
                path.addLine(to: bottomLeft)
                path.addArc(center: bottomArcCenter, radius: width/2, startAngle: 0.degrees, endAngle: 180.degrees, clockwise: false)
                path.addLine(to: bottomRight)
                path.addLine(to: topRight)
                path.addArc(center: topArcCenter, radius: width/2, startAngle: 0.degrees, endAngle: 180.degrees, clockwise: true)
                path.addLine(to: origin)
            }
            .border(.red)
        }
    }
}

@available(iOS 15.0.0, *)
public struct FlexibleVerticalLine_Previews: PreviewProvider {
    public static var previews: some View {
        FlexibleVerticalLine()
    }
}

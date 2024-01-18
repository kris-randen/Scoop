//
//  FlexibleRoundedLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/25/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct FlexibleRoundedLine: View {
    var orientation: CGRect.Orientation
    var alignment: Alignment = .center
    var scaling: CGFloat = 0.8
    var width = CGFloat(50)
    
    public init(orientation: CGRect.Orientation, alignment: Alignment = .center, scaling: CGFloat = CGFloat(0.8), width: CGFloat = CGFloat(50)) {
        self.orientation = orientation
        self.alignment = alignment
        self.scaling = scaling
        self.width = width
    }
    
    public var body: some View {
        GeometryReader { geo in
            RoundedLineView(line: line(geo: geo), orientation: orientation)
        }
    }

    fileprivate func line(geo: GeometryProxy) -> CGRect {
        var scalingDim: CGFloat {
            switch orientation {
            case .vertical:
                return geo.height
            case .horizontal:
                return geo.width
            }
        }
        var length: CGFloat { scalingDim * scaling }
        
        var x: CGFloat
        var y: CGFloat
        var lineWidth: CGFloat
        var lineHeight: CGFloat
        switch orientation {
        case .vertical:
            let centerX = geo.center.x - width / 2
            let centerY = geo.center.y - length / 2
            lineWidth = width
            lineHeight = length
            
            // Currently only handling leading alignment as I need that for the horizontal chart bars but need to handle all other cases too for completion
            
            switch alignment {
            case .leading:
                x = geo.origin.x
                y = centerY
            default:
                x = centerX
                y = centerY
            }
        case .horizontal:
            let centerX = geo.center.x - length / 2
            let centerY = geo.center.y - width / 2
            lineWidth = length
            lineHeight = width
            switch alignment {
            case .leading:
                x = geo.origin.x + width/2
                y = centerY
            default:
                x = centerX
                y = centerY
            }
        }
        return CGRect(x: x, y: y, width: lineWidth, height: lineHeight)
    }
}

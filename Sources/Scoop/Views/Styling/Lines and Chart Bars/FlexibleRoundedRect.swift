//
//  FlexibleRoundedRect.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct FlexibleRoundedRect: View {
    var orientation: CGRect.Orientation = .horizontal
    var alignment: Alignment = .leading
    var scaling: CGFloat = 0.8
    var width = CGFloat(50)
    var radiusScaling: CGFloat
    
    public var body: some View {
        GeometryReader { geo in
            RoundedRectView(line: line(geo: geo))
        }
    }

    fileprivate func line(geo: GeometryProxy) -> RoundedRect {
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
            lineWidth = width
            lineHeight = length
            let centerX = geo.center.x - lineWidth / 2
            let centerY = geo.center.y - lineHeight / 2
            
            // Currently only handling leading alignment as I need that for the horizontal chart bars but need to handle all other cases too for completion
            
            switch alignment {
            case .leading:
                x = geo.origin.x
                y = centerY
            case .bottom:
                x = centerX
                y = geo.origin.y + geo.height - lineHeight
            default:
                x = centerX
                y = centerY
            }
        case .horizontal:
            lineWidth = length
            lineHeight = width
            let centerX = geo.center.x - lineWidth / 2
            let centerY = geo.center.y - lineHeight / 2
            switch alignment {
            case .leading:
                x = geo.origin.x
                y = centerY
            default:
                x = centerX
                y = centerY
            }
        }
        return RoundedRect(x: x, y: y, width: lineWidth, height: lineHeight, radiusScaling: radiusScaling, orientation: orientation)
    }
}

@available(iOS 15.0.0, *)
public struct FlexibleRoundedRect_Previews: PreviewProvider {
    public static var previews: some View {
        FlexibleRoundedRect(orientation: .horizontal, alignment: .leading, radiusScaling: 0.4)
            .padding()
    }
}

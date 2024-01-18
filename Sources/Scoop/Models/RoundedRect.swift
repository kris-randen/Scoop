//
//  RoundedLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import Foundation

@available(iOS 15.0, *)
public struct RoundedRect: RoundedRectProperties {
    public let x: CGFloat
    public let y: CGFloat
    public let width: CGFloat
    public let height: CGFloat
    public let radiusScaling: CGFloat
    public var orientation: CGRect.Orientation = .horizontal
    
    public init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, radiusScaling: CGFloat, orientation: CGRect.Orientation = .horizontal) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.radiusScaling = radiusScaling
        self.orientation = orientation
    }
    
    public init(rect: CGRect, radiusScaling: CGFloat, orientation: CGRect.Orientation = .horizontal) {
        self.x = rect.origin.x
        self.y = rect.origin.y
        self.width = rect.width
        self.height = rect.height
        self.radiusScaling = radiusScaling
        self.orientation = orientation
    }
}

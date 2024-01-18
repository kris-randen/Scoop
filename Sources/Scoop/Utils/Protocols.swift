//
//  public protocols.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import Foundation

@available(iOS 15.0, *)
public protocol RectangleProperties {
    var origin: CGPoint { get }
    var width: CGFloat { get }
    var height: CGFloat { get }
    var minDim: CGFloat { get }
}

@available(iOS 15.0, *)
public protocol RoundedRectProperties: RectangleProperties {
    var x: CGFloat { get }
    var y: CGFloat { get }
    var radiusScaling: CGFloat { get }
    var orientation: CGRect.Orientation { get }
}

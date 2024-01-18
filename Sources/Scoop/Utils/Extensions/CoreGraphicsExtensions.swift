//
//  CoreGraphics.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
public extension Int {
    var double: Double { Double(self) }
    
    var degrees: Angle { Angle(degrees: Double(self)) }
}

@available(iOS 15.0, *)
public extension Double {
    var int: Int { Int(self) }
    
    var degrees: Angle { Angle(degrees: self) }
}

@available(iOS 15.0, *)
public extension CGPoint {
    static var zero: CGPoint { CGPoint(x: 0, y: 0) }
    
    func offset(to p: CGPoint) -> CGPoint {
        CGPoint(x: self.x + p.x, y: self.y + p.y)
    }
    
    static prefix func - (p: CGPoint) -> CGPoint {
        return CGPoint(x: -p.x, y: -p.y)
    }
}

@available(iOS 15.0, *)
public extension RectangleProperties {
    var minDim: CGFloat { min(width, height) }
    var originLocal: CGPoint { CGPoint.zero }
    var originGlobal: CGPoint { origin }
    
    var topLeft: CGPoint { CGPoint.zero }
    var topRight: CGPoint { CGPoint(x: width, y: 0) }
    var bottomLeft: CGPoint { CGPoint(x: 0, y: height) }
    var bottomRight: CGPoint { CGPoint(x: width, y: height) }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    var topCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var bottomCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var rightCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftGlobal: CGPoint { topLeft.offset(to: originGlobal) }
    var topRightGlobal: CGPoint { topRight.offset(to: originGlobal) }
    var bottomLeftGlobal: CGPoint { bottomLeft.offset(to: originGlobal) }
    var bottomRightGlobal: CGPoint { bottomRight.offset(to: originGlobal) }
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    var topCenterGlobal: CGPoint { topCenter.offset(to: originGlobal) }
    var bottomCenterGlobal: CGPoint { bottomCenter.offset(to: originGlobal) }
    var leftCenterGlobal: CGPoint { leftCenter.offset(to: originGlobal) }
    var rightCenterGlobal: CGPoint { rightCenter.offset(to: originGlobal) }
    
    var naturalOrientation: CGRect.Orientation {
        return height > width ? .vertical : .horizontal
    }
}

@available(iOS 15.0, *)
public extension RoundedRectProperties {
    var origin: CGPoint { CGPoint.zero }
    var originGlobal: CGPoint { CGPoint(x: x, y: y) }
    var width: CGFloat { width }
    var height: CGFloat { height }
    
    var majorDim: CGFloat {
        switch orientation {
        case .horizontal:
            return width
        case .vertical:
            return height
        }
    }
    
    var minorDim: CGFloat {
        switch orientation {
        case .horizontal:
            return height
        case .vertical:
            return width
        }
    }
    
    func scaling(factor: CGFloat) -> CGFloat {
        if majorDim >= minorDim { return factor }
        else { return 0.5 }
    }
    
    var radius: CGFloat { scaling(factor: radiusScaling) * minDim }
    
    var topLeftLeft: CGPoint { CGPoint(x: 0, y: radius) }
    var topLeftCenter: CGPoint { CGPoint(x: radius, y: radius) }
    var topLeftRight: CGPoint { CGPoint(x: radius, y: 0) }
    
    var topRightLeft: CGPoint { CGPoint(x: width - radius, y: 0) }
    var topRightCenter: CGPoint { CGPoint(x: width - radius, y: radius) }
    var topRightRight: CGPoint { CGPoint(x: width, y: radius) }
    
    var bottomLeftLeft: CGPoint { CGPoint(x: 0, y: height - radius) }
    var bottomLeftCenter: CGPoint { CGPoint(x: radius, y: height - radius) }
    var bottomLeftRight: CGPoint { CGPoint(x: radius, y: height) }
    
    var bottomRightLeft: CGPoint { CGPoint(x: width - radius, y: height) }
    var bottomRightCenter: CGPoint { CGPoint(x: width - radius, y: height - radius) }
    var bottomRightRight: CGPoint { CGPoint(x: width, y: height - radius) }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    
    var topOuterCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var topInnerCenter: CGPoint { CGPoint(x: width / 2, y: radius) }
    var bottomInnerCenter: CGPoint { CGPoint(x: width / 2, y: height - radius)}
    var bottomOuterCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftOuterCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var leftInnerCenter: CGPoint { CGPoint(x: radius, y: height / 2) }
    var rightInnerCenter: CGPoint { CGPoint(x: width - radius, y: height / 2) }
    var rightOuterCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftLeftGlobal: CGPoint { topLeftLeft.offset(to: originGlobal) }
    var topLeftCenterGlobal: CGPoint { topLeftCenter.offset(to: originGlobal) }
    var topLeftRightGlobal: CGPoint { topLeftRight.offset(to: originGlobal) }
    
    var topRightLeftGlobal: CGPoint { topRightLeft.offset(to: originGlobal) }
    var topRightCenterGlobal: CGPoint { topRightCenter.offset(to: originGlobal) }
    var topRightRightGlobal: CGPoint { topRightRight.offset(to: originGlobal) }
    
    var bottomLeftLeftGlobal: CGPoint { bottomLeftLeft.offset(to: originGlobal) }
    var bottomLeftCenterGlobal: CGPoint { bottomLeftCenter.offset(to: originGlobal) }
    var bottomLeftRightGlobal: CGPoint { bottomLeftRight.offset(to: originGlobal) }
    
    var bottomRightLeftGlobal: CGPoint { bottomRightLeft.offset(to: originGlobal) }
    var bottomRightCenterGlobal: CGPoint { bottomRightCenter.offset(to: originGlobal) }
    var bottomRightRightGlobal: CGPoint { bottomRightRight.offset(to: originGlobal) }
    
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    
    var topOuterCenterGlobal: CGPoint { topOuterCenter.offset(to: originGlobal) }
    var topInnerCenterGlobal: CGPoint { topInnerCenter.offset(to: originGlobal) }
    var bottomInnerCenterGlobal: CGPoint { bottomInnerCenter.offset(to: originGlobal)}
    var bottomOuterCenterGlobal: CGPoint { bottomOuterCenter.offset(to: originGlobal)}
    var leftOuterCenterGlobal: CGPoint { leftOuterCenter.offset(to: originGlobal) }
    var leftInnerCenterGlobal: CGPoint { leftInnerCenter.offset(to: originGlobal) }
    var rightInnerCenterGlobal: CGPoint { rightInnerCenter.offset(to: originGlobal) }
    var rightOuterCenterGlobal: CGPoint { rightOuterCenter.offset(to: originGlobal) }
    
    var leftFlank: CGRect {
        CGRect(
            x: topLeftLeftGlobal.x,
            y: topLeftLeftGlobal.y,
            width: radius,
            height: height - (2 * radius)
        )
    }
    var rightFlank: CGRect {
        CGRect(
            x: topRightCenterGlobal.x,
            y: topRightCenterGlobal.y,
            width: radius,
            height: height - (2 * radius)
        )
    }
    var topFlank: CGRect {
        CGRect(
            x: topLeftRightGlobal.x,
            y: topLeftRightGlobal.y,
            width: width - (2 * radius),
            height: radius
        )
    }
    var bottomFlank: CGRect {
        CGRect(
            x: bottomLeftCenterGlobal.x,
            y: bottomLeftCenterGlobal.y,
            width: width - (2 * radius),
            height: radius
        )
    }
}

@available(iOS 15.0, *)
public extension CGRect {
    public enum Orientation {
        case vertical
        case horizontal
    }
    
    var originLocal: CGPoint { CGPoint.zero }
    var originGlobal: CGPoint { origin }
    
    var topLeft: CGPoint { CGPoint.zero }
    var topRight: CGPoint { CGPoint(x: width, y: 0) }
    var bottomLeft: CGPoint { CGPoint(x: 0, y: height) }
    var bottomRight: CGPoint { CGPoint(x: width, y: height) }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    var topCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var bottomCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var rightCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftGlobal: CGPoint { topLeft.offset(to: originGlobal) }
    var topRightGlobal: CGPoint { topRight.offset(to: originGlobal) }
    var bottomLeftGlobal: CGPoint { bottomLeft.offset(to: originGlobal) }
    var bottomRightGlobal: CGPoint { bottomRight.offset(to: originGlobal) }
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    var topCenterGlobal: CGPoint { topCenter.offset(to: originGlobal) }
    var bottomCenterGlobal: CGPoint { bottomCenter.offset(to: originGlobal) }
    var leftCenterGlobal: CGPoint { leftCenter.offset(to: originGlobal) }
    var rightCenterGlobal: CGPoint { rightCenter.offset(to: originGlobal) }
    
    var orientation: Orientation {
        return height > width ? .vertical : .horizontal
    }
}

@available(iOS 15.0, *)
public extension RoundedRect {
    
}

@available(iOS 15.0, *)
public extension Path {
    
}

@available(iOS 15.0, *)
public extension GeometryProxy {
    var bounds: CGRect { frame(in: .local) }
    var origin: CGPoint { bounds.origin }
    
    var minX: CGFloat { bounds.minX }
    var minY: CGFloat { bounds.minY }
    var midX: CGFloat { bounds.midX }
    var midY: CGFloat { bounds.midY }
    var maxX: CGFloat { bounds.maxX }
    var maxY: CGFloat { bounds.maxY }
    
    var height: CGFloat { size.height }
    var width: CGFloat { size.width }
    var minDim: CGFloat { bounds.minDim }
    
    var boundsGlobal: CGRect { frame(in: .global) }
    var originGlobal: CGPoint { boundsGlobal.origin }
    
    var minXGlobal: CGFloat { boundsGlobal.minX }
    var minYGlobal: CGFloat { boundsGlobal.minY }
    var midXGlobal: CGFloat { boundsGlobal.midX }
    var midYGlobal: CGFloat { boundsGlobal.midY }
    var maxXGlobal: CGFloat { boundsGlobal.maxX }
    var maxYGlobal: CGFloat { boundsGlobal.maxY }
    
    
    var topLeft: CGPoint { bounds.topLeft }
    var topRight: CGPoint { bounds.topRight }
    var bottomLeft: CGPoint { bounds.bottomLeft }
    var bottomRight: CGPoint { bounds.bottomRight }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    var topCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var bottomCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var rightCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftGlobal: CGPoint { boundsGlobal.topLeftGlobal }
    var topRightGlobal: CGPoint { boundsGlobal.topRightGlobal }
    var bottomLeftGlobal: CGPoint { boundsGlobal.bottomLeftGlobal }
    var bottomRightGlobal: CGPoint { boundsGlobal.bottomRightGlobal }
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    var topCenterGlobal: CGPoint { topCenter.offset(to: originGlobal) }
    var bottomCenterGlobal: CGPoint { bottomCenter.offset(to: originGlobal) }
    var leftCenterGlobal: CGPoint { leftCenter.offset(to: originGlobal) }
    var rightCenterGlobal: CGPoint { rightCenter.offset(to: originGlobal) }
}

@available(iOS 15.0, *)
func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint { lhs.offset(to: rhs) }
@available(iOS 15.0, *)
func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint { lhs.offset(to: -rhs) }
@available(iOS 15.0, *)
func *(lhs: Double, rhs: CGPoint) -> CGPoint { CGPoint(x: lhs*rhs.x, y: lhs*rhs.y) }

@available(iOS 15.0, *)
public extension View {
    var screen: CGRect {
        UIScreen.main.bounds
    }
    var screenWidth: CGFloat {
        screen.width
    }
    var screenHeight: CGFloat {
        screen.height
    }
}

@available(iOS 15.0, *)
public extension CGRect {
    var minDim: CGFloat { min(width, height) }
    
    var maxDim: CGFloat { max(width, height) }
}


@available(iOS 15.0, *)
public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

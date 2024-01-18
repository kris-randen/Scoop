//
//  Dimensions.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import UIKit

@available(iOS 15.0, *)
public struct Dimensions {
    public static let Bounds: CGRect = UIScreen().bounds
    public static let Height: CGFloat = Bounds.height
    public static let Width: CGFloat = Bounds.width
    public static let MinDim: CGFloat = Bounds.minDim
    
    public struct HeightScaling {
        public static let textField: CGFloat = 25
        public static let button: CGFloat = 17
        public static let scoopLogoLarge: CGFloat = 20.0
    }
    
    public struct WidthScaling {
        public static let fullWidth: CGFloat = 1.2
        public static let halfWidth: CGFloat = 2.3
        public static let fullWidthPadding: CGFloat = 19.5
        public static let halfButtonPadding: CGFloat = 100
    }
    
    public struct CornerRadiusScaling {
        public static let textField: CGFloat = 32.0
        public static let picker: CGFloat = 5.0
        
    }
    
    public enum Scaling {
        case width(factor: CGFloat, dimension: CGFloat = Width)
        case height(factor: CGFloat, dimension: CGFloat = Height)
        case corner(factor: CGFloat, dimension: CGFloat = MinDim)
        case padding(factor: CGFloat, dimension: CGFloat = MinDim)
        
        var value: CGFloat {
            switch self {
            case .width(let factor, let dimension),
                 .height(let factor, let dimension),
                 .corner(let factor, let dimension),
                 .padding(let factor, let dimension):
                return dimension / factor
            }
        }
    }
}

//
//  Shapes.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/22/22.
//

import UIKit
import SwiftUI

@available(iOS 15.0, *)
public struct Shapes {
    public static let textField: Modifiers.Shapes = .rectangle(cornerRadiusScaling: Dimensions.CornerRadiusScaling.textField)
    public static let picker: Modifiers.Shapes = .rectangle(cornerRadiusScaling: Dimensions.CornerRadiusScaling.textField)
}

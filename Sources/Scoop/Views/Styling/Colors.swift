//
//  Colors.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import UIKit
import SwiftUI

@available(iOS 15.0, *)
public struct Colors {
    public static let scoopRed = Color(UIColor(red: 164/255, green: 0, blue: 0, alpha: 1))
    public static let scoopRedPlaceholder = scoopRed.opacity(0.35)
    public static let scoopYellow = Color(UIColor(red: 244/255, green: 189/255, blue: 42/255, alpha: 1))
    public static let scoopYellowPlaceholder = scoopYellow.opacity(0.3)
    public static let scoopGreen = Color(UIColor(red: 29 / 255, green: 128 / 255, blue: 14 / 255, alpha: 1))
    public static let scoopBlue = Color(UIColor(red: 20 / 255, green: 81 / 255, blue: 183 / 255, alpha: 1))
    
    public static let facebookBlue = Color(UIColor(red: 80/255, green: 124/255, blue: 192/255, alpha: 1))
    public static let googleRed = Color(UIColor(red: 223/255, green: 73/255, blue: 48/255, alpha: 1))
}

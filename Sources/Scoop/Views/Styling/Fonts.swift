//
//  Fonts.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import UIKit
import SwiftUI
@available(iOS 15.0, *)
public struct Fonts {
    public struct SignIn {
        public static let logoScoop =          Font
                                            .custom("Avenir", size: 28, relativeTo: .largeTitle)
                                            .weight(.black)
        public static let textField =          Font
                                            .custom("Avenir", size: 28, relativeTo: .largeTitle)
                                            .weight(.black)
        public static let labelButtonFull =    Font
                                            .custom("Avenir", size: 20, relativeTo: .title2)
                                            .weight(.black)
        public static let labelButtonHalf =    Font
                                            .custom("Avenir", size: 14, relativeTo: .caption)
                                            .weight(.medium)
        public static let iconTextField =      Font
                                            .custom("Avenir Next", size: 21, relativeTo: .caption)
                                            .weight(.thin)
        public static let textSmall =          Font
                                            .custom("Avenir Next", size: 14, relativeTo: .caption)
                                            .weight(.medium)
        public static let iconGoogleButton =   Font
                                            .custom("Georgia", size: 28, relativeTo: .largeTitle)
                                            .weight(.black)
    }
    
    public struct Card {
        public static let nutrient =           Font
                                            .custom("Avenir Next", size: 16, relativeTo: .body)
                                            .weight(.bold)
        public static let chemical =           Font
                                            .custom("Avenir Next", size: 14, relativeTo: .body)
                                            .weight(.light)
        public static let food =               Font
                                            .custom("Avenir Next", size: 16, relativeTo: .body)
        
    }
    
    public static let scoopLogoSignIn = Font.custom("Avenir", size: 28, relativeTo: .largeTitle).weight(.black)
    public static let signInTextField = Font.custom("Avenir", size: 16, relativeTo: .caption).weight(.light)
    public static let fullWidthButtonLabel = Font.custom("Avenir", size: 20, relativeTo: .title2).weight(.black)
    public static let halfWidthButtonLabel = Font.custom("Avenir", size: 14, relativeTo: .caption).weight(.medium)
    public static let signInTextFieldIcon = Font.custom("Avenir Next", size: 21, relativeTo: .caption).weight(.thin)
    public static let signInScreenSmall = Font.custom("Avenir Next", size: 14, relativeTo: .caption).weight(.medium)
    public static let googleButtonIconFont = Font.custom("Georgia", size: 28, relativeTo: .largeTitle).weight(.black)
    public static let badgeFont = Font
        .custom("Avenir Next", size: 12, relativeTo: .body).weight(.bold)
    public static let badgeIconFont = Font
        .custom("Avenir Next", size: 16, relativeTo: .body).weight(.bold)
    public static let badgeIconFontLarge = Font
        .custom("Avenir Next", size: 20, relativeTo: .body).weight(.bold)
    public static let badgeFontSmall = Font
        .custom("Avenir Next", size: 8, relativeTo: .body).weight(.bold)
    
    public static let CardNutrient = Font.custom("Avenir Next", size: 14, relativeTo: .body).weight(.bold)
    public static let CardNutrientSubtitle = Font.custom("Avenir", size: 14, relativeTo: .body).weight(.light)
    
    public static let nutrientValue = Font.custom("Avenir", size: 12, relativeTo: .body)
}

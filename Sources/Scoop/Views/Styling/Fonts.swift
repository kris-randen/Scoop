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
        static let logoScoop =          Font
                                            .custom("Avenir", size: 28, relativeTo: .largeTitle)
                                            .weight(.black)
        static let textField =          Font
                                            .custom("Avenir", size: 28, relativeTo: .largeTitle)
                                            .weight(.black)
        static let labelButtonFull =    Font
                                            .custom("Avenir", size: 20, relativeTo: .title2)
                                            .weight(.black)
        static let labelButtonHalf =    Font
                                            .custom("Avenir", size: 14, relativeTo: .caption)
                                            .weight(.medium)
        static let iconTextField =      Font
                                            .custom("Avenir Next", size: 21, relativeTo: .caption)
                                            .weight(.thin)
        static let textSmall =          Font
                                            .custom("Avenir Next", size: 14, relativeTo: .caption)
                                            .weight(.medium)
        static let iconGoogleButton =   Font
                                            .custom("Georgia", size: 28, relativeTo: .largeTitle)
                                            .weight(.black)
    }
    
    public struct Card {
        static let nutrient =           Font
                                            .custom("Avenir Next", size: 16, relativeTo: .body)
                                            .weight(.bold)
        static let chemical =           Font
                                            .custom("Avenir Next", size: 14, relativeTo: .body)
                                            .weight(.light)
        static let food =               Font
                                            .custom("Avenir Next", size: 16, relativeTo: .body)
        
    }
    
    static let scoopLogoSignIn = Font.custom("Avenir", size: 28, relativeTo: .largeTitle).weight(.black)
    static let signInTextField = Font.custom("Avenir", size: 16, relativeTo: .caption).weight(.light)
    static let fullWidthButtonLabel = Font.custom("Avenir", size: 20, relativeTo: .title2).weight(.black)
    static let halfWidthButtonLabel = Font.custom("Avenir", size: 14, relativeTo: .caption).weight(.medium)
    static let signInTextFieldIcon = Font.custom("Avenir Next", size: 21, relativeTo: .caption).weight(.thin)
    static let signInScreenSmall = Font.custom("Avenir Next", size: 14, relativeTo: .caption).weight(.medium)
    static let googleButtonIconFont = Font.custom("Georgia", size: 28, relativeTo: .largeTitle).weight(.black)
    static let badgeFont = Font
        .custom("Avenir Next", size: 12, relativeTo: .body).weight(.bold)
    static let badgeIconFont = Font
        .custom("Avenir Next", size: 16, relativeTo: .body).weight(.bold)
    static let badgeIconFontLarge = Font
        .custom("Avenir Next", size: 20, relativeTo: .body).weight(.bold)
    static let badgeFontSmall = Font
        .custom("Avenir Next", size: 8, relativeTo: .body).weight(.bold)
    
    static let CardNutrient = Font.custom("Avenir Next", size: 14, relativeTo: .body).weight(.bold)
    static let CardNutrientSubtitle = Font.custom("Avenir", size: 14, relativeTo: .body).weight(.light)
    
    static let nutrientValue = Font.custom("Avenir", size: 12, relativeTo: .body)
}

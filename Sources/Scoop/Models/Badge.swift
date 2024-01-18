//
//  Badge.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/28/22.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
public struct Badge {
    public enum Size {
        case normal
        case small
        
        var textFont: Font {
            switch self {
            case .normal:
                return Fonts.badgeFont
            case .small:
                return Fonts.badgeFontSmall
            }
        }
        
        var iconFont: Font {
            switch self {
            case .normal:
                return Fonts.badgeIconFontLarge
            case .small:
                return Fonts.badgeIconFont
            }
        }
        
        var scaling: CGFloat {
            switch self {
            case .normal:
                return 200
            case .small:
                return 200
            }
        }
    }
    
    public enum Kind {
        case food
        case nutrient
        case kind(kind: Nutrient.Kind)
        case mass(unit: Units.Mass)
        case volume(unit: Units.Volume)
        case serving(kind: Serving.Kind)
        
        var size: Size {
            switch self {
            case .food:
                return .normal
            case .nutrient:
                return .small
            default:
                return .small
            }
        }
    }
    
    var kind: Kind = .food
    var nqi: Int = -47
    
    var size: Size = .normal
    var text: String = "Low Quality"
    var icon: String = LabelType.thumbsDownCircled.name
    var textColors: (background: Color, foreground: Color) = (.black, .white)
    var iconColors:(background: Color, foreground: Color) = (.blue, .white)
    
    init(kind: Kind, nqi: Int = -47, size: Size = .normal, text: String = "Low Quality", icon: String = LabelType.thumbsDownCircled.name) {
        self.size = kind.size
        self.text = getText(kind: kind, nqi: nqi)
        self.icon = getIcon(kind: kind, nqi: nqi)
        self.textColors = getTextColors(kind: kind, nqi: nqi)
        self.iconColors = getIconColors(kind: kind, nqi: nqi)
    }
    
    var textFont: Font { size.textFont }
    var iconFont: Font { size.iconFont }
    var scaling: CGFloat { size.scaling }
    
    func getTextColors(kind: Kind, nqi: Int) -> (background: Color, foreground: Color) {
        switch kind {
        case .food:
            switch nqi {
            case (-2500000)...10:
                return (.black, .white)
            default:
                return (.red, .white)
            }
        case .nutrient:
            switch nqi {
            case 8...1000:
                return (.red, .white)
            default:
                return (.green, .white)
            }
        default:
            return (Colors.scoopYellow, Colors.scoopRed)
        }
    }
    
    func getIconColors(kind: Kind, nqi: Int) -> (background: Color, foreground: Color) {
        switch kind {
        case .food:
            switch nqi {
            case (-2500000)...10:
                return (.black, .white)
            default:
                return (.green, .white)
            }
        case .nutrient:
            switch nqi {
            case 8...1000:
                return (.blue, .white)
            default:
                return (.green, .white)
            }
        case .serving:
            return (Colors.scoopYellow, Colors.scoopRed)
        default:
            return (Colors.scoopRed, Colors.scoopYellow)
        }
    }
    
    func getText(kind: Kind, nqi: Int) -> String {
        switch kind {
        case .food:
            switch nqi {
            case (-2500000)...(-100):
                return "Very Toxic"
            case -100...0:
                return "Very Poor"
            case 0...10:
                return "Poor"
            case 10...100:
                return "Great Food"
            case 100...1000000:
                return "Super Food"
            default:
                return "None"
            }
        case .nutrient:
            switch nqi {
            case 8...1000:
                return "Major Source"
            default:
                return "Minor Source"
            }
        case .kind(let kind):
            return kind.name.lowercased()
        case .mass(let unit):
            return unit.name.lowercased()
        case .volume(let unit):
            return unit.name.lowercased()
        case .serving(let kind):
            return kind.name.lowercased()
        }
    }
    
    func getIcon(kind: Kind, nqi: Int) -> String {
        switch kind {
        case .food:
            switch nqi {
            case (-2500000)...(10):
                return LabelType.thumbsDownCircled.name
            default:
                return LabelType.thumbsUpCircled.name
            }
        case .nutrient:
            switch nqi {
            case 8...1000:
                return LabelType.checkmarkSealFilled.name
            default:
                return LabelType.checkmarkShield.name
            }
        case .kind, .mass, .volume, .serving:
            return LabelType.none.name
        }
    }
}

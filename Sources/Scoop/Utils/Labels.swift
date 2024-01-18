//
//  Labels.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI
import Foundation

public enum LabelType: String, CaseIterable {
    case none = ""
    case like = "heart.fill"
    case unlike = "heart"
    case comment = "bubble.right"
    case share = "paperplane"
    
    case search = "magnifyingglass"
    case chevronDown = "chevron.down"
    
    case eyeOpen = "eye"
    case eyeFilled = "eye.fill"
    case eyeCircled = "eye.circle.fill"
    case eyeClosed = "eye.slash"
    case person = "person"
    case personPlus = "person.badge.plus"
    case personInACircle = "person.circle"
    case camera = "camera"
    case cameraFill = "camera.fill"
    case cameraCircle = "camera.circle"
    case cameraCircleFill = "camera.circle.fill"
    
    case mic = "mic"
    case micFilled = "mic.fill"
    case micCircled = "mic.circle"
    case micCircledFilled = "mic.circle.fill"
    
    case micSlashed = "mic.slash"
    case micSlashedFilled = "mic.slash.fill"
    case micSlashedCircled = "mic.slash.circle"
    case micSlashedCircledFilled = "mic.slash.circle.fill"
    
    case gear = "gear" // Settings
    case plus = "plus"
    case trash = "trash"
    
    // Indicate good foods in the food badges
    
    case thumbsUp = "hand.thumbsup.fill"
    case thumbsUpCircled = "hand.thumbsup.circle.fill"
    
    case thumbsDown = "hand.thumbsdown.fill"
    case thumbsDownCircled = "hand.thumbsdown.circle.fill"
    
    case exclamationTriangled = "exclamationmark.triangle"
    case exclamationFilled = "exclamationmark.triangle.fill"
    
    case handRaised = "hand.raised.brakesignal"
    
    case flame = "flame"
    case flameFilled = "flame.fill"
    case flameCircled = "flame.circle"
    case flameCircledFilled = "flame.circle.fill"
    
    
    case xmarkCircledFilled = "xmark.circle.fill"
    case xmarkCircled = "xmark.circle"
    
    case flagCheckered = "flag.checkered"
    case flagCheckeredDouble = "flag.checkered.2.crossed"
    
    case checkmarkShield = "checkmark.shield.fill"
    case checkmarkSeal = "checkmark.seal"
    case checkmarkSealFilled = "checkmark.seal.fill"
    
    case trophyFilled = "trophy.fill"
    case trophyCircled = "trophy.circle.fill"
    
    case pencilAndRulerFilled = "pencil.and.ruler.fill"
    case pencilAndRuler = "pencil.and.ruler"
    case ruler = "ruler"
    case rulerFilled = "ruler.fill"
    
    case backpackFilled = "backpack.fill"
    case backpack = "backpack"
    case backpackCircled = "backpack.circle.fill"
    
    case bellFilled = "bell.fill"
    case bellCircled = "bell.circle.fill"
    
    case tagFilled = "tag.fill"
    case tagCircled = "tag.circle.fill"
    case tagSlashed = "tag.slash.fill"
    
    case bookmark = "bookmark"
    case bookmarkFilled = "bookmark.fill"
    case bookmarkCircled = "bookmark.circle"
    case bookmarkCircledFilled = "bookmark.circle.fill"
    case bookmarkSlashed = "bookmark.slash"
    case bookmarkSlashedFilled = "bookmark.slash.fill"
    
    case cartAdd = "cart.badge.plus"
    case walletFilled = "wallet.pass.fill"
    
    case diceFilled = "dice.fill"
    case eyedropper = "eyedropper.halffull"  // Fortification symbol
    case stethoscope = "stethoscope"
    case stethoscopeCircled = "stethoscope.circle.fill" // Health sign
    
    case poweroutletTypeF = "poweroutlet.type.f" // Robot Sign for Chat Bot
    
    case firstAid = "cross.case"
    case firstAidFilled = "cross.case.fill" // Supplement
    case firstAidCircled = "cross.case.circle.fill"
    
    case fryingpan = "frying.pan"
    case fryingpanFilled = "frying.pan.fill"
    
    case pinCircled = "pin.circle"
    case pinCircledFilled = "pin.circle.fill"
    case pinFilled = "pin.fill"
    case pinSlashed = "pin.slash.fill"
    
    case crown = "crown"
    case crownFilled = "crown.fill"
    
    case carrot = "carrot"
    case carrotFilled = "carrot.fill"
    
    case fish = "fish"
    case fishFilled = "fish.fill"
    case fishCircled = "fish.circle"
    case fishCircledFilled = "fish.circle.fill"
    
    case shell = "fossil.shell"
    case shellFilled = "fossil.shell.fill"
    
    case drop = "drop"
    case dropFilled = "drop.fill"
    case dropCircled = "drop.circle"
    case dropCircledFilled = "drop.circle.fill"  // Water
    case dropSlashed = "drop.degreesign.slash"
    case dropSlashedFilled = "drop.degreesign.slash.fill"
    case dropDegreeFilled = "drop.degreesign.fill"
    
    
    case scalemass = "scalemass"
    case scalemassFilled = "scalemass.fill" // Weight Indicator
    
    case battery100 = "battery.100"
    case battery75 = "battery.75"
    case battery50 = "battery.50"
    case battery25 = "battery.25"
    case battery0 = "battery.0"
    case batteryCharging = "battery.100.bolt"
    
    case power = "power"
    case powerCircled = "power.circle"
    case powerCircledFilled = "power.circle.fill"
    
    case oilcan = "oilcan"
    case oilcanFilled = "oilcan.fill"
    
    case game = "gamecontroller"
    case gameFilled = "gamecontroller.fill"
    
    case brain = "brain"
    case brainHead = "brain.head.profile"
    
    case rupee = "indianrupeesign"
    case rupeeCircled = "indianrupeesign.circle"
    case rupeeCircledFilled = "indianrupeesign.circle.fill"
    
    var name: String { rawValue }
}

public enum LabelErrors: Error {
    case imageNotFound(description: String)
    case videoNotFound(description: String)
    case contentNotFound(description: String)
}

@available(iOS 15.0, *)
public struct Labels {
    public static let screen = UIScreen.main.bounds
    
    public static let unlike: some View = image(for: .unlike)
    public static let like: some View = image(for: .like, withColor: .red)
    public static let comment: some View = image(for: .comment).rotation3DEffect(Angle.degrees(180), axis: (x: 0, y: 1, z: 0))
    public static let share: some View = image(for: .share)
    public static let verified: some View = image(for: .checkmarkSealFilled)
    public static let verifiedBlue: some View = image(for: .checkmarkSealFilled, withColor: .blue)
    
    public static let passwordVisible: some View = image(for: .eyeOpen)
    public static let passwordInvisible: some View = image(for: .eyeClosed)
    
    public static let userNameLabelFont: Font = Font.headline.weight(.semibold)
    public static let search: some View = image(for: .search)
    
    public static func image(for label: LabelType) -> some View {
        image(for: label, withColor: .black)
    }
    
    public static func image(for label: LabelType, withColor color: Color) -> some View {
        Image(systemName: label.rawValue).foregroundColor(color)
    }
    
    public static func image(for label: LabelType, withFont: Font, withColor color: Color) -> some View {
        image(for: label, withColor: color)
    }
    
    public static func roundButton(for label: LabelType, backgroundColor: Color, foregroundColor: Color) -> some View {
        ZStack {
            Circle()
                .foregroundColor(backgroundColor)
                .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
            image(for: label, withFont: .largeTitle.weight(.thin), withColor: foregroundColor)
        }
    }
}

//
//  BadgeView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/28/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct BadgeView: View {
    var badge: Badge
    
    public var body: some View {
        HStack {
            Text(badge.text)
                .font(badge.textFont)
                .textFieldify(heightScaling: badge.scaling, backgroundColor: UIColor(badge.textColors.background))
                .foregroundColor(badge.textColors.foreground)
            Image(systemName: badge.icon)
                .symbolRenderingMode(.palette)
                .foregroundStyle(badge.iconColors.foreground, badge.iconColors.background)
                .font(badge.iconFont)
        }
        .frame(width: Constants.Width/3)
        .shadowify()
    }
}

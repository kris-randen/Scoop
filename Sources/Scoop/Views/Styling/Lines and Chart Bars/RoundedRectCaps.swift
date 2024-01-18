//
//  RoundedRectCaps.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct RoundedRectCaps: View {
    var line: RoundedRect
    
    public init(line: RoundedRect) {
        self.line = line
    }
    
    public var body: some View {
        ZStack {
            RoundedRectTopRightCap(line: line)
            RoundedRectTopLeftCap(line: line)
            RoundedRectBottomLeftCap(line: line)
            RoundedRectBottomRightCap(line: line)
        }
    }
}

@available(iOS 15.0, *)
public struct RoundedRectCaps_Previews: PreviewProvider {
    public static var previews: some View {
        RoundedRectCaps(line: RoundedRect(x: 0, y: 0, width: 100, height: 400, radiusScaling: 0.3))
    }
}

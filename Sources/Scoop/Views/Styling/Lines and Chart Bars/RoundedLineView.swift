//
//  RoundedLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/24/22.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct RoundedLineView: View {
    var line: CGRect
    var orientation: CGRect.Orientation
    
    public init(line: CGRect, orientation: CGRect.Orientation) {
        self.line = line
        self.orientation = orientation
    }
    
    var radius: CGFloat {
        switch orientation {
        case .vertical:
            return line.width/2
        case .horizontal:
            return line.height/2
        }
    }
    
    public var body: some View {
        ZStack {
            Line(line: line)
            LineCaps(line: line, orientation: orientation)
        }
    }
}

@available(iOS 15.0, *)
public struct RoundedLine_Previews: PreviewProvider {
    public static var previews: some View {
        RoundedLineView(line: CGRect(x: 100, y: 0, width: 30, height: 10), orientation: .vertical)
    }
}

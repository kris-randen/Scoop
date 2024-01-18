//
//  Line.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/25/22.
//

import SwiftUI

@available(iOS 15.0.0, *)
public struct Line: View {
    var line: CGRect
    
    public var body: some View {
        Path { path in
            path.move(to: line.topLeftGlobal)
            path.addLine(to: line.bottomLeftGlobal)
            path.addLine(to: line.bottomRightGlobal)
            path.addLine(to: line.topRightGlobal)
            path.addLine(to: line.topLeftGlobal)
        }
    }
}

@available(iOS 15.0, *)
public struct Line_Previews: PreviewProvider {
    public static var previews: some View {
        Line(line: CGRect(x: 100, y: 0, width: 45, height: 400))
    }
}

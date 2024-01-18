//
//  CardView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct CardView: View {
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Colors.scoopYellow)
                .opacity(0.70)
                .shadowify(x: 5, y: 5)
            GeometryReader { geo in
                let verticalLine = VerticalLine(origin: geo.frame(in: .local).origin, length: geo.size.height, width: 2)
                    .offset(x: -1, y: 0)
                ForEach((0...20), id: \.self) { i in
                    verticalLine.offset(x: CGFloat(i)*(geo.size.width/20), y: 0)
                        .foregroundColor(color(line: i))
                        .opacity(opacity(line: i))
                    }
                
                let horizontalLine = HorizontalLine(origin: geo.frame(in: .local).origin, length: geo.size.width, width: 2)
                    .offset(x: 0, y: -1)
                ForEach((0...40), id: \.self) { i in
                    horizontalLine.offset(x: 0, y: CGFloat(i)*(geo.size.height/40))
                        .foregroundColor(color(line: i))
                        .opacity(opacity(line: i))
                    }
            }
            .mask(
                RoundedRectangle(cornerRadius: 20)
            )
        }
    }
    
    func opacity(line: Int) -> Double {
        line % 4 == 0 ? 0.07 : 0.05
    }
    
    func color(line: Int) -> Color {
        line % 4 == 0 ? .black : Colors.scoopRed
    }
}

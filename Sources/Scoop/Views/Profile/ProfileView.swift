//
//  ProfileView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ProfileView: View {
    public var body: some View {
        ZStack {
            GeometryReader { geo in
                CardView()
                VStack {
                    foodItemAndNQI()
                    Spacer()
                    charTitle()
                        .padding(.horizontal)
                    Spacer()
                    Spacer()
                    chart()
                }
            }
        }
        .padding()
    }
    
    fileprivate func foodItemAndNQI() -> some View {
        Text("𝘀𝗰𝗼𝗼𝗽 🦉🌈 𝖢𝗈𝗋𝖾  𝗡𝗤𝗜 = 𝟥𝟤𝟪")
            .underline(true, color: .black)
            .padding(.vertical)
    }
    
    fileprivate func charTitle() -> some View {
        HStack {
            Text("𝟮𝟬𝟬𝟬 𝖢𝖺𝗅")
            Spacer()
            Text("𝗠𝗶𝗰𝗿𝗼𝘀")
            Spacer()
        }
    }
    
    fileprivate func chart() -> some View {
        HStack(alignment: .center) {
            axisTitles()
            yAxis()
            chartBars()
            .foregroundColor(Colors.scoopGreen)
        }
    }
    
    fileprivate func axisTitles() -> some View {
        VStack {
            ForEach(Nutrient.Micro.Vitamin.allCases, id: \.name) { vitamin in
                VStack{
                    Text(vitamin.name)
                        .font(Fonts.CardNutrient)
                    Text("(\(vitamin.compound)")
                        .font(Fonts.CardNutrientSubtitle)
                    Spacer()
                }
            }
        }
    }
    
    fileprivate func yAxis() -> some View {
        FlexibleVerticalLine(offset: CGPoint(x: 0, y: 0), lengthScaling: 1, width: 10)
            .foregroundColor(Colors.scoopRed)
            .frame(width: 35)
    }
    
    fileprivate func chartBars() -> some View {
        VStack {
            ForEach(Nutrient.Micro.Vitamin.allCases, id: \.name) { vitamin in
                VStack(alignment: .leading){
                    FlexibleHorizontalLine(offset: CGPoint(x: 0, y: 0), lengthScaling: 0.85, width: 25)
                    Text("𝟭𝟴𝗫 𝖱𝖾𝗊𝗎𝗂𝗋𝖾𝗆𝖾𝗇𝗍")
                        .foregroundColor(Colors.scoopRed)
                    Spacer()
                }
            }
        }
    }
}

//
//  Chart.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import Foundation
import SwiftUI
import OrderedCollections

@available(iOS 15.0, *)
public struct Chart {
    public enum Orientation {
        case horizontal, vertical
    }
    
    public struct Bar {
        let name: String
        let compound: String
        let unit: String
        let value: Double
        let nutrient: any NutrientType
        var kind: Nutrient.Kind = .vitamin
        var scaled: Double = 0
        
        public init(nutrient: any NutrientType, intake: Double, kind: Nutrient.Kind) {
            self.nutrient = nutrient
            self.name = nutrient.display
            self.compound = nutrient.compound
            self.unit = nutrient.unit.description
            self.value = intake
            self.kind = kind
        }
        
        public init(nutrient: any NutrientType, intake: Double, kind: Nutrient.Kind, scaled: Double) {
            self.init(nutrient: nutrient, intake: intake, kind: kind)
            self.scaled = scaled
        }
        
        
        public init(nutrient: VitaminIntakes.NutrientKey, intake: Double, scaled: Double) {
            self.init(nutrient: nutrient as VitaminIntakes.NutrientKey, intake: intake, kind: .vitamin, scaled: scaled)
        }
        
        public init(nutrient: MineralIntakes.NutrientKey, intake: Double, scaled: Double) {
            self.init(nutrient: nutrient as MineralIntakes.NutrientKey, intake: intake, kind: .mineral, scaled: scaled)
        }
        
        public init(nutrient: MacroIntakes.NutrientKey, intake: Double, scaled: Double) {
            self.init(nutrient: nutrient as MacroIntakes.NutrientKey, intake: intake, kind: .macro, scaled: scaled)
        }
        
        public var legend: String {
            guard value != 0 else { return name }
            return nutrient.required ? "Required" : "Allowed"
        }
        
        public var color: Color {
            guard value != 0 else { return Color.black }
            return nutrient.required ? Colors.scoopGreen : Color.black
        }
        
        public var legendColor: Color {
            guard value != 0 else { return Colors.scoopBlue }
            return nutrient.required ? Colors.scoopRed : Color.black
        }
    }
    
    public static let zeroVitaminBars = [
        Bar(nutrient: .a, intake: 0, scaled: 0),
        Bar(nutrient: .d, intake: 0, scaled: 0),
        Bar(nutrient: .e, intake: 0, scaled: 0),
        Bar(nutrient: .k, intake: 0, scaled: 0),
        Bar(nutrient: .b9, intake: 0, scaled: 0),
        Bar(nutrient: .b12, intake: 0, scaled: 0),
        Bar(nutrient: .c, intake: 0, scaled: 0),
        Bar(nutrient: .b1, intake: 0, scaled: 0),
        Bar(nutrient: .b2, intake: 0, scaled: 0),
        Bar(nutrient: .b3, intake: 0, scaled: 0),
        Bar(nutrient: .b4, intake: 0, scaled: 0),
        Bar(nutrient: .b5, intake: 0, scaled: 0),
        Bar(nutrient: .b6, intake: 0, scaled: 0),
        Bar(nutrient: .b7, intake: 0, scaled: 0)
    ]
    
    public static let zeroMineralBars = [
        Bar(nutrient: .Na, intake: 0, scaled: 0),
        Bar(nutrient: .Fe, intake: 0, scaled: 0),
        Bar(nutrient: .Mg, intake: 0, scaled: 0),
        Bar(nutrient: .Ca, intake: 0, scaled: 0),
        Bar(nutrient: .I, intake: 0, scaled: 0),
        Bar(nutrient: .Se, intake: 0, scaled: 0),
        Bar(nutrient: .Zn, intake: 0, scaled: 0),
        Bar(nutrient: .Cu, intake: 0, scaled: 0),
        Bar(nutrient: .Mn, intake: 0, scaled: 0),
        Bar(nutrient: .Cr, intake: 0, scaled: 0),
        Bar(nutrient: .Mo, intake: 0, scaled: 0),
        Bar(nutrient: .P, intake: 0, scaled: 0),
        Bar(nutrient: .F, intake: 0, scaled: 0),
        Bar(nutrient: .K, intake: 0, scaled: 0),
        Bar(nutrient: .Cl, intake: 0, scaled: 0)
    ]
    
    public static let zeroMacroBars = [
        Bar(nutrient: .sugar, intake: 0, scaled: 0),
        Bar(nutrient: .cholesterol, intake: 0, scaled: 0),
        Bar(nutrient: .transFat, intake: 0, scaled: 0),
        Bar(nutrient: .carbs, intake: 0, scaled: 0),
        Bar(nutrient: .fats, intake: 0, scaled: 0),
        Bar(nutrient: .fiber, intake: 0, scaled: 0)
    ]
    
    public static func zeroBars(for nutrients: [any NutrientType], kind: Nutrient.Kind) -> [Bar] {
        nutrients.map {Bar.init(nutrient: $0, intake: 0, kind: kind, scaled: 0)}
    }
    
    public static func bars(for intakes: some Intakeable, kind: Nutrient.Kind) -> [Bar] {
//        return intakes.intakes.sortedByValues(ascending: false).map { Bar.init(nutrient: $0, intake: $1, kind: kind) }
        return intakes.intakes.map { Bar.init(nutrient: $0, intake: $1, kind: kind) }
    }
    
    public static func barsAll(for intakes: some Intakeable, kind: Nutrient.Kind) -> [Bar] {
        switch kind {
        case .vitamin:
            guard let intakes = intakes as? VitaminIntakes else { return Chart.zeroVitaminBars }
            return bars(for: intakes, kind: kind)
            
        case .mineral:
            guard let intakes = intakes as? MineralIntakes else { return Chart.zeroMineralBars }
            return bars(for: intakes, kind: kind)
            
        case .macro:
            guard let intakes = intakes as? MacroIntakes else { return Chart.zeroMacroBars }
            return bars(for: intakes, kind: kind)
        default:
            guard let intakes = intakes as? MacroIntakes else { return Chart.zeroMacroBars }
            return bars(for: intakes, kind: kind)
        }
    }
    
    public static func nutrientsComplement(for intakes: some Intakeable, kind: Nutrient.Kind) -> [any NutrientType] {
        switch kind {
        case .vitamin:
            let allVitamins = Nutrient.Micro.Vitamin.allCases
            guard let intakes = intakes as? VitaminIntakes else { return allVitamins }
            return allVitamins.filter { !intakes.intakes.keys.contains($0) }
            
        case .mineral:
            let allMinerals = Nutrient.Micro.Mineral.allCases
            guard let intakes = intakes as? MineralIntakes else { return allMinerals }
            return allMinerals.filter { !intakes.intakes.keys.contains($0) }
            
        case .macro:
            let allMacros = Nutrient.Macro.allCases
            guard let intakes = intakes as? MacroIntakes else { return allMacros }
            return allMacros.filter { !intakes.intakes.keys.contains($0) }
        default:
            let allMacros = Nutrient.Macro.allCases
            guard let intakes = intakes as? MacroIntakes else { return allMacros }
            return allMacros.filter { !intakes.intakes.keys.contains($0) }
        }
    }
    
    let item: String
    let nqi: Double
    let energy: Int = Int(Constants.DRI.energy)
    let title: (title: String, subtitle: String)
    var bars = [Bar]()
    let kind: Nutrient.Kind
    
    public init(profile: NutrientProfile, kind: Nutrient.Kind, nqi: Double = 0) {
        self.item = profile.description.lowercased().capitalized
        self.nqi = profile.nqi
        self.title = kind.chartTitle
        self.kind = kind
        
        switch kind {
        case .vitamin:
//            for (nutrient, intake, scaled) in profile.intakesAndScaledVitamin.sorted(by: {$0.nutrient < $1.nutrient}) {
            for (nutrient, intake, scaled) in profile.intakesAndScaledVitamin.sorted(by: {$0.value > $1.value}) {
                self.bars.append(Bar(nutrient: nutrient, intake: intake, scaled: scaled))
            }
            
        case .mineral:
//            for (nutrient, intake, scaled) in profile.intakesAndScaledMineral.sorted(by: {$0.nutrient < $1.nutrient}) {
            for (nutrient, intake, scaled) in profile.intakesAndScaledMineral.sorted(by: {$0.value > $1.value}) {
                self.bars.append(Bar(nutrient: nutrient, intake: intake, scaled: scaled))
            }
            
        case .macro:
//            for (nutrient, intake, scaled) in profile.intakesAndScaledMacro.sorted(by: {$0.nutrient < $1.nutrient}) {
            for (nutrient, intake, scaled) in profile.intakesAndScaledMacro.sorted(by: {$0.value > $1.value}) {
                self.bars.append(Bar(nutrient: nutrient, intake: intake, scaled: scaled))
            }
        default:
            for (nutrient, intake, scaled) in profile.intakesAndScaledMacro.sorted(by: {$0.nutrient < $1.nutrient}) {
                self.bars.append(Bar(nutrient: nutrient, intake: intake, scaled: scaled))
            }
        }
    }
    
    var displayBars: [Nutrient.Macro] {
        Nutrient.Macro.allCases
    }
    
    func barWidth(for size: CGSize) -> CGFloat {
        min(25, (size.height * 0.5 / CGFloat(self.bars.count)))
    }
}

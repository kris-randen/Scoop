//
//  NutrientIntakes.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation
//import Collections
import OrderedCollections

@available(iOS 15.0, *)
public typealias Intake = (any NutrientType, Double)
@available(iOS 15.0, *)
public typealias MacroIntake = (Nutrient.Macro, Double)
@available(iOS 15.0, *)
public typealias VitaminIntake = (Nutrient.Micro.Vitamin, Double)
@available(iOS 15.0, *)
public typealias MineralIntake = (Nutrient.Micro.Mineral, Double)
@available(iOS 15.0, *)
public typealias IntakesMacro = OrderedDictionary<Nutrient.Macro, Double>
@available(iOS 15.0, *)
public typealias IntakesVitamin = OrderedDictionary<Nutrient.Micro.Vitamin, Double>
@available(iOS 15.0, *)
public typealias IntakesMineral = OrderedDictionary<Nutrient.Micro.Mineral, Double>
@available(iOS 15.0, *)
public typealias MacroIntakeAndScaled = (nutrient: Nutrient.Macro, value: Double, scaled: Double)
@available(iOS 15.0, *)
public typealias VitaminIntakeAndScaled = (nutrient: Nutrient.Micro.Vitamin, value: Double, scaled: Double)
@available(iOS 15.0, *)
public typealias MineralIntakeAndScaled = (nutrient: Nutrient.Micro.Mineral, value: Double, scaled: Double)

public protocol DailyValueScaleable {
    func scaledByDV() -> Self
}

public protocol Scalable {
    func scaledTo(factor: Double) -> Self
}


@available(iOS 15.0, *)
public protocol Intakeable: Multipliable, NQIconvertible, Scalable, DailyValueScaleable {
    associatedtype NutrientKey: NutrientType
    typealias Intakes = OrderedDictionary<NutrientKey, Double>
    var intakes: Intakes { get set }
    var kind: Nutrient.Kind { get }
    var nqi: Double { get }
    
    var positives: Intakes { get }
    var negatives: Intakes { get }
    
    init()
    init(intakes: Intakes)
}

@available(iOS 15.0, *)
public extension Intakeable {
    mutating func multiply(_ factor: Double) {
        self.intakes = factor * self.intakes
    }
    
    func convertedToNQI(for energy: Energy) -> Self {
        var nqiIntakes = Intakes()
        for (nutrient, value) in intakes {
            nqiIntakes[nutrient] = nutrient.nqiFactor(with: energy) * value / nutrient.dailyValue
        }
        return Self.init(intakes: nqiIntakes)
    }
    
    func scaledTo(factor: Double) -> Self {
        return factor * self
    }
    
    func scaledByDV() -> Self {
        var scaledIntakes = Intakes()
        for (nutrient, value) in intakes {
            scaledIntakes[nutrient] = value / nutrient.dailyValue
        }
        return Self.init(intakes: scaledIntakes)
    }
}

@available(iOS 15.0, *)
public extension OrderedDictionary where Key: NutrientType, Value == Double {
    var nqi: Double {
        self.reduce(0) { sum, intake in
            sum + (intake.key.nqiMultiplier * intake.value)
        }
    }
}

@available(iOS 15.0, *)
public extension Intakeable {
    init(intakes: Intakes) {
        self.init()
        self.intakes = intakes
    }
    
    var nqi: Double { intakes.nqi }
    
    var positives: Intakes {
        intakes.filter{$0.key.required}
    }
    
    var numPositives: Int {
        positives.count
    }
    
    var negatives: Intakes {
        intakes.filter{!$0.key.required}
    }
    
    var numNegatives: Int {
        negatives.count
    }
    
    var positiveNQI: Double { positives.nqi }
    
    var negativeNQI: Double { negatives.nqi }
}

@available(iOS 15.0, *)
public protocol Intakeables: Multipliable, NQIconvertible, Scalable, DailyValueScaleable {
    var intakes: OrderedDictionary<Nutrient.Kind, any Intakeable> { get set }
    var nqi: Double { get }
    
    init()
    init(intakes: OrderedDictionary<Nutrient.Kind, any Intakeable>)
}

@available(iOS 15.0, *)
public extension Intakeables {
    init(intakes: OrderedDictionary<Nutrient.Kind, any Intakeable>) {
        self.init()
        self.intakes = intakes
    }
    
    var numPositives: Int {
        let num = intakes.reduce(0) { sum, intake in
            sum + intake.value.numPositives
        }
        print("Number of positives = \(num)")
        return num
    }
    
    var numNegatives: Int {
        intakes.reduce(0) { sum, intake in
            sum + intake.value.numNegatives
        }
    }
    
    var positiveNQI: Double {
        intakes.reduce(0) { sum, intake in
            sum + intake.value.positiveNQI
        }
    }
    
    var negativeNQI: Double {
        let neg = intakes.reduce(0) { sum, intake in
            sum + intake.value.negativeNQI
        }
        print("Negative NQI = \(neg)")
        return neg
    }
    
    var nqi: Double {
        positiveNQI + Double(numPositives) * negativeNQI
    }
    
    func scaledTo(factor: Double) -> Self {
        return self * factor
    }
    
    func scaledByDV() -> Self {
        return Self.init(intakes: [
            .macro: self.intakes[.macro]!.scaledByDV(),
            .vitamin: self.intakes[.vitamin]!.scaledByDV(),
            .mineral: self.intakes[.mineral]!.scaledByDV()
        ])
    }
}

@available(iOS 15.0, *)
public struct NutrientIntakes: Intakeables {
    public init() {
        self.intakes = [
            .macro: Nutrient.Macro.zeroIntakes,
            .vitamin: Nutrient.Micro.Vitamin.zeroIntakes,
            .mineral: Nutrient.Micro.Mineral.zeroIntakes
        ]
    }
    
    public typealias Intakes = OrderedDictionary<Nutrient.Kind, any Intakeable>
    public var intakes: Intakes
    
    mutating public func multiply(_ factor: Double) {
        self.intakes = [
            .macro: factor * (self.intakes[.macro] as! MacroIntakes),
            .vitamin: factor * (self.intakes[.vitamin] as! VitaminIntakes),
            .mineral: factor * (self.intakes[.mineral] as! MineralIntakes)
        ]
    }
    
    public func convertedToNQI(for energy: Energy) -> Self {
        var nqiIntakes = Intakes()
        nqiIntakes[.macro] = intakes[.macro]!.convertedToNQI(for: energy)
        nqiIntakes[.vitamin] = intakes[.vitamin]!.convertedToNQI(for: energy)
        nqiIntakes[.mineral] = intakes[.mineral]!.convertedToNQI(for: energy)
        return Self.init(intakes: nqiIntakes)
    }
    
}

@available(iOS 15.0, *)
public protocol NQIconvertible {
    func convertedToNQI(for energy: Energy) -> Self
}

@available(iOS 15.0, *)
public struct MacroIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Macro
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .macro
    
    public init() {
        
    }
    
    public var negatives: Intakes {
        var negs = self.intakes.filter {!$0.key.required}
        if self.intakes[.fiber] ?? 0 > 1 {
            negs.removeValue(forKey: .carbs)
        }
        return negs
    }
}

@available(iOS 15.0, *)
public struct VitaminIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Micro.Vitamin
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .vitamin
    
    public init(intakes: Intakes, kind: Nutrient.Kind) {
        self.intakes = intakes
        self.kind = kind
    }
    
    public init() {}
}

@available(iOS 15.0, *)
public struct VitaminAIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Micro.Vitamin.A
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .vitaminA
    
    public init(intakes: Intakes, kind: Nutrient.Kind) {
        self.intakes = intakes
        self.kind = kind
    }
    
    public init() {}
}

@available(iOS 15.0, *)
public struct VitaminDIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Micro.Vitamin.D
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .vitaminD
    
    public init(intakes: Intakes, kind: Nutrient.Kind) {
        self.intakes = intakes
        self.kind = kind
    }
    
    public init() {}
}

@available(iOS 15.0, *)
public struct VitaminEIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Micro.Vitamin.E
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .vitaminE
    
    public init(intakes: Intakes, kind: Nutrient.Kind) {
        self.intakes = intakes
        self.kind = kind
    }
    
    public init() {}
}

@available(iOS 15.0, *)
public struct VitaminKIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Micro.Vitamin.K
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .vitaminK
    
    public init(intakes: Intakes, kind: Nutrient.Kind) {
        self.intakes = intakes
        self.kind = kind
    }
    
    public init() {}
}


@available(iOS 15.0, *)
public struct MineralIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Micro.Mineral
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .mineral
    
    public init(intakes: Intakes, kind: Nutrient.Kind) {
        self.intakes = intakes
        self.kind = kind
    }
    
    public init() {}
}

@available(iOS 15.0, *)
public struct SugarIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Macro.Sugar
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .macro
    
    public init(intakes: Intakes, kind: Nutrient.Kind) {
        self.intakes = intakes
        self.kind = kind
    }
    
    public init() {}
    
    public var negatives: Intakes {
        self.intakes.filter {!$0.key.required}
    }
}

@available(iOS 15.0, *)
public struct CarbIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Macro.Carb
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .macro
    
    public init(intakes: Intakes, kind: Nutrient.Kind) {
        self.intakes = intakes
        self.kind = kind
    }
    
    public init() {}
    
    public var negatives: Intakes {
        self.intakes.filter {!$0.key.required}
    }
}

@available(iOS 15.0, *)
public struct FatIntakes: Intakeable {
    public typealias NutrientKey = Nutrient.Macro.Fat
    public typealias Intakes = OrderedDictionary<NutrientKey, Double>
    public var intakes: Intakes = Intakes()
    public var kind: Nutrient.Kind = .macro
    
    public init(intakes: Intakes, kind: Nutrient.Kind) {
        self.intakes = intakes
        self.kind = kind
    }
    
    public init() {}
    
    public var negatives: Intakes {
        self.intakes.filter {!$0.key.required}
    }
}

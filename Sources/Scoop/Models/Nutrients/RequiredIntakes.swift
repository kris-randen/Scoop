//
//  RequiredIntakes.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/25/22.
//

import Foundation
//import Collections
import OrderedCollections

@available(iOS 15.0, *)
public enum Level: CaseIterable, Codable, Equatable {
    case ai
    case ui
    case dv
}

@available(iOS 15.0, *)
public protocol RequireableIntakes {
    var daily: OrderedDictionary<Level, GenderizableIntakes> { get set }
}

@available(iOS 15.0, *)
public protocol GenderizableIntakes {
    var genderIntake: OrderedDictionary<Demography.GenderAndLifeStage, AgeGroupIntakes> { get set }
}

@available(iOS 15.0, *)
public enum NutrientValueType {
    case value
    case scaled
    case nqi
}

@available(iOS 15.0, *)
public protocol AgeGroupableIntakes {
    associatedtype Group: Hashable
    var intakes: OrderedDictionary<Group, NutrientIntakes> { get set }
}

@available(iOS 15.0, *)
public struct AgeGroupIntakes: AgeGroupableIntakes {
    public typealias Group = Demography.AgeGroup
    public var intakes: OrderedDictionary<Demography.AgeGroup, NutrientIntakes>
}

@available(iOS 15.0, *)
public struct GenderIntakes: GenderizableIntakes {
    public var genderIntake: OrderedDictionary<Demography.GenderAndLifeStage, AgeGroupIntakes>
}

@available(iOS 15.0, *)
public struct RequiredIntakes: RequireableIntakes {
    public var daily: OrderedDictionary<Level, GenderizableIntakes>
}

@available(iOS 15.0, *)
public struct Intakes {
    public static let required = RequiredIntakes(
        daily: [
            .ai: GenderIntakes(genderIntake: [
                .male : AgeGroupIntakes(
                    intakes: [
                        .baby: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 400, .c: 40, .d: 10, .e: 4, .k: 2, .b1: 0.2, .b2: 0.3,
                                .b3: 2, .b6: 0.1, .b9: 65, .b12: 0.4, .b5: 1.7, .b7: 5, .b4: 125
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 200, .Cr: 0.2, .Cu: 200, .F: 0.01, .I: 110, .Fe: 30, .Mg: 30, .Mn: 0.003,
                                .Mo: 2, .P: 100, .Se: 15, .Zn: 2, .K: 400, .Na: 110, .Cl: 0.18
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 0.7, .carbs: 60, .fats: 31, .linoleicAcid: 4.4, .aLinoleicAcid: 0.5, .protein: 9.1
                            ])
                        ]),
                        .infant: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 500, .c: 40, .d: 10, .e: 4, .k: 2, .b1: 0.3, .b2: 0.4,
                                .b3: 4, .b6: 0.3, .b9: 80, .b12: 0.5, .b5: 1.8, .b7: 6, .b4: 150
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 260, .Cr: 5.5, .Cu: 220, .F: 0.5, .I: 130, .Fe: 11, .Mg: 75, .Mn: 0.6,
                                .Mo: 3, .P: 275, .Se: 20, .Zn: 3, .K: 860, .Na: 370, .Cl: 0.57
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 0.8, .carbs: 95, .fats: 30, .linoleicAcid: 4.6, .aLinoleicAcid: 0.5, .protein: 11
                            ])
                        ]),
                        .toddler: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 300, .c: 15, .d: 15, .e: 6, .k: 30, .b1: 0.5, .b2: 0.5,
                                .b3: 6, .b6: 0.5, .b9: 150, .b12: 0.9, .b5: 2, .b7: 8, .b4: 200
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 700, .Cr: 11, .Cu: 340, .F: 0.7, .I: 90, .Fe: 7, .Mg: 80, .Mn: 1.2,
                                .Mo: 17, .P: 460, .Se: 20, .Zn: 3, .K: 2000, .Na: 800, .Cl: 1.5
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 1.3, .carbs: 130, .fiber: 19, .linoleicAcid: 7, .aLinoleicAcid: 0.7, .protein: 13
                            ])
                        ]),
                        .child: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 400, .c: 25, .d: 15, .e: 7, .k: 55, .b1: 0.6, .b2: 0.6,
                                .b3: 8, .b6: 0.6, .b9: 200, .b12: 1.2, .b5: 3, .b7: 12, .b4: 250
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1000, .Cr: 15, .Cu: 440, .F: 1, .I: 90, .Fe: 10, .Mg: 130, .Mn: 1.5,
                                .Mo: 22, .P: 500, .Se: 30, .Zn: 5, .K: 2300, .Na: 1000, .Cl: 1.9
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 1.7, .carbs: 130, .fiber: 25, .linoleicAcid: 10, .aLinoleicAcid: 0.9, .protein: 19
                            ])
                        ]),
                        .preteen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 600, .c: 45, .d: 15, .e: 11, .k: 60, .b1: 0.9, .b2: 0.9,
                                .b3: 12, .b6: 1, .b9: 300, .b12: 1.8, .b5: 4, .b7: 20, .b4: 375
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1300, .Cr: 25, .Cu: 700, .F: 2, .I: 120, .Fe: 8, .Mg: 240, .Mn: 1.9,
                                .Mo: 34, .P: 1250, .Se: 40, .Zn: 8, .K: 2500, .Na: 1200, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.4, .carbs: 130, .fiber: 31, .linoleicAcid: 12, .aLinoleicAcid: 1.2, .protein: 34
                            ])
                        ]),
                        .teen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 75, .d: 15, .e: 15, .k: 75, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 25, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1300, .Cr: 35, .Cu: 890, .F: 3, .I: 150, .Fe: 11, .Mg: 410, .Mn: 2.2,
                                .Mo: 43, .P: 1250, .Se: 55, .Zn: 11, .K: 3000, .Na: 1500, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.3, .carbs: 130, .fiber: 38, .linoleicAcid: 16, .aLinoleicAcid: 1.6, .protein: 52
                            ])
                        ]),
                        .adult: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 90, .d: 15, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1000, .Cr: 35, .Cu: 900, .F: 4, .I: 150, .Fe: 8, .Mg: 400, .Mn: 2.3,
                                .Mo: 45, .P: 700, .Se: 55, .Zn: 11, .K: 3400, .Na: 1500, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.7, .carbs: 130, .fiber: 38, .linoleicAcid: 17, .aLinoleicAcid: 1.6, .protein: 56
                            ])
                        ]),
                        .middle: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 90, .d: 15, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1000, .Cr: 35, .Cu: 900, .F: 4, .I: 150, .Fe: 8, .Mg: 420, .Mn: 2.3,
                                .Mo: 45, .P: 700, .Se: 55, .Zn: 11, .K: 3400, .Na: 1500, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.7, .carbs: 130, .fiber: 38, .linoleicAcid: 17, .aLinoleicAcid: 1.6, .protein: 56
                            ])
                        ]),
                        .old: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 90, .d: 15, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.7, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1000, .Cr: 30, .Cu: 900, .F: 4, .I: 150, .Fe: 8, .Mg: 420, .Mn: 2.3,
                                .Mo: 45, .P: 700, .Se: 55, .Zn: 11, .K: 3400, .Na: 1500, .Cl: 2
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.7, .carbs: 130, .fiber: 30, .linoleicAcid: 14, .aLinoleicAcid: 1.6, .protein: 56
                            ])
                        ]),
                        .senior: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 90, .d: 20, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.7, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1200, .Cr: 30, .Cu: 900, .F: 4, .I: 150, .Fe: 8, .Mg: 420, .Mn: 2.3,
                                .Mo: 45, .P: 700, .Se: 55, .Zn: 11, .K: 3400, .Na: 1500, .Cl: 1.8
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.7, .carbs: 130, .fiber: 30, .linoleicAcid: 14, .aLinoleicAcid: 1.6, .protein: 56
                            ])
                        ])
                    ]),
                .female: AgeGroupIntakes(
                    intakes: [
                        .baby: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 400, .c: 40, .d: 10, .e: 4, .k: 2, .b1: 0.2, .b2: 0.3,
                                .b3: 2, .b6: 0.1, .b9: 65, .b12: 0.4, .b5: 1.7, .b7: 5, .b4: 125
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 200, .Cr: 0.2, .Cu: 200, .F: 0.01, .I: 110, .Fe: 30, .Mg: 30, .Mn: 0.003,
                                .Mo: 2, .P: 100, .Se: 15, .Zn: 2, .K: 400, .Na: 110, .Cl: 0.18
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 0.7, .carbs: 60, .fats: 31, .linoleicAcid: 4.4, .aLinoleicAcid: 0.5, .protein: 9.1
                            ])
                        ]),
                        .infant: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 500, .c: 40, .d: 10, .e: 4, .k: 2, .b1: 0.3, .b2: 0.4,
                                .b3: 4, .b6: 0.3, .b9: 80, .b12: 0.5, .b5: 1.8, .b7: 6, .b4: 150
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 260, .Cr: 5.5, .Cu: 220, .F: 0.5, .I: 130, .Fe: 11, .Mg: 75, .Mn: 0.6,
                                .Mo: 3, .P: 275, .Se: 20, .Zn: 3, .K: 860, .Na: 370, .Cl: 0.57
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 0.8, .carbs: 95, .fats: 30, .linoleicAcid: 4.6, .aLinoleicAcid: 0.5, .protein: 11
                            ])
                        ]),
                        .toddler: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 300, .c: 15, .d: 15, .e: 6, .k: 30, .b1: 0.5, .b2: 0.5,
                                .b3: 6, .b6: 0.5, .b9: 150, .b12: 0.9, .b5: 2, .b7: 8, .b4: 200
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 700, .Cr: 11, .Cu: 340, .F: 0.7, .I: 90, .Fe: 7, .Mg: 80, .Mn: 1.2,
                                .Mo: 17, .P: 460, .Se: 20, .Zn: 3, .K: 2000, .Na: 800, .Cl: 1.5
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 1.3, .carbs: 130, .fiber: 19, .linoleicAcid: 7, .aLinoleicAcid: 0.7, .protein: 13
                            ])
                        ]),
                        .child: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 400, .c: 25, .d: 15, .e: 7, .k: 55, .b1: 0.6, .b2: 0.6,
                                .b3: 8, .b6: 0.6, .b9: 200, .b12: 1.2, .b5: 3, .b7: 12, .b4: 250
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1000, .Cr: 15, .Cu: 440, .F: 1, .I: 90, .Fe: 10, .Mg: 130, .Mn: 1.5,
                                .Mo: 22, .P: 500, .Se: 30, .Zn: 5, .K: 2300, .Na: 1000, .Cl: 1.9
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 1.7, .carbs: 130, .fiber: 25, .linoleicAcid: 10, .aLinoleicAcid: 0.9, .protein: 19
                            ])
                        ]),
                        .preteen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 600, .c: 45, .d: 15, .e: 11, .k: 60, .b1: 0.9, .b2: 0.9,
                                .b3: 12, .b6: 1, .b9: 300, .b12: 1.8, .b5: 4, .b7: 20, .b4: 375
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1300, .Cr: 21, .Cu: 700, .F: 2, .I: 120, .Fe: 8, .Mg: 240, .Mn: 1.6,
                                .Mo: 34, .P: 1250, .Se: 40, .Zn: 8, .K: 2300, .Na: 1200, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.1, .carbs: 130, .fiber: 26, .linoleicAcid: 10, .aLinoleicAcid: 1.0, .protein: 34
                            ])
                        ]),
                        .teen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 65, .d: 15, .e: 15, .k: 75, .b1: 1, .b2: 1,
                                .b3: 14, .b6: 1.2, .b9: 400, .b12: 2.4, .b5: 5, .b7: 25, .b4: 400
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1300, .Cr: 24, .Cu: 890, .F: 3, .I: 150, .Fe: 15, .Mg: 360, .Mn: 1.6,
                                .Mo: 43, .P: 1250, .Se: 55, .Zn: 9, .K: 2300, .Na: 1500, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.3, .carbs: 130, .fiber: 26, .linoleicAcid: 11, .aLinoleicAcid: 1.1, .protein: 46
                            ])
                        ]),
                        .adult: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 75, .d: 15, .e: 15, .k: 90, .b1: 1.1, .b2: 1.1,
                                .b3: 14, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 425
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1000, .Cr: 25, .Cu: 900, .F: 3, .I: 150, .Fe: 18, .Mg: 310, .Mn: 1.8,
                                .Mo: 45, .P: 700, .Se: 55, .Zn: 8, .K: 2600, .Na: 1500, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.7, .carbs: 130, .fiber: 25, .linoleicAcid: 12, .aLinoleicAcid: 1.1, .protein: 46
                            ])
                        ]),
                        .middle: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 75, .d: 15, .e: 15, .k: 90, .b1: 1.1, .b2: 1.1,
                                .b3: 14, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 425
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1000, .Cr: 25, .Cu: 900, .F: 3, .I: 150, .Fe: 18, .Mg: 320, .Mn: 1.8,
                                .Mo: 45, .P: 700, .Se: 55, .Zn: 8, .K: 2600, .Na: 1500, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.7, .carbs: 130, .fiber: 25, .linoleicAcid: 12, .aLinoleicAcid: 1.1, .protein: 46
                            ])
                        ]),
                        .old: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 75, .d: 15, .e: 15, .k: 90, .b1: 1.1, .b2: 1.1,
                                .b3: 14, .b6: 1.5, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 425
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1200, .Cr: 20, .Cu: 900, .F: 3, .I: 150, .Fe: 8, .Mg: 320, .Mn: 1.8,
                                .Mo: 45, .P: 700, .Se: 55, .Zn: 8, .K: 2600, .Na: 1500, .Cl: 2
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.7, .carbs: 130, .fiber: 21, .linoleicAcid: 11, .aLinoleicAcid: 1.1, .protein: 46
                            ])
                        ]),
                        .senior: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 75, .d: 15, .e: 15, .k: 90, .b1: 1.1, .b2: 1.1,
                                .b3: 14, .b6: 1.5, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 425
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1200, .Cr: 20, .Cu: 900, .F: 3, .I: 150, .Fe: 8, .Mg: 320, .Mn: 1.8,
                                .Mo: 45, .P: 700, .Se: 55, .Zn: 8, .K: 2600, .Na: 1500, .Cl: 1.8
                            ]),
                        ])
                    ]),
                .pregnant: AgeGroupIntakes(intakes: [
                    .teen: NutrientIntakes(intakes: [
                        .vitamin: VitaminIntakes(intakes: [
                            .a: 750, .c: 80, .d: 15, .e: 15, .k: 75, .b1: 1.4, .b2: 1.4,
                            .b3: 18, .b6: 1.9, .b9: 600, .b12: 2.6, .b5: 6, .b7: 30, .b4: 450
                        ]),
                        .mineral: MineralIntakes(intakes: [
                            .Ca: 1300, .Cr: 29, .Cu: 1000, .F: 3, .I: 220, .Fe: 27, .Mg: 400, .Mn: 2,
                            .Mo: 50, .P: 1250, .Se: 60, .Zn: 12, .K: 2600, .Na: 1500, .Cl: 2.3
                        ]),
                        .macro: MacroIntakes(intakes: [
                            .water: 3, .carbs: 175, .fiber: 28, .linoleicAcid: 13, .aLinoleicAcid: 1.4, .protein: 71
                        ])
                    ]),
                    .adult: NutrientIntakes(intakes: [
                        .vitamin: VitaminIntakes(intakes: [
                            .a: 770, .c: 85, .d: 15, .e: 15, .k: 90, .b1: 1.4, .b2: 1.4,
                            .b3: 18, .b6: 1.9, .b9: 600, .b12: 2.6, .b5: 6, .b7: 30, .b4: 450
                        ]),
                        .mineral: MineralIntakes(intakes: [
                            .Ca: 1000, .Cr: 30, .Cu: 1000, .F: 3, .I: 220, .Fe: 27, .Mg: 350, .Mn: 2,
                            .Mo: 50, .P: 700, .Se: 60, .Zn: 11, .K: 2900, .Na: 1500, .Cl: 2.3
                        ]),
                        .macro: MacroIntakes(intakes: [
                            .water: 3, .carbs: 175, .fiber: 28, .linoleicAcid: 13, .aLinoleicAcid: 1.4, .protein: 71
                        ])
                    ]),
                    .middle: NutrientIntakes(intakes: [
                        .vitamin: VitaminIntakes(intakes: [
                            .a: 770, .c: 85, .d: 15, .e: 15, .k: 90, .b1: 1.4, .b2: 1.4,
                            .b3: 18, .b6: 1.9, .b9: 600, .b12: 2.6, .b5: 6, .b7: 30, .b4: 450
                        ]),
                        .mineral: MineralIntakes(intakes: [
                            .Ca: 1000, .Cr: 30, .Cu: 1000, .F: 3, .I: 220, .Fe: 27, .Mg: 360, .Mn: 2,
                            .Mo: 50, .P: 700, .Se: 60, .Zn: 11, .K: 2900, .Na: 1500, .Cl: 2.3
                        ]),
                        .macro: MacroIntakes(intakes: [
                            .water: 3, .carbs: 175, .fiber: 28, .linoleicAcid: 13, .aLinoleicAcid: 1.4, .protein: 71
                        ])
                    ])
                ]),
                .lactating: AgeGroupIntakes(
                    intakes: [
                        .teen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 1200, .c: 115, .d: 15, .e: 19, .k: 75, .b1: 1.4, .b2: 1.6,
                                .b3: 17, .b6: 2, .b9: 500, .b12: 2.8, .b5: 7, .b7: 35, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1300, .Cr: 44, .Cu: 1300, .F: 3, .I: 290, .Fe: 10, .Mg: 360, .Mn: 2.6,
                                .Mo: 50, .P: 1250, .Se: 70, .Zn: 13, .K: 2500, .Na: 1500, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.8, .carbs: 210, .fiber: 29, .linoleicAcid: 13, .aLinoleicAcid: 1.3, .protein: 71
                            ])
                        ]),
                        .adult: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 1300, .c: 120, .d: 15, .e: 19, .k: 90, .b1: 1.4, .b2: 1.6,
                                .b3: 17, .b6: 2, .b9: 500, .b12: 2.8, .b5: 7, .b7: 35, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1000, .Cr: 45, .Cu: 1300, .F: 3, .I: 290, .Fe: 9, .Mg: 310, .Mn: 2.6,
                                .Mo: 50, .P: 700, .Se: 70, .Zn: 12, .K: 2800, .Na: 1500, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.8, .carbs: 210, .fiber: 29, .linoleicAcid: 13, .aLinoleicAcid: 1.3, .protein: 71
                            ])
                        ]),
                        .middle: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 1300, .c: 120, .d: 15, .e: 19, .k: 90, .b1: 1.4, .b2: 1.6,
                                .b3: 17, .b6: 2, .b9: 500, .b12: 2.8, .b5: 7, .b7: 35, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .Ca: 1000, .Cr: 45, .Cu: 1300, .F: 3, .I: 290, .Fe: 9, .Mg: 320, .Mn: 2.6,
                                .Mo: 50, .P: 700, .Se: 70, .Zn: 12, .K: 2800, .Na: 1500, .Cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.8, .carbs: 210, .fiber: 29, .linoleicAcid: 13, .aLinoleicAcid: 1.3, .protein: 71
                            ])
                        ])
                    ])
            ])
        ])
}

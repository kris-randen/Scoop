//
//  User.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import Foundation

public struct Demography {
    public enum AgeGroup: Equatable, Codable {
        case baby, infant
        case toddler, child
        case preteen, teen
        case adult, middle
        case old, senior
        
        static func calculate(fromAgeInMonths age: Int) -> AgeGroup {
            switch age {
            case Int.min...6:
                return .baby
            case 7...(1*12):
                return .infant
            case 13...(3*12):
                return .toddler
            case 37...(8*12):
                return .child
            case 97...(13*12):
                return .preteen
            case 157...(18*12):
                return .teen
            case 217...(30*12):
                return .adult
            case 361...(50*12):
                return .middle
            case 601...(70*12):
                return .old
            default:
                return .senior
            }
        }
    }
    
    public enum GenderAndLifeStage: Equatable, Codable {
        case male
        case female
        case pregnant
        case lactating
    }
}

public protocol Genderizable {
    var gender: Demography.GenderAndLifeStage { get }
}

public protocol AgeGroupable: Equatable, Codable {
    var ageGroup: Demography.AgeGroup { get }
}

public protocol Demographable: Genderizable, AgeGroupable {}

public protocol Nameable {
    var username: String { get set }
    var firstname: String { get set }
    var lastname: String { get set }
    var fullname: String { get }
}

@available(iOS 15.0, *)
public struct Age: Codable, Equatable { //: Ageable {
    public var days: Int
    public var weeks: Double { days.double / 7}
    public var months: Double { days.double / 30 }
    public var years: Double { days.double / 365 }
}

@available(iOS 15.0, *)
public protocol Birthable {
    var dateOfBirth: Date { get set }
    var age: Age { get }
}

public protocol Emailable {
    var email: String { get set }
}

public protocol Callable {
    var cell: String { get set }
}

public struct Address: Codable, Equatable {
    var apartment: String = ""
    var street: String = ""
    var city: String = ""
    var state: String = ""
}

public protocol Imageable {
    var imageURL: String { get set }
}

public protocol Addressable: Nameable, Emailable, Callable, Imageable {
    var address: Address { get set }
}


@available(iOS 15.0, *)
public struct User: Equatable, Codable, Addressable, Birthable, Demographable {
//    @DocumentID var id: String?
    
    public var username: String
    public var firstname: String
    public var lastname: String
    
    public var fullname: String { "\(firstname) \(lastname)" }
    
    public var email: String
    public var cell: String = ""
    
    public var imageURL: String = ""
    
    public var address = Address()
    
    public var dateOfBirth: Date
    public var age: Age {
        Age(days: Int(Date.now.timeIntervalSince(dateOfBirth) / 86400))
    }
    
    public var gender: Demography.GenderAndLifeStage
    
    public var ageGroup: Demography.AgeGroup {
        Demography.AgeGroup.calculate(fromAgeInMonths: age.months.int)
    }
}

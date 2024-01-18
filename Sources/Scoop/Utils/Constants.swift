//
//  Constants.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI
import Foundation

@available(iOS 15.0, *)
public struct Constants {
    public static let space = " "
    public static let colon = ":"
    public static let DEBUG = "DEBUG"
    public static let SUCESS = "SUCCESS"
    public static let FAILURE = "FAILURE"
    
    public static let APIkeyFDC = "SFGVHByt5NbrHT8I8xQyUiAXhNUJKZOAoR783a4g"
    public static let APIurlstringFDC = "https://api.nal.usda.gov/fdc/v1/foods/search"
    public static let fdcServers = "https://api.nal.usda.gov/fdc"
    
    public static let screen = UIScreen.main.bounds
    public static let screenWidth = screen.width
    public static let screenHeight = screen.height
    public static let Bounds = screen
    public static let Width = screenWidth              // iPhone 15 Pro Max Width = 430
    public static let Height = screenHeight            // iPhone 15 Pro Max Height = 932
    public static let MinDim = screen.minDim
    
    public static let instaBlue = Color(red: 81 / 255, green: 91 / 255, blue: 212 / 255)
    public static let instaPurple = Color(red: 129 / 255, green: 52 / 255, blue: 175 / 255)
    public static let instaPink = Color(red: 221 / 255, green: 42 / 255, blue: 123 / 255)
    public static let instaYellow = Color(red: 254 / 255, green: 218 / 255, blue: 119 / 255)
    public static let instaOrange = Color(red: 245 / 255, green: 133 / 255, blue: 41 / 255)
    public static let instaColors = [
                                            instaBlue,
                                            instaPurple,
                                            instaPink,
                                            instaYellow,
                                            instaOrange
                             ]
    public static let instaColorsGradient = [
                                            instaPurple,
                                            instaPink,
                                            instaYellow,
                                            instaOrange,
                                            instaYellow,
                                            instaPink,
                                            instaPurple
                                     ]
    public static let instaColorsLinearGradient = [
                                            instaYellow,
                                            instaPink,
                                            instaPurple,
                                            instaBlue
                                           ]
    
    public static let email = "email"
    public static let username = "username"
    public static let fullname = "fullname"
    public static let profileImageURL = "profileImageURL"
    public static let uID = "uid"
    public static let users = "users"
    public static let followers = "followers"
    public static let following = "following"
    public static let userFollowers = "user-followers"
    public static let userFollowing = "user-following"
    public static let caption = "caption"
    public static let timestamp = "timestamp"
    public static let imageURL = "imageURL"
    public static let likes = "likes"
    public static let posts = "posts"
    public static let userPosts = "user-posts"
    
    public struct FDCunits {
        public static let energy: Set = ["cal", "kcal", "kj"]
        public static let mass: Set = ["kg", "g", "mg", "ug", "grm", "gram", "gm", "mcg_re", "mg_ate", "mg_gae"]
        public static let iu: Set = ["iu"]
        public static let length: Set = ["km", "m","cm", "mm"]
        public static let volume: Set = ["l", "dl", "ml"]
    }
    
    public struct DRI {
        public static let energy: Double = 2000
    }
    
    public struct Units {
        public struct Energy {
            public static let cal = "cal"
            public static let kcal = "kcal"
        }
        
        public struct Mass {
            public static let pg = "pg"
            public static let ng = "ng"
            public static let ug = "ug"
            public static let mg = "mg"
            public static let gm = "gm"
            public static let kg = "kg"
        }
        
        public struct Length {
            public static let pm = "pm"
            public static let ag = "ag"
            public static let nm = "nm"
            public static let um = "um"
            public static let mm = "mm"
            public static let cm = "cm"
            public static let m = "m"
            public static let km = "km"
        }
        
        public struct Volume {
            public static let pl = "pl"
            public static let nl = "nl"
            public static let ul = "ul"
            public static let ml = "ml"
            public static let cl = "cl"
            public static let dl = "dl"
            public static let l = "l"
            public static let kl = "kl"
            
            public static let tsp = "tea spoon"
            public static let tbsp = "table spoon"
            public static let oz = "ounces"
            public static let cup = "cup"
        }
    }
    
    public struct Nutrients {
        public struct Macro {
            public static let protein: Nutrient.Macro = .protein
            public static let energy: Nutrient.Macro = .energy
            public static let fats: Nutrient.Macro = .fats
            public static let carbs: Nutrient.Macro = .carbs
            public static let sugar: Nutrient.Macro = .sugar
            public static let fiber: Nutrient.Macro = .fiber
            public static let epa: Nutrient.Macro = .epa
            public static let dha: Nutrient.Macro = .dha
            public static let linAcid: Nutrient.Macro = .linoleicAcid
            public static let aLinAcid: Nutrient.Macro = .aLinoleicAcid
            public static let saturatedFat: Nutrient.Macro = .saturatedFat
            public static let cholesterol: Nutrient.Macro = .cholesterol
            public static let transFat: Nutrient.Macro = .transFat
            public static let water: Nutrient.Macro = .water
        }
        
        public struct Micro {
            public static let vitaminA: Nutrient.Micro.Vitamin = .a
            public static let vitaminAiu: Nutrient.Micro.Vitamin = .aiu
            public static let vitaminC: Nutrient.Micro.Vitamin = .c
            public static let vitaminD: Nutrient.Micro.Vitamin = .d
            public static let vitaminDiu: Nutrient.Micro.Vitamin = .diu
            public static let vitaminE: Nutrient.Micro.Vitamin = .e
            public static let vitaminEiu: Nutrient.Micro.Vitamin = .eiu
            public static let vitaminK: Nutrient.Micro.Vitamin = .k
            public static let vitaminB1: Nutrient.Micro.Vitamin = .b1
            public static let vitaminB2: Nutrient.Micro.Vitamin = .b2
            public static let vitaminB3: Nutrient.Micro.Vitamin = .b3
            public static let vitaminB4: Nutrient.Micro.Vitamin = .b4
            public static let vitaminB5: Nutrient.Micro.Vitamin = .b5
            public static let vitaminB6: Nutrient.Micro.Vitamin = .b6
            public static let vitaminB7: Nutrient.Micro.Vitamin = .b7
            public static let vitaminB9: Nutrient.Micro.Vitamin = .b9
            public static let vitaminB12: Nutrient.Micro.Vitamin = .b12
            
            public static let calcium: Nutrient.Micro.Mineral = .Ca
            public static let chloride: Nutrient.Micro.Mineral = .Cl
            public static let chromium: Nutrient.Micro.Mineral = .Cr
            public static let copper: Nutrient.Micro.Mineral = .Cu
            public static let fluoride: Nutrient.Micro.Mineral = .F
            public static let iodine: Nutrient.Micro.Mineral = .I
            public static let iron: Nutrient.Micro.Mineral = .Fe
            public static let magnesium: Nutrient.Micro.Mineral = .Mg
            public static let manganese: Nutrient.Micro.Mineral = .Mn
            public static let molybdenum: Nutrient.Micro.Mineral = .Mo
            public static let phosphorous: Nutrient.Micro.Mineral = .P
            public static let potassium: Nutrient.Micro.Mineral = .K
            public static let selenium: Nutrient.Micro.Mineral = .Se
            public static let sodium: Nutrient.Micro.Mineral = .Na
            public static let zinc: Nutrient.Micro.Mineral = .Zn
//            public static let sulfur: Nutrient.Micro.Mineral = .S
        }
        
        
        public struct Name {
            public static let vitaminA = "Vitamin A"
            public static let vitaminAiu = "Vitamin A, IU"
            public static let vitaminB1 = "Vitamin B1"
            public static let vitaminB2 = "Vitamin B2"
            public static let vitaminB3 = "Vitamin B3"
            public static let vitaminB4 = "Vitamin B4"
            public static let vitaminB5 = "Vitamin B5"
            public static let vitaminB6 = "Vitamin B6"
            public static let vitaminB7 = "Vitamin B7"
            public static let vitaminB9 = "Vitamin B9"
            public static let vitaminB12 = "Vitamin B12"
            public static let vitaminC = "Vitamin C"
            public static let vitaminD = "Vitamin D"
            public static let vitaminDiu = "Vitamin D, IU"
            public static let vitaminE = "Vitamin E"
            public static let vitaminEiu = "Vitamin E, IU"
            public static let vitaminK = "Vitamin K"
            
            public static let calcium = "Mineral Ca"
            public static let chloride = "Mineral Cl"
            public static let chromium = "Mineral Cr"
            public static let copper = "Mineral Cu"
            public static let fluoride = "Mineral F"
            public static let iodine = "Mineral I"
            public static let iron = "Mineral Fe"
            public static let magnesium = "Mineral Mg"
            public static let manganese = "Mineral Mn"
            public static let molybdenum = "Mineral Mo"
            public static let phosphorous = "Mineral P"
            public static let potassium = "Mineral K"
            public static let selenium = "Mineral Se"
            public static let sulfur = "Sulfur, S"
            public static let sodium = "Mineral Na"
            public static let zinc = "Mineral Zn"
            
            public static let calories = "Calories"
            public static let energy = "Energy"
            public static let sugar = "Sugar"
            public static let water = "Water"
            public static let carbs = "Carbs"
            public static let carbsGood = "Good Carbs"
            public static let carbsBad = "Bad Carbs"
            public static let fiber = "Fiber"
            public static let fats = "Fats"
            public static let fatsGood = "Good Fats"
            public static let fatsBad = "Bad Fats"
            public static let epa = "Omega-3 EPA"
            public static let dha = "Omega-3 DHA"
            public static let linoleicAcid = "Omega-6 LA"
            public static let aLinoleicAcid = "Omega-6 a-LA"
            public static let protein = "Protein"
            public static let saturatedFat = "Saturated Fat"
            public static let transFat = "Trans Fat"
            public static let cholesterol = "Cholesterol"
            
            public static let macros = [
                Name.calories,      //"Calories"
                Name.energy,        //"Energy"
                Name.sugar,         //"Sugar"
                Name.water,         //"Water"
                Name.carbs,         //"Carbs"
                Name.carbsGood,     //"Good Carbs"
                Name.carbsBad,      //"Bad Carbs"
                Name.fiber,         //"Fiber"
                Name.fats,          //"Fats"
                Name.fatsGood,      //"Good Fats"
                Name.fatsBad,       //"Bad Fats"
                Name.linoleicAcid,  //"Linoleic Acid"
                Name.aLinoleicAcid, //"alpha-Linoleic Acid"
                Name.protein,       //"Protein"
                Name.saturatedFat,  //"Saturated Fat"
                Name.transFat,      //"Trans Fat"
                Name.cholesterol    //"Cholesterol"
            ]
                .map{$0.lowercased()}.set
            
            public static let vitamins = [
                Name.vitaminA,      //"Vitamin A"
                Name.vitaminB1,     //"Vitamin B1"
                Name.vitaminB2,     //"Vitamin B2"
                Name.vitaminB3,     //"Vitamin B3"
                Name.vitaminB4,     //"Vitamin B4"
                Name.vitaminB5,     //"Vitamin B5"
                Name.vitaminB6,     //"Vitamin B6"
                Name.vitaminB7,     //"Vitamin B7"
                Name.vitaminB9,     //"Vitamin B9"
                Name.vitaminB12,    //"Vitamin B12"
                Name.vitaminC,      //"Vitamin C"
                Name.vitaminD,      //"Vitamin D"
                Name.vitaminE,      //"Vitamin E"
                Name.vitaminK       //"Vitamin K"
            ]
                .map{$0.lowercased()}.set
            
            public static let minerals = [
                Name.calcium,
                Name.chloride,
                Name.chromium,
                Name.copper,
                Name.fluoride,
                Name.iodine,
                Name.iron,
                Name.magnesium,
                Name.manganese,
                Name.molybdenum,
                Name.phosphorous,
                Name.potassium,
                Name.selenium,
                Name.sulfur,
                Name.sodium,
                Name.zinc
            ]
                .map{$0.lowercased()}.set
        }
        
        public struct Display {
            public static let vitaminA = "Vitamin A"
            public static let vitaminAiu = "Vitamin A, IU"
            public static let vitaminB1 = "Vitamin B1"
            public static let vitaminB2 = "Vitamin B2"
            public static let vitaminB3 = "Vitamin B3"
            public static let vitaminB4 = "Vitamin B4"
            public static let vitaminB5 = "Vitamin B5"
            public static let vitaminB6 = "Vitamin B6"
            public static let vitaminB7 = "Vitamin B7"
            public static let vitaminB9 = "Vitamin B9"
            public static let vitaminB12 = "Vitamin B12"
            public static let vitaminC = "Vitamin C"
            public static let vitaminD = "Vitamin D"
            public static let vitaminDiu = "Vitamin D, IU"
            public static let vitaminE = "Vitamin E"
            public static let vitaminEiu = "Vitamin E, IU"
            public static let vitaminK = "Vitamin K"
            
            public static let calcium = "Mineral Ca"
            public static let chloride = "Mineral Cl"
            public static let chromium = "Mineral Cr"
            public static let copper = "Mineral Cu"
            public static let fluoride = "Mineral F"
            public static let iodine = "Mineral I"
            public static let iron = "Mineral Fe"
            public static let magnesium = "Mineral Mg"
            public static let manganese = "Mineral Mn"
            public static let molybdenum = "Mineral Mo"
            public static let phosphorous = "Mineral P"
            public static let potassium = "Mineral K"
            public static let selenium = "Mineral Se"
            public static let sulfur = "Sulfur, S"
            public static let sodium = "Mineral Na"
            public static let zinc = "Mineral Zn"
            
            public static let calories = "Calories"
            public static let energy = "Energy"
            public static let sugar = "Sugar"
            public static let water = "Water"
            public static let carbs = "Carbs"
            public static let carbsGood = "Good Carbs"
            public static let carbsBad = "Bad Carbs"
            public static let fiber = "Fiber"
            public static let fats = "Fats"
            public static let fatsGood = "Good Fats"
            public static let fatsBad = "Bad Fats"
            public static let epa = "Omega-3 EPA"
            public static let dha = "Omega-3 DHA"
            public static let linoleicAcid = "Omega-6 LA"
            public static let aLinoleicAcid = "Omega-6 a-LA"
            public static let protein = "Protein"
            public static let saturatedFat = "Saturated Fat"
            public static let transFat = "Trans Fat"
            public static let cholesterol = "Cholesterol"
        }
        
        public struct FDCmap {
            public static let macro = [
                FDCid.protein: Macro.protein,
                FDCid.energy: Macro.energy,
                FDCid.fats: Macro.fats,
                FDCid.carbs: Macro.carbs,
                FDCid.sugar: Macro.sugar,
                FDCid.fiber: Macro.fiber,
                FDCid.epa: Macro.epa,
                FDCid.dha: Macro.dha,
                FDCid.linAcid: Macro.linAcid,
                FDCid.aLinAcid: Macro.aLinAcid,
                FDCid.saturatedFat: Macro.saturatedFat,
                FDCid.transFat: Macro.transFat,
                FDCid.cholesterol: Macro.cholesterol,
                FDCid.water: Macro.water
            ]
            
            public static let vitamin = [
                FDCid.vitaminA: Micro.vitaminA,
//                FDCid.vitaminAiu: Micro.vitaminAiu,
                FDCid.vitaminC: Micro.vitaminC,
                FDCid.vitaminD: Micro.vitaminD,
//                FDCid.vitaminDiu: Micro.vitaminDiu,
                FDCid.vitaminE: Micro.vitaminE,
//                FDCid.vitaminEiu: Micro.vitaminEiu,
                FDCid.vitaminK: Micro.vitaminK,
                FDCid.vitaminB1: Micro.vitaminB1,
                FDCid.vitaminB2: Micro.vitaminB2,
                FDCid.vitaminB3: Micro.vitaminB3,
                FDCid.vitaminB4: Micro.vitaminB4,
                FDCid.vitaminB5: Micro.vitaminB5,
                FDCid.vitaminB6: Micro.vitaminB6,
                FDCid.vitaminB7: Micro.vitaminB7,
                FDCid.vitaminB9: Micro.vitaminB9,
                FDCid.vitaminB12: Micro.vitaminB12
            ]
            
            public static let mineral = [
                FDCid.calcium: Micro.calcium,
                FDCid.chloride: Micro.chloride,
                FDCid.chromium: Micro.chromium,
                FDCid.copper: Micro.copper,
                FDCid.fluoride: Micro.fluoride,
                FDCid.iodine: Micro.iodine,
                FDCid.iron: Micro.iron,
                FDCid.magnesium: Micro.magnesium,
                FDCid.manganese: Micro.manganese,
                FDCid.molybdenum: Micro.molybdenum,
                FDCid.phosphorous: Micro.phosphorous,
                FDCid.potassium: Micro.potassium,
                FDCid.selenium: Micro.selenium,
                FDCid.sodium: Micro.sodium,
                FDCid.zinc: Micro.zinc
//                FDCid.sulfur: Micro.S
            ]
        }
        
        public struct FDCid {
            public static let protein = 1003
            public static let energy = 1008
            public static let fats = 1004
            public static let carbs = 1005
            public static let sugar = 2000
            public static let fiber = 1079
            public static let epa = 1278
            public static let dha = 1272
            public static let linAcid = 1269
            public static let aLinAcid = 1270
            public static let cholesterol = 1253
            public static let water = 1051
            public static let saturatedFat = 1258
            public static let transFat = 1257
            
            public static let vitaminA = 1106
            public static let vitaminAiu = 1104
            public static let vitaminC = 1162
            public static let vitaminD = 1114
            public static let vitaminDiu = 1110
            public static let vitaminE = 1109
            public static let vitaminEiu = 1124
            public static let vitaminK = 1185
            public static let vitaminB1 = 1165
            public static let vitaminB2 = 1166
            public static let vitaminB3 = 1167
            public static let vitaminB4 = 1180
            public static let vitaminB5 = 1170
            public static let vitaminB6 = 1175
            public static let vitaminB7 = 1176
            public static let vitaminB9 = 1177
            public static let vitaminB12 = 1178
            
            public static let calcium = 1087
            public static let chloride = 1088
            public static let iron = 1089
            public static let magnesium = 1090
            public static let phosphorous = 1091
            public static let potassium = 1092
            public static let sodium = 1093
            public static let sulphur = 1094
            public static let zinc = 1095
            public static let chromium = 1096
            public static let copper = 1098
            public static let fluoride = 1099
            public static let iodine = 1100
            public static let manganese = 1101
            public static let molybdenum = 1102
            public static let selenium = 1103
        }
        
        public struct FDCname {
            public static let vitaminAiu = "Vitamin A, IU"
            public static let vitaminArae = "Vitamin A, RAE"
            public static let vitaminEalphat = "Vitamin E (alpha-tocopherol)"
            public static let vitaminD23iu = "Vitamin D (D2 + D3), International Units"
            public static let vitaminD2 = "Vitamin D2 (ergocalciferol)"
            public static let vitaminD3 = "Vitamin D3 (cholecalciferol)"
            public static let vitaminD23 = "Vitamin D (D2 + D3)"
            public static let vitaminElabel = "Vitamin E (label entry primarily)"
            public static let vitaminAre = "Vitamin A, RE"
            public static let vitaminE = "Vitamin E"
            public static let vitaminCtotal = "Vitamin C, total ascorbic acid"
            public static let vitaminCred = "Vitamin C, reduced ascorbic acid"
            public static let vitaminCdehyd = "Vitamin C, dehydro ascorbic acid"
            public static let vitaminB6pyrAlc = "Vitamin B-6, pyridoxine, alcohol form"
            public static let vitaminB6pyrAld = "Vitamin B-6, pyridoxal, aldehyde form"
            public static let vitaminB6pyrAmi = "Vitamin B-6, pyridoxamine, amine form"
            public static let vitaminB6n = "Vitamin B-6, N411 + N412 +N413"
            public static let vitaminB6 = "Vitamin B-6"
            public static let vitaminB12 = "Vitamin B-12"
            public static let vitaminKmenaq = "Vitamin K (Menaquinone-4)"
            public static let vitaminKdihyd = "Vitamin K (Dihydrophylloquinone)"
            public static let vitaminKphyllo = "Vitamin K (phylloquinone)"
            public static let vitaminCadd = "Vitamin C, added"
            public static let vitaminEadd = "Vitamin E, added"
            public static let vitaminB12add = "Vitamin B-12, added"
            public static let vitaminCint = "Vitamin C, intrinsic"
            public static let vitaminEint = "Vitamin E, intrinsic"
            public static let vitaminB12int = "Vitamin B-12, intrinsic"
            public static let vitaminD4 = "Vitamin D4"
            public static let vitaminB1add = "Thiamin, added"
            public static let vitaminB2add = "Riboflavin, added"
            public static let vitaminB3add = "Niacin, added"
            public static let vitaminB1int = "Thiamin, intrinsic"
            public static let vitaminB2int = "Riboflavin, intrinsic"
            public static let vitaminB3int = "Niacin, intrinsic"
            public static let vitaminB3 = "Niacin"
            public static let vitaminB3tryp = "Niacin from tryptophan, determined"
            public static let vitaminB3eqn = "Niacin equivalent N406 +N407"
            public static let vitaminB5 = "Pantothenic acid"
            public static let vitaminB7 = "Biotin"
            public static let vitaminB9total = "Folate, total"
            public static let vitaminB9free = "Folate, free"
            public static let vitaminB4total = "Choline, total"
                
            public static let calcium = "Calcium, Ca"
            public static let chloride = "Chlorine, Cl"
            public static let chromium = "Chromium, Cr"
            public static let copper = "Copper, Cu"
            public static let fluoride = "Fluoride, F"
            public static let iodine = "Iodine, I"
            public static let iron = "Iron, Fe"
            public static let magnesium = "Magnesium, Mg"
            public static let manganese = "Manganese, Mn"
            public static let molybdenum = "Molybdenum, Mo"
            public static let phosphorous = "Mineral P"
            public static let potassium = "Mineral K"
            public static let selenium = "Selenium, Se"
            public static let sulfur = "Sulfur, S"
            public static let sodium = "Sodium, Na"
            public static let zinc = "Zinc, Zn"
            
            public static let calories = "Calories"
            public static let energy = "Energy"
            public static let sugar = "Sugar"
            public static let water = "Water"
            public static let carbs = "Carbohydrate, by difference"
            public static let carbsSum = "Carbohydrate, by summation"
            public static let carbsGood = "Good Carbs"
            public static let carbsBad = "Bad Carbs"
            public static let fiber = "Fiber, total dietary"
            public static let fats = "Total lipid (fat)"
            public static let fatsGood = "Good Fats"
            public static let fatsBad = "Bad Fats"
            public static let epa = "PUFA 20:5 n-3 (EPA)"
            public static let dha = "PUFA 22:6 n-3 (DHA)"
            public static let linoleicAcid = "Linoleic Acid"
            public static let aLinoleicAcid = "alpha-Linoleic Acid"
            public static let protein = "Protein"
            public static let saturatedFat = "Fatty acids, total saturated"
            public static let transFat = "Fatty acids, total trans"
            public static let cholesterol = "Cholesterol"
            
            public static let macros = [
                FDCname.calories,      //"Calories"
                FDCname.energy,        //"Energy"
                FDCname.sugar,         //"Sugar"
                FDCname.water,         //"Water"
                FDCname.carbs,         //"Carbs"
                FDCname.carbsGood,     //"Good Carbs"
                FDCname.carbsBad,      //"Bad Carbs"
                FDCname.fiber,         //"Fiber"
                FDCname.fats,          //"Fats"
                FDCname.fatsGood,      //"Good Fats"
                FDCname.fatsBad,       //"Bad Fats"
                FDCname.linoleicAcid,  //"Linoleic Acid"
                FDCname.aLinoleicAcid, //"alpha-Linoleic Acid"
                FDCname.protein,       //"Protein"
                FDCname.saturatedFat,  //"Saturated Fat"
                FDCname.transFat,      //"Trans Fat"
                FDCname.cholesterol    //"Cholesterol"
            ]
                .map{$0.lowercased()}.set
            
            public static let vitamins = [
                FDCname.vitaminAiu,     // "Vitamin A, IU"
                FDCname.vitaminArae,    // "Vitamin A, RAE"
                FDCname.vitaminEalphat, // "Vitamin E (alpha-tocopherol)"
                FDCname.vitaminD23iu,   // "Vitamin D (D2 + D3), International Units"
                FDCname.vitaminD2,      // "Vitamin D2 (ergocalciferol)"
                FDCname.vitaminD3,      // "Vitamin D3 (cholecalciferol)"
                FDCname.vitaminD23,     // "Vitamin D (D2 + D3)"
                FDCname.vitaminElabel,  // "Vitamin E (label entry primarily)"
                FDCname.vitaminAre,     // "Vitamin A, RE"
                FDCname.vitaminE,       // "Vitamin E"
                FDCname.vitaminCtotal,  // "Vitamin C, total ascorbic acid"
                FDCname.vitaminCred,    // "Vitamin C, reduced ascorbic acid"
                FDCname.vitaminCdehyd,  // "Vitamin C, dehydro ascorbic acid"
                FDCname.vitaminB6pyrAlc,// "Vitamin B-6, pyridoxine, alcohol form"
                FDCname.vitaminB6pyrAld,// "Vitamin B-6, pyridoxal, aldehyde form"
                FDCname.vitaminB6pyrAmi,// "Vitamin B-6, pyridoxamine, amine form"
                FDCname.vitaminB6n,     // "Vitamin B-6, N411 + N412 +N413"
                FDCname.vitaminB6,      // "Vitamin B-6"
                FDCname.vitaminB12,     // "Vitamin B-12"
                FDCname.vitaminKmenaq,  // "Vitamin K (Menaquinone-4)"
                FDCname.vitaminKdihyd,  // "Vitamin K (Dihydrophylloquinone)"
                FDCname.vitaminKphyllo, // "Vitamin K (phylloquinone)"
                FDCname.vitaminCadd,    // "Vitamin C, added"
                FDCname.vitaminEadd,    // "Vitamin E, added"
                FDCname.vitaminB12add,  // "Vitamin B-12, added"
                FDCname.vitaminCint,    // "Vitamin C, intrinsic"
                FDCname.vitaminEint,    // "Vitamin E, intrinsic"
                FDCname.vitaminB12int,  // "Vitamin B-12, intrinsic"
                FDCname.vitaminD4,      // "Vitamin D4"
                FDCname.vitaminB1add,   // "Thiamin, added"
                FDCname.vitaminB2add,   // "Riboflavin, added"
                FDCname.vitaminB3add,   // "Niacin, added"
                FDCname.vitaminB1int,   // "Thiamin, intrinsic"
                FDCname.vitaminB2int,   // "Riboflavin, intrinsic"
                FDCname.vitaminB3int,   // "Niacin, intrinsic"
                FDCname.vitaminB3,      // "Niacin"
                FDCname.vitaminB3tryp,  // "Niacin from tryptophan, determined"
                FDCname.vitaminB3eqn,   // "Niacin equivalent N406 +N407"
                FDCname.vitaminB5,      // "Pantothenic acid"
                FDCname.vitaminB7,      // "Biotin"
                FDCname.vitaminB9total, // "Folate, total"
                FDCname.vitaminB9free,  // "Folate, free"
                FDCname.vitaminB4total, // "Choline, total"
            ]
                .map{$0.lowercased()}.set
            
            public static let minerals = [
                FDCname.calcium,
                FDCname.chloride,
                FDCname.chromium,
                FDCname.copper,
                FDCname.fluoride,
                FDCname.iodine,
                FDCname.iron,
                FDCname.magnesium,
                FDCname.manganese,
                FDCname.molybdenum,
                FDCname.phosphorous,
                FDCname.potassium,
                FDCname.selenium,
                FDCname.sulfur,
                FDCname.sodium,
                FDCname.zinc
            ]
                .map{$0.lowercased()}.set
        }
        
        public struct Compound {
            public static let calories = "Calories"
            public static let energy = "Calories"
            public static let sugar = "Sugar"
            public static let water = "Water"
            public static let carbs = "Carbs"
            public static let carbsGood = "Good Carbs"
            public static let carbsBad = "Bad Carbs"
            public static let fiber = "Fiber"
            public static let fats = "Fats"
            public static let fatsGood = "Good Fats"
            public static let fatsBad = "Bad Fats"
            public static let epa = "PUFA 20:5 (n-3)"
            public static let dha = "PUFA 22:6 (n-3)"
            public static let linoleicAcid = "PUFA 18:2"
            public static let aLinoleicAcid = "PUFA 18:3"
            public static let protein = "Protein"
            public static let saturatedFat = "Saturated Fat"
            public static let transFat = "Trans Fat"
            public static let cholesterol = "Cholesterol"
            
            public static let vitaminA = "Calciferol"
            public static let vitaminB1 = "Thiamin"
            public static let vitaminB2 = "Riboflavin"
            public static let vitaminB3 = "Niacin"
            public static let vitaminB4 = "Choline"
            public static let vitaminB5 = "Pantothenic"
            public static let vitaminB6 = "Pyridoxine"
            public static let vitaminB7 = "Biotin"
            public static let vitaminB9 = "Folate"
            public static let vitaminB12 = "Cobalamin"
            public static let vitaminC = "Ascorbic Acid"
            public static let vitaminD = "Calciferol"
            public static let vitaminE = "Tocoferol"
            public static let vitaminK = "Phylloquinone"
            
            public static let calcium = "Calcium"
            public static let chloride = "Chloride"
            public static let chromium = "Chromium"
            public static let copper = "Copper"
            public static let fluoride = "Fluoride"
            public static let iodine = "Iodine"
            public static let iron = "Iron"
            public static let magnesium = "Magnesium"
            public static let manganese = "Manganese"
            public static let molybdenum = "Molybdenum"
            public static let phosphorous = "Phosphorous"
            public static let potassium = "Potassium"
            public static let selenium = "Selenium"
            public static let sulfur = "Sulfur"
            public static let sodium = "Sodium"
            public static let zinc = "Zinc"
        }
    }
    
    public struct Food {
        public static let boostHighProteinDrink = "Boost High Protein Drink"
        public static let boostVeryHighEnergyDrink = "Boost Very High Energy Drink"
        public static let boostMaxMenShake = "Boost Max Men Shake"
        public static let sugarWhite = "White Sugar 🍯"
        public static let sugarBrown = "Brown Sugar 🍯"
        public static let arugula = "Arugula ☘️"
        public static let carrot = "Carrot 🥕"
        public static let kale = "Kale 🥬"
    }
    
    public struct NavigationTitle {
        public static let foodItem = "Food Item"
        public static let groceryList = "Grocery List"
        public static let addItem = "Add Item"
    }
}

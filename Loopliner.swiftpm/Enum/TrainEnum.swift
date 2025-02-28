//
//  TrainEnum.swift
//  Loopliner
//
//  Created by Lonard Steven on 23/01/25.
//

enum StationType: String, Codable {
    case regular = "Regular"
    case transit = "Transit"
}

enum StationBuiltType: String, Codable {
    case land = "Land"
    case underground = "Underground"
    case elevated = "Elevated"
    case mixed = "Mixed"
}

enum StationSize: String, Codable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
    case veryLarge = "Very Large"
}

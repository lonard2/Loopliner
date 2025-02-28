//
//  TrainLine.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftUI
import SwiftData

@Model
class TrainLine {
    var id: String
    var name: String
    var colorHex: String
    var colorAccessibleHex: String
    var darkText: Bool = false
    var stationID: [String]
    
    init(id: String, name: String, color: Color, colorAccessible: Color, stationID: [String], darkText: Bool = false) {
        self.id = id
        self.name = name
        self.colorHex = Converter.hexString(from: color)
        self.colorAccessibleHex = Converter.hexString(from: colorAccessible)
        self.stationID = stationID
        self.darkText = darkText
    }
    
    var color: Color {
        Converter.color(from: colorHex) ?? .black
    }
    
    var colorAccessible: Color {
        Converter.color(from: colorAccessibleHex) ?? .black
    }
}

@Model
class RouteVariation {
    var id: String
    var variationName: String
    var variationDescription: String
    
    init(id: String, variationName: String, variationDescription: String) {
        self.id = id
        self.variationName = variationName
        self.variationDescription = variationDescription
    }
}

struct Edge {
    let destination: String
    let weight: Int
}

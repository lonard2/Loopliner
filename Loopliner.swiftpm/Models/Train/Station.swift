//
//  Station.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftUI
import CoreGraphics
import Foundation
import SwiftData

@Model
class Station {
    var id: String
    var name: String
    var x: Double
    var y: Double
    
    var stationType: StationType?
    var stationCode: String?
    var dateOpened: String?
    var lanes: Int?
    var heightMeasurement: Int?
    var stationBuiltType: StationBuiltType?
    var electrifiedYear: String?
    var stationSize: StationSize?
    var isHidden: Bool = false
    var platforms: [StationPlatforms] = []
    
    init(id: String, name: String, x: Double, y: Double, stationType: StationType? = nil, stationCode: String? = nil, dateOpened: String? = nil, lanes: Int? = nil, heightMeasurement: Int? = nil, stationBuiltType: StationBuiltType? = nil, electrifiedYear: String? = nil, stationSize: StationSize? = nil, isHidden: Bool = false, platforms: [StationPlatforms]? = []) {
        self.id = id
        self.name = name
        self.x = x
        self.y = y
        self.stationType = stationType
        self.stationCode = stationCode
        self.dateOpened = dateOpened
        self.lanes = lanes
        self.heightMeasurement = heightMeasurement
        self.stationBuiltType = stationBuiltType
        self.electrifiedYear = electrifiedYear
        self.stationSize = stationSize
        self.isHidden = isHidden
        self.platforms = platforms ?? []
    }
    
    var position: CGPoint {
        CGPoint(x: x, y: y)
    }
}

@Model
class StationPlatforms {
    var id: String
    var platformName: String
    var platformDesc: String
    
    init(id: String, platformName: String, platformDesc: String) {
        self.id = id
        self.platformName = platformName
        self.platformDesc = platformDesc
    }
}

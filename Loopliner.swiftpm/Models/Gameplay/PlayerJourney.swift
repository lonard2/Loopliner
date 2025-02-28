//
//  PlayerJourney.swift
//  Loopliner
//
//  Created by Lonard Steven on 03/02/25.
//

import SwiftUI
import SwiftData

@Model
class PlayerJourney {
    var id: UUID
    var arrivalTime: TrainSettings
    
    var currentStationIndex: Int = 0
    var hasMoved: Bool = false
    var shouldTriggerTransitEvent: Bool = false
    var shouldTriggerEndEvent: Bool = false
    var stationJourney: [String]? = []
    var lapsedStations: [String]? = []
    
    var currentMoney: Int = (Int.random(in: 10...999) * 1000)
    var smilePoint: Int = 0
    var currentAdvImage: String?
    var currentBackgroundColorHex: String?
    var currentBackgroundColorAccessibleHex: String?
    
    var allStations: [Station]
    var allTrains: [Train]
    
    init(stationJourney: [String] = [], lapsedStations: [String] = [], allStations: [Station] = [], allTrains: [Train] = [], arrivalTime: TrainSettings = .train1035) {
        self.id = UUID()
        self.stationJourney = stationJourney
        self.lapsedStations = lapsedStations
        self.allStations = allStations
        self.allTrains = allTrains
        self.arrivalTime = arrivalTime
    }
    
    var currentStation: Station? {
        guard currentStationIndex < stationJourney?.count ?? 0 else { return nil }
        
        let stationId = stationJourney?[currentStationIndex]
        return allStations.first { $0.id == stationId }
    }
    
    var currentTrain: Train?
    
    var currentBackgroundColor: Color {
        Converter.color(from: currentBackgroundColorHex ?? "#FEA900") ?? .black
    }
    
    var currentBackgroundColorAccessible: Color {
        Converter.color(from: currentBackgroundColorAccessibleHex ?? "#FEA900") ?? .black
    }
}

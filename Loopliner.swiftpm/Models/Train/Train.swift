//
//  Train.swift
//  Loopliner
//
//  Created by Lonard Steven on 01/02/25.
//

import SwiftUI
import SwiftData

@Model
class Train {
    var id: String
    var name: String
    var parentLineId: String?
    var routeVariationId: String
    var stops: [TrainStop] = []
    var trainImage: String
    
    init(id: String, name: String, parentLineId: String? = nil, routeVariationId: String, stops: [TrainStop] = [], trainImage: String = "JR205_1") {
        self.id = id
        self.name = name
        self.parentLineId = parentLineId
        self.routeVariationId = routeVariationId
        self.stops = stops
        self.trainImage = trainImage
    }
}

@Model
class TrainStop {
    var id: String
    var stationId: String
    var arrivalTime: Date?
    var departureTime: Date?
    
    init(id: String, stationId: String, arrivalTime: Date? = nil, departureTime: Date? = nil) {
        self.id = id
        self.stationId = stationId
        self.arrivalTime = arrivalTime
        self.departureTime = departureTime
    }
}

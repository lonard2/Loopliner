//
//  FlipClockTime.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftData

@Model
class FlipClockTime {
    var hour: String
    var minute: String
    
    init(hour: String, minute: String) {
        self.hour = hour
        self.minute = minute
    }
}

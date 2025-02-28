//
//  Time.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftUI
import SwiftData

@Model
class Time {
    var hour: String
    var minute: String
    
    init(hour: String, minute: String) {
        self.hour = hour
        self.minute = minute
    }
    
    var date: Date {
        let calendar = Calendar.current
        let dateComponents = DateComponents(hour: Int(hour), minute: Int(minute))
        return calendar.date(from: dateComponents) ?? Date()
    }
}

//
//  TimeHelper.swift
//  Loopliner
//
//  Created by Lonard Steven on 24/01/25.
//

import SwiftUI

class TimeHelper: ObservableObject {
    static let shared = TimeHelper()
    
    @Published var randomTime: Date?
    private var timer: Timer?
    
    var isRunning: Bool {
        timer != nil
    }
    
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func formattedTimeWithMinute(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func formattedTimeForTrainSelect(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    func setRandomTime(around time: Date, rangeInSeconds: Int) {
        let randomOffset = Int.random(in: -rangeInSeconds...rangeInSeconds)
        randomTime = Calendar.current.date(byAdding: .second, value: randomOffset, to: time)
    }
    
    func setFixedRandomTime(around time: Date, seconds: Int) -> Date {
        let isNegative = Bool.random()
        let adjustedSeconds = isNegative ? -seconds : seconds
        return Calendar.current.date(byAdding: .second, value: adjustedSeconds, to: time) ?? time
    }
    
    func startTime() {
        guard let initialRandomTime = randomTime else { return }
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.randomTime = Calendar.current.date(byAdding: .second, value: 1, to: self.randomTime ?? initialRandomTime)
        }
    }
    
    func stopTime() {
        timer?.invalidate()
        timer = nil
    }
    
    func jumpToTime(targetTime: Date, rangeInSeconds: Int) {
        let randomOffset = Int.random(in: -rangeInSeconds...rangeInSeconds)
        randomTime = Calendar.current.date(byAdding: .second, value: randomOffset, to: targetTime)
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    static func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    deinit {
        timer?.invalidate()
    }
}

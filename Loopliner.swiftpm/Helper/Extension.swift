//
//  Extension.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import Foundation
import SwiftUI

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension View {
    func alert(item: Binding<String?>, content: @escaping (String) -> Alert) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: Notification.Name("InvalidDropWarning"))) { notification in
            if let message = notification.object as? String {
                item.wrappedValue = message
            }
        }
    }
}

extension TrainSettings {
    var time: Date {
        switch self {
        case .train1035:
            return Time(hour: "10", minute: "35").date
        case .train1109:
            return Time(hour: "11", minute: "09").date
        case .train1134:
            return Time(hour: "11", minute: "34").date
        case .nonselected:
            return Date.distantFuture
        }
    }
}

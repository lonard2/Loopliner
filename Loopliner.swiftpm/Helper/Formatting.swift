//
//  Formatting.swift
//  Loopliner
//
//  Created by Lonard Steven on 01/02/25.
//

import Foundation

class Formatting: ObservableObject {
    static let shared = Formatting()
    
    func formatToRupiah(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "IDR"
        formatter.locale = Locale(identifier: "id_ID")
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: value)) ?? "Rp\(value)"
    }
}

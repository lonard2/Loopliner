//
//  Converter.swift
//  Loopliner
//
//  Created by Lonard Steven on 01/02/25.
//

import SwiftUI

class Converter {
    static func hexString(from color: Color) -> String {
        let uiColor = UIColor(color)
        guard let components = uiColor.cgColor.components else {
            return "#000000"
        }
        
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
    
    static func color(from hex: String) -> Color? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        guard hexSanitized.count == 6, let hexNumber = UInt64(hexSanitized, radix: 16) else {
            return nil
        }
        
        let r = Double((hexNumber >> 16) & 0xFF) / 255.0
        let g = Double((hexNumber >> 8) & 0xFF) / 255.0
        let b = Double(hexNumber & 0xFF) / 255.0
        
        return Color(red: r, green: g, blue: b)
    }
}

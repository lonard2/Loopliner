//
//  FontManager.swift
//  Loopliner
//
//  Created by Lonard Steven on 18/01/25.
//

import SwiftUI
import CoreText

class FontManager: ObservableObject {
    @Published var fonts: [String] = []
    
    init() {
        registerFonts()
    }
    
    func retrieveAndUseCustomFont(from fontName: String) {
        guard let fontDataAsset = NSDataAsset(name: fontName),
              let dataProvider = CGDataProvider(data: fontDataAsset.data as CFData),
              let cgFont = CGFont(dataProvider) else {
            print("Failed to load custom font data from assets: \(fontName)")
            return
        }
        
        var error: Unmanaged<CFError>?
        let registrationSuccess = CTFontManagerRegisterGraphicsFont(cgFont, &error)
        if registrationSuccess {
            fonts.append(fontName)
        } else if let error = error?.takeUnretainedValue() {
            print("Custom font registration failed, due to: \(error.localizedDescription)")
        }
    }
    
    func registerFonts() {
        let fontNames = [
            "SpaceGrotesk-Bold",
            "SpaceGrotesk-Light",
            "SpaceGrotesk-Medium",
            "SpaceGrotesk-Regular",
            "SpaceGrotesk-SemiBold",
            "UnicaOne-Regular",
            "SpaceMono-Bold",
            "SpaceMono-BoldItalic",
            "SpaceMono-Italic",
            "SpaceMono-Regular",
        ]
        
        for fontName in fontNames {
            retrieveAndUseCustomFont(from: fontName)
        }
    }
}

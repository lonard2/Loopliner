//
//  SettingsManager.swift
//  Loopliner
//
//  Created by Lonard Steven on 20/01/25.
//

import Foundation
import SwiftUI

class SettingsManager {
    static let shared = SettingsManager()
    
    private let musicEnabledKey = "musicEnabled"
    private let sfxEnabledKey = "sfxEnabled"
    private let colorblindModeEnabledKey = "colorblindModeEnabled"
    
    private init() {
        
    }
    
    var isMusicEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: musicEnabledKey) }
        set {
            UserDefaults.standard.set(newValue, forKey: musicEnabledKey)
            NotificationCenter.default.post(name: .audioSettingsChanged, object: nil)
        }
    }
    
    var isSfxEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: sfxEnabledKey) }
        set { UserDefaults.standard.set(newValue, forKey: sfxEnabledKey)
            NotificationCenter.default.post(name: .audioSettingsChanged, object: nil)
        }
    }
    
    var isColorblindModeEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: colorblindModeEnabledKey) }
        set { UserDefaults.standard.set(newValue, forKey: colorblindModeEnabledKey) }
    }
}

extension Notification.Name {
    static let audioSettingsChanged = Notification.Name("audioSettingsChanged")
}

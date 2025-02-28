//
//  SettingsView.swift
//  Loopliner
//
//  Created by Lonard Steven on 20/01/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("musicEnabled") private var isMusicEnabled = true
    @AppStorage("sfxEnabled") private var isSfxEnabled = true
    @AppStorage("colorblindModeEnabled") private var isColorblindModeEnabled = false
    
    @StateObject private var audioManager = AudioManager.helper
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        VStack {
                            SettingToggleButton(
                                title: "Music",
                                isEnabled: isMusicEnabled,
                                iconEnabled: "music.note.list",
                                iconDisabled: "music.note",
                                toggleAction: {
                                    AudioManager.helper.playSFX(assetName: "Button Pressing")
                                    isMusicEnabled.toggle()
                                    
                                    if SettingsManager.shared.isMusicEnabled {
                                        AudioManager.helper.playBackgroundMusic(assetName: "Loopliner Menu - short")
                                    } else {
                                        AudioManager.helper.stopBackgroundMusic()
                                    }
                                },
                                colorEnabled: Color("MusicToggleColor"),
                                colorDisabled: Color("MusicToggleColorOff"),
                                geo: geo,
                                widthFactor: 0.4,
                                heightFactor: 0.35
                            )
                            .sensoryFeedback(.selection, trigger: isMusicEnabled)
                            .accessibilityLabel("Music setings toggle")
                            .accessibilityHint("Select to change your music settings. Value:  + \(isMusicEnabled ? "On" : "Off")")
                            
                            SettingToggleButton(
                                title: "Sound Effects",
                                isEnabled: isSfxEnabled,
                                iconEnabled: "speaker.wave.3.fill",
                                iconDisabled: "speaker.fill",
                                toggleAction: {
                                    AudioManager.helper.playSFX(assetName: "Button Pressing")
                                    isSfxEnabled.toggle()
                                },
                                colorEnabled: Color("SFXToggleColor"),
                                colorDisabled: Color("SFXToggleColorOff"),
                                geo: geo,
                                widthFactor: 0.4,
                                heightFactor: 0.35
                            )
                            .sensoryFeedback(.selection, trigger: isSfxEnabled)
                            .accessibilityLabel("Sound effects setings toggle")
                            .accessibilityHint("Select to change your sound effects settings. Value:  + \(isSfxEnabled ? "On" : "Off")")
                        }

                        VStack {
                            SettingToggleButton(
                                title: "Colorblind Mode",
                                isEnabled: isColorblindModeEnabled,
                                iconEnabled: "eye.fill",
                                iconDisabled: "eye.slash.fill",
                                toggleAction: {
                                    AudioManager.helper.playSFX(assetName: "Button Pressing")
                                    isColorblindModeEnabled.toggle()
                                },
                                colorEnabled: Color("CBToggleColor"),
                                colorDisabled: Color("CBToggleColorDark"),
                                geo: geo,
                                widthFactor: 0.4,
                                heightFactor: 0.75
                            )
                            .sensoryFeedback(.selection, trigger: isColorblindModeEnabled)
                            .accessibilityLabel("Colorblind mode setings toggle")
                            .accessibilityHint("Select to change your colorblind mode settings. Value:  + \(isSfxEnabled ? "On" : "Off")")
                        }
                    }
                    .tint(Color.white)
                    
                    HStack {
                        Button(action: {
                            AudioManager.helper.playSFX(assetName: "Button Pressing")
                            dismiss()
                        }) {
                            RoundedRectangle(cornerRadius: 32)
                                .fill(
                                    Color("MiscButtonColor")
                                )
                                .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.06)
                                .padding(.all, 16)
                                .overlay {
                                    HStack(alignment: .center) {
                                        
                                        Image(systemName: "arrowshape.backward.fill")
                                            .font(.system(size: 48))
                                            .accessibilityHidden(true)
                                        
                                        Text("Back")
                                            .font(.custom("SpaceGrotesk-Bold", size: 32))
                                    }
                                }
                        }
                        .accessibilityLabel("Back button")
                        .accessibilityHint("Select to back to the main menu.")
                        
                        Spacer()
                        
                        Text("SETTINGS")
                            .font(.custom("UnicaOne-Regular", size: geo.size.width * 0.072))
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 8)
                }
                .minimumScaleFactor(0.6)
            }
            .foregroundStyle(Color.black)
            .padding(.all, 64)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color("MainColor"))
            .navigationBarBackButtonHidden(true)
        }
    }
}

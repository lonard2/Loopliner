//
//  SignalStatusBox.swift
//  Loopliner
//
//  Created by Lonard Steven on 03/02/25.
//

import SwiftUI

struct SignalStatusBox: View {
    let geo: GeometryProxy
    @Binding var triggerChange: Bool
    
    @State private var leftWaveActive = false
    @State private var rightWaveActive = false
    @State private var statusText = "Please wait... No signal given yet."
    
    @StateObject private var audioManager = AudioManager.helper
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color("InstructionsShapeColor"))
                    .overlay {
                        VStack {
                            HStack(alignment: .center, spacing: 8) {
                                Image(systemName: "megaphone.fill")
                                    .resizable()
                                    .frame(width: geo.size.width * 0.028, height: geo.size.height * 0.048)
                                    .accessibilityHidden(true)
                                
                                Image(systemName: "wave.3.forward")
                                    .resizable()
                                    .symbolEffect(.variableColor.iterative, value: leftWaveActive)
                                    .frame(width: geo.size.width * 0.028, height: geo.size.height * 0.048)
                                    .padding(.trailing, 8)
                                    .accessibilityLabel("Station master signal status: \(leftWaveActive ? "Active" : "Inactive")")
                                
                                Image("Conductor portrait")
                                    .resizable()
                                    .frame(width: geo.size.width * 0.028, height: geo.size.height * 0.048)
                                    .padding(.leading, 8)
                                    .accessibilityHidden(true)
                                
                                Image(systemName: "wave.3.forward")
                                    .resizable()
                                    .symbolEffect(.variableColor.iterative, value: rightWaveActive)
                                    .frame(width: geo.size.width * 0.028, height: geo.size.height * 0.048)
                                    .accessibilityLabel("Train conductor signal status: \(leftWaveActive ? "Active" : "Inactive")")
                            }
                            
                            Text(statusText)
                                .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.018))
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .accessibilityElement(children: .combine)
                        .tint(.white)
                        .foregroundStyle(.white)
                        .padding(.vertical, geo.size.width * 0.016)
                        .padding(.horizontal, geo.size.width * 0.016)
                    }
            }
            
        }
        .task(id: triggerChange) {
            if triggerChange {
                startAnimationSequence()
            }
        }
    }
    
    private func startAnimationSequence() {
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 1)) {
                leftWaveActive = true
                statusText = "Signal 5, the train is ready to go."
                AudioManager.helper.playSFX(assetName: "Signal Beep Tone")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 1)) {
                    rightWaveActive = true
                    AudioManager.helper.playSFX(assetName: "Signal Beep Tone")
                }
            }
        }
    }
}

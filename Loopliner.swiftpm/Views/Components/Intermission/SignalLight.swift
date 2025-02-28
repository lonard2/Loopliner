//
//  SignalLight.swift
//  Loopliner
//
//  Created by Lonard Steven on 03/02/25.
//

import SwiftUI

struct SignalLight: View {
    let geo: GeometryProxy
    
    @Binding var triggerChange: Bool
    @State private var activeLight: Int = 0
    
    @AppStorage("colorblindModeEnabled") private var isColorblindModeEnabled = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color("SignalLightBaseColor"))
                .overlay {
                    VStack(alignment: .center, spacing: 32) {
                        if !isColorblindModeEnabled {
                            Circle()
                                .frame(width: geo.size.width * 0.048, height: geo.size.height * 0.048)
                                .foregroundStyle(activeLight == 2 ? Color("GreenLight") : Color("GreenLightDark"))
                                .accessibilityLabel("Green light, condition: \(activeLight == 2 ? "Turned on" : "Turned off")")
                            
                            Circle()
                                .frame(width: geo.size.width * 0.048, height: geo.size.height * 0.048)
                                .foregroundStyle(activeLight == 1 ? Color("YellowLight") : Color("YellowLightDark"))
                                .accessibilityLabel("Yellow light, condition: \(activeLight == 1 ? "Turned on" : "Turned off")")
                            
                            Circle()
                                .frame(width: geo.size.width * 0.048, height: geo.size.height * 0.048)
                                .foregroundStyle(activeLight == 0 ? Color("RedLight") : Color("RedLightDark"))
                                .accessibilityLabel("Red light, condition: \(activeLight == 0 ? "Turned off" : "Turned on")")
                        } else {
                            Circle()
                                .frame(width: geo.size.width * 0.048, height: geo.size.height * 0.048)
                                .foregroundStyle(activeLight == 2 ? Color("GreenLightAccessible") : Color("GreenLightDarkAccessible"))
                                .accessibilityLabel("Green light, condition: \(activeLight == 2 ? "Turned on" : "Turned off")")
                            
                            Circle()
                                .frame(width: geo.size.width * 0.048, height: geo.size.height * 0.048)
                                .foregroundStyle(activeLight == 1 ? Color("YellowLightAccessible") : Color("YellowLightDarkAccessible"))
                                .accessibilityLabel("Yellow light, condition: \(activeLight == 1 ? "Turned on" : "Turned off")")
                            
                            Circle()
                                .frame(width: geo.size.width * 0.048, height: geo.size.height * 0.048)
                                .foregroundStyle(activeLight == 0 ? Color("RedLightAccessible") : Color("RedLightDarkAccessible"))
                                .accessibilityLabel("Red light, condition: \(activeLight == 0 ? "Turned off" : "Turned on")")
                        }
                    }
                    .fixedSize()
                }
        }
        .task(id: triggerChange) {
            if triggerChange {
                startLightTransition()
            }
        }
    }
    
    private func startLightTransition() {
        activeLight = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            activeLight = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                activeLight = 2
            }
        }
    }
}

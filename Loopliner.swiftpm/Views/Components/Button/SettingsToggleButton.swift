//
//  SettingsToggleButton.swift
//  Loopliner
//
//  Created by Lonard Steven on 21/01/25.
//

import SwiftUI

struct SettingToggleButton: View {
    let title: String
    let isEnabled: Bool
    let iconEnabled: String
    let iconDisabled: String
    let toggleAction: () -> Void
    let colorEnabled: Color
    let colorDisabled: Color
    let geo: GeometryProxy
    let widthFactor: CGFloat
    let heightFactor: CGFloat
    
    var body: some View {
        Button(action: toggleAction) {
            RoundedRectangle(cornerRadius: 32)
                .fill(isEnabled ? colorEnabled : colorDisabled)
                .frame(width: geo.size.width * widthFactor, height: geo.size.height * heightFactor)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "arrow.down.forward")
                                .font(.system(size: geo.size.width * 0.064))
                                .fontWeight(.regular)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName: isEnabled ? iconEnabled : iconDisabled)
                                .font(.system(size: geo.size.width * 0.064))
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        Text(title)
                            .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.048))
                            .foregroundColor(.white)
                        Text(isEnabled ? "On" : "Off")
                            .font(.custom("SpaceGrotesk-Light", size: geo.size.width * 0.048))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 64)
                    .padding(.vertical, 32)
                    .multilineTextAlignment(.leading)
                }
        }
    }
}


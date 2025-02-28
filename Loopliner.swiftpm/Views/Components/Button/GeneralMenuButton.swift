//
//  GeneralMenuButton.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftUI

struct GeneralMenuButton: View {
    let title: String
    let description: String
    let icon: String
    let toggleAction: () -> Void
    let fillStyle: FillStyle
    let geo: GeometryProxy
    let widthFactor: CGFloat
    let heightFactor: CGFloat
    
    let iconColor: Color
    
    var body: some View {
        Button(action: toggleAction) {
            RoundedRectangle(cornerRadius: 32)
                .fill(fillStyle.asShapeStyle())
                .frame(width: geo.size.width * widthFactor, height: geo.size.height * heightFactor)
                .padding(.horizontal, 32)
                .padding(.vertical, 8)
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "arrow.down.forward")
                                .font(.system(size: geo.size.width * 0.064))
                                .fontWeight(.regular)
                            Spacer()
                            
                            Image(systemName: icon)
                                .font(.system(size: geo.size.width * 0.064))
                                .foregroundStyle(iconColor)
                        }
                        Spacer()
                        Text(title)
                            .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.040))
                        Text(description)
                            .font(.custom("SpaceGrotesk-Light", size: geo.size.width * 0.024))
                    }
                    .padding(.horizontal, 64)
                    .padding(.vertical, 32)
                    .multilineTextAlignment(.leading)
                }
        }
    }
}

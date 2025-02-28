//
//  BackButton.swift
//  Loopliner
//
//  Created by Lonard Steven on 28/01/25.
//

import SwiftUI

struct BackButton: View {
    
    @StateObject private var shared = AudioManager.helper
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { geo in
            Button {
                dismiss()
                AudioManager.helper.playSFX(assetName: "Button Pressing")
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        Color("MiscButtonColor")
                    )
                    .frame(width: geo.size.width * 0.072, height: geo.size.height * 0.096)
                    .overlay {
                        HStack(alignment: .center) {
                            
                            Image(systemName: "arrowshape.backward.fill")
                                .font(.system(size: geo.size.width * 0.032))
                                .tint(Color.black)
                        }
                    }
            }
            .contentShape(Rectangle())
        }
    }
}

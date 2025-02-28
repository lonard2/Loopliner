//
//  PauseButton.swift
//  Loopliner
//
//  Created by Lonard Steven on 28/01/25.
//

import SwiftUI

struct StopButton: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var audioManager = AudioManager.helper
    @State private var goBackToMenu: Bool = false
    
    @Binding var showJourneySheet: Bool
    
    @EnvironmentObject private var trainViewModel: TrainViewModel
    @EnvironmentObject private var advViewModel: ADVStoryViewModel
    
    var body: some View {
        GeometryReader { geo in
            Button {
                showJourneySheet.toggle()
                AudioManager.helper.playSFX(assetName: "Button Pressing")
                
                trainViewModel.resetPlayerJourney()
                advViewModel.resetStoryline()
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        Color("MiscButtonColor")
                    )
                    .frame(width: geo.size.width * 0.072, height: geo.size.height * 0.096)
                    .overlay {
                        HStack(alignment: .center) {
                            
                            Image(systemName: "stop.fill")
                                .font(.system(size: geo.size.width * 0.032))
                                .tint(Color.black)
                        }
                    }
            }
            .contentShape(Rectangle())
        }
    }
}

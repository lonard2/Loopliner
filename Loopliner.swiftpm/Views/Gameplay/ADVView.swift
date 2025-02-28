//
//  ADVView.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftUI
import SwiftData

struct ADVView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var dataManager: SwiftDataManager
    @StateObject private var audioManager = AudioManager.helper
    
    @State private var isVisible = true
    @State private var goToMessage = false
    @State private var goToInteractive = false
    @State private var goToMap = false
    @State private var goToOutcome = false
    @Binding var showJourneySheet: Bool
    
    @State private var interactiveMode: InteractiveViewMode = .unknown
    
    @EnvironmentObject var advViewModel: ADVStoryViewModel
    @EnvironmentObject var trainViewModel: TrainViewModel
    @EnvironmentObject var messageViewModel: MessageViewModel
    
    var body: some View {
        GeometryReader { geo in
            if let playerJourney: PlayerJourney = trainViewModel.getLatestJourney(modelContext: modelContext) {
                ZStack {
                    if advViewModel.currentStoryline.isEmpty {
                        Text("Loading your journey...")
                            .font(.custom("SpaceGrotesk-Bold",size: geo.size.width * 0.024))
                            .multilineTextAlignment(.center)
                    } else {
                        ZStack(alignment: .topLeading) {
                            StopButton(showJourneySheet: $showJourneySheet)
                                .padding(.all, geo.size.width * 0.048)
                                .accessibilityLabel("Stop button")
                                .accessibilityHint("Select to stop the journey and back to main menu.")
                        }
                        .zIndex(1)
                        
                        let currentStep = advViewModel.currentStoryline[advViewModel.currentIndex]

                        VStack {
                            VStack {
                                if let bgImage = currentStep.imageName {
                                    Image(bgImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width, height: geo.size.height * 0.5)
                                        .clipped()
                                        .accessibilityHidden(true)
                                }
                            }
                            .padding(.vertical, 64)
                            
                            
                            HStack {
                                if let characters = currentStep.character {
                                    VStack(alignment: .center) {
                                        Image(characters.sprite)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geo.size.width * 0.128, height: geo.size.height * 0.168)
                                            .accessibilityLabel("\(characters.name) image")
                                        
                                        Text(characters.name)
                                            .font(.custom("SpaceGrotesk-Bold",size: geo.size.width * 0.024))
                                            .multilineTextAlignment(.center)
                                            .accessibilityLabel(characters.name)
                                    }
                                    .frame(maxWidth: geo.size.width * 0.128)
                                }
                                VStack(alignment: .leading) {
                                    Text(currentStep.line)
                                        .font(.custom("SpaceGrotesk-Regular",size: geo.size.width * 0.032))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .frame(maxWidth: geo.size.width * 0.800, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            
                            NavigationLink("", destination: MapView(showJourneySheet: $showJourneySheet, lapsedStations: playerJourney.lapsedStations, mapViewMode: .journey), isActive: $goToMap)
                                .hidden()
                            
                            NavigationLink("", destination: InteractiveView(interactiveMode: $interactiveMode, showJourneySheet: $showJourneySheet), isActive: $goToInteractive)
                                .hidden()
                            
                            NavigationLink("", destination: MessageView(showJourneySheet: $showJourneySheet, conditionNumber: currentStep.conditionNumber ?? 1), isActive: $goToMessage)
                                .hidden()
                            
                            NavigationLink("", destination: OutcomeView(showJourneySheet: $showJourneySheet, conditionNumber: currentStep.conditionNumber ?? 101), isActive: $goToOutcome)
                                .hidden()
                        }
                        .onAppear {
                            if advViewModel.currentStoryline.isEmpty {
                                DispatchQueue.main.async {
                                    advViewModel.startStoryline("intro")
                                }
                            } else {
                            }
                        }
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .animation(.easeInOut(duration: 0.5), value: isVisible)
                .tint(Color.white)
                .background(Color("IntroColor"))
                .simultaneousGesture(TapGesture().onEnded {
                    withAnimation {
                        if advViewModel.currentIndex < advViewModel.currentStoryline.count - 1 {
                            advViewModel.currentIndex += 1
                        } else {
                            playerJourney.currentAdvImage = advViewModel.currentStoryline[advViewModel.currentIndex].imageName
                            
                            handleStorylineTransition()
                        }
                    }
                    
                    AudioManager.helper.playSFX(assetName: "Button Pressing", volume: 0.35)
                })
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            audioManager.playBackgroundMusic(assetName: "Loopliner Story", loopStartTime: 0, loopEndTime: 17)
        }
    }
    
    func handleStorylineTransition() {
        guard let lastStep = advViewModel.currentStoryline.last else { return }

        switch lastStep.transition {
        case .message:
            DispatchQueue.main.async {
                goToMessage = true
            }
        case .map:
            DispatchQueue.main.async {
                goToMap = true
            }
        case .interactiveBigChoice:
            DispatchQueue.main.async {
                interactiveMode = .bigChoice
                goToInteractive = true
            }
        case .interactiveSmallChoice:
            DispatchQueue.main.async {
                interactiveMode = .smallChoice
                goToInteractive = true
            }
        case .outcome:
            DispatchQueue.main.async {
                goToOutcome = true
            }
        case .paymentTapIn:
            DispatchQueue.main.async {
                interactiveMode = .paymentTapIn
                goToInteractive = true
            }
        case .paymentTapOut:
            DispatchQueue.main.async {
                interactiveMode = .paymentTapOut
                goToInteractive = true
            }
        case .none:
            break
        }
    }
}

//
//  OutcomeView.swift
//  Loopliner
//
//  Created by Lonard Steven on 31/01/25.
//

import SwiftUI
import SwiftData

struct OutcomeView: View {
    // SwiftData
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject private var dataManager: SwiftDataManager
    @StateObject private var audioManager = AudioManager.helper
    @StateObject private var imageView = ImageView()
    
    @State private var currentOutcomeIndex = 0
    
    @EnvironmentObject var messageViewModel: MessageViewModel
    @EnvironmentObject var trainViewModel: TrainViewModel
    @Binding var showJourneySheet: Bool
    
    @State private var goToMap = false
    
    var conditionNumber: Int
    var filteredOutcomes: [Outcome] {
        MessageViewModel.getOutcomes(for: String(conditionNumber))
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if filteredOutcomes.isEmpty {
                    Text("There aren't any outcomes made for this condition, yet.")
                } else {
                    if let playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext),
                       let currentStep = filteredOutcomes[safe: currentOutcomeIndex] {
                        RoundedRectangle(cornerRadius: 64)
                            .fill(currentStep.shapeBackgroundColor)
                            .frame(width: geo.size.width * 0.92, height: geo.size.height * 0.92)
                            .overlay {
                                ZStack {
                                    Image(systemName: currentStep.outcomeIcon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geo.size.width * 0.768, height: geo.size.height * 0.768)
                                        .offset(x: geo.size.width * 0.128, y: geo.size.height * 0.016)
                                        .rotationEffect(.degrees(30))
                                        .foregroundStyle(.white.opacity(0.35))
                                    
                                    VStack {
                                        Text(currentStep.outcomeTitle)
                                            .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.064))
                                            .padding(.all, geo.size.width * 0.012)
                                            .multilineTextAlignment(.center)
                                        
                                        Text(currentStep.outcomeBody)
                                            .font(.custom("SpaceGrotesk-Medium", size: geo.size.width * 0.032))
                                            .padding(.all, geo.size.width * 0.012)
                                            .multilineTextAlignment(.center)
                                        
                                        Button {
                                            AudioManager.helper.playSFX(assetName: "Button Pressing")
                                            
                                            withAnimation {
                                                let getAllOutcomesOfCondition = filteredOutcomes.filter {
                                                    $0.conditionNumber == currentStep.conditionNumber
                                                }
                                                if currentOutcomeIndex < getAllOutcomesOfCondition.count - 1 {
                                                    currentOutcomeIndex += 1
                                                } else {
                                                    handleOutcomeTransition(playerJourney: playerJourney)
                                                }
                                            }
                                        } label: {
                                            RoundedRectangle(cornerRadius: 64)
                                                .fill(
                                                    Color("MiscButtonColor")
                                                )
                                                .frame(width: geo.size.width * 0.32, height: geo.size.width * 0.108)
                                                .padding(.all, 16)
                                                .overlay {
                                                    HStack(alignment: .center) {
                                                        
                                                        imageView.imageViewSetup(for: currentStep.nextActionIcon)
                                                            .frame(width: geo.size.width * 0.036, height: geo.size.width * 0.036)
                                                            .padding()
                                                        
                                                        Text(currentStep.nextActionTitle)
                                                            .font(.custom("SpaceGrotesk-Medium", size: geo.size.width * 0.032))
                                                            .padding()
                                                    }
                                                    .foregroundStyle(.black)
                                                }
                                        }
                                        NavigationLink("", destination: MapView(showJourneySheet: $showJourneySheet, lapsedStations: playerJourney.lapsedStations, mapViewMode: .journey), isActive: $goToMap)
                                            .hidden()
                                    }
                                    .foregroundStyle(.white)
                                    .sensoryFeedback(conditionNumber == 101 ? .success : conditionNumber == 102 ? .error : .warning , trigger: currentStep)
                                }
                            }
                            .mask(RoundedRectangle(cornerRadius: 64))
                    }

                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    if self.conditionNumber == 102 {
                        audioManager.playBackgroundMusicOnce(assetName: "Loopliner Failure")
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(trainViewModel.getLatestJourney(modelContext: modelContext)?.currentBackgroundColor.opacity(0.5) ?? Color("EarlyPlayColor").opacity(0.5))
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func handleOutcomeTransition(playerJourney: PlayerJourney) {
        guard let lastStep = filteredOutcomes.last else { return }
        
        switch lastStep.outcomeNextStep {
        case .map:
            if conditionNumber == 101 {
                trainViewModel.addSmilePoint()
            } else if conditionNumber == 103 || conditionNumber == 104 {
                trainViewModel.reduceSmilePointApathy()
            }
            goToMap = true
            trainViewModel.moveStations(playerJourney: playerJourney)
        case .menu:
            showJourneySheet.toggle()
        case .unknown:
            break
        case .none:
            break
        }
    }
}

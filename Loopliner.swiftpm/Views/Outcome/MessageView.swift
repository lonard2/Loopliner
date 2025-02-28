//
//  MessageView.swift
//  Loopliner
//
//  Created by Lonard Steven on 30/01/25.
//

import SwiftUI
import SwiftData

struct MessageView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    
    @EnvironmentObject private var dataManager: SwiftDataManager
    
    @StateObject private var audioManager = AudioManager.helper
    @StateObject private var imageView = ImageView()
    @State private var currentMessageIndex = 0
    
    @EnvironmentObject var messageViewModel: MessageViewModel
    @EnvironmentObject var trainViewModel: TrainViewModel
    @EnvironmentObject var advViewModel: ADVStoryViewModel
    
    @Binding var showJourneySheet: Bool
    @State private var goToMap = false
    @State private var showEndMessage = false
    
    var conditionNumber: Int
    var filteredMessages: [Message] {
        MessageViewModel.getMessages(for: String(conditionNumber))
    }
    
    var body: some View {
        GeometryReader { geo in
            if let currentStep = filteredMessages[safe: currentMessageIndex] {
                ZStack {
                    if let playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext) {
                        if filteredMessages.isEmpty {
                            Text("There aren't any messages made for this condition, yet.")
                        } else {
                            VStack (alignment: .leading) {
                                HStack(alignment: .top) {
                                    imageView.imageViewSetup(for: currentStep.messageIcon)
                                        .frame(width: geo.size.width * 0.096, height: geo.size.width * 0.096)
                                    
                                    if let secondMessageIcon = currentStep.secondMessageIcon {
                                        imageView.imageViewSetup(for: secondMessageIcon)
                                            .frame(width: geo.size.width * 0.096, height: geo.size.width * 0.096)
                                    }
                                }
                                .padding(.all, geo.size.width * 0.0032)
                                .sensoryFeedback(conditionNumber == 2 ? .success : conditionNumber == 3 ? .error : .warning , trigger: currentStep)
                                
                                Text(currentStep.messageTitle)
                                    .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.048))
                                    .padding(.all, geo.size.width * 0.012)
                                    .multilineTextAlignment(.leading)
                                    .minimumScaleFactor(0.7)
                                
                                Text(currentStep.messageBody)
                                    .font(.custom("SpaceGrotesk-Medium", size: geo.size.width * 0.018))
                                    .padding(.all, geo.size.width * 0.012)
                                    .multilineTextAlignment(.leading)
                                    .minimumScaleFactor(0.8)

                                Button {
                                    AudioManager.helper.playSFX(assetName: "Button Pressing")
                                    
                                    withAnimation {
                                        let getAllMessagesOfCondition = filteredMessages.filter {
                                            $0.conditionNumber == currentStep.conditionNumber
                                        }
                                        
                                        if currentMessageIndex < getAllMessagesOfCondition.count - 1 {
                                            currentMessageIndex += 1
                                        } else {
                                            handleMessageTransition()
                                        }
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 64)
                                        .fill(
                                            Color("MiscButtonColor")
                                        )
                                        .frame(width: geo.size.width * 0.32, height: geo.size.width * 0.08)
                                        .padding(.all, 8)
                                        .overlay {
                                            HStack(alignment: .center) {
                                                imageView.imageViewSetup(for: currentStep.nextActionIcon)
                                                    .frame(width: geo.size.width * 0.032, height: geo.size.width * 0.032)
                                                    .padding()
                                                
                                                Text(currentStep.nextActionTitle)
                                                    .font(.custom("SpaceGrotesk-Medium", size: geo.size.width * 0.024))
                                                    .padding()
                                            }
                                        }
                                        .foregroundStyle(Color.black)
                                }
                                
                                NavigationLink("", destination: MapView(showJourneySheet: $showJourneySheet, lapsedStations: playerJourney.lapsedStations, mapViewMode: .journey), isActive: $goToMap)
                                    .hidden()
                                
                                NavigationLink("", destination: MessageView(showJourneySheet: $showJourneySheet, conditionNumber: 7), isActive: $showEndMessage)
                                    .hidden()
                            }
                            
                        }
                    } else {
                        Text("No journey found at this time.")
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        if self.conditionNumber == 2 {
                            audioManager.playBackgroundMusicOnce(assetName: "Loopliner Success")
                        } else if self.conditionNumber == 3 {
                            audioManager.playBackgroundMusicOnce(assetName: "Loopliner Apathy")
                        } else if self.conditionNumber == 4 || self.conditionNumber == 5 || self.conditionNumber == 6 {
                            audioManager.playBackgroundMusicOnce(assetName: "Loopliner Failure")
                        } else if self.conditionNumber == 7 {
                            audioManager.playBackgroundMusic(assetName: "Loopliner Menu - short", loopStartTime: 0, loopEndTime: 13.2)
                        }
                    }
                }
                .foregroundStyle(Color.white)
                .padding(.all, 64)
                .minimumScaleFactor(0.8)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: geo.size.width, height: geo.size.height)
                .background(currentStep.backgroundColor)
            } else {
                Text("No messages available yet")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func handleMessageTransition() {
        guard let lastStep = filteredMessages.last else { return }
        
        switch lastStep.messageNextStep {
        case .nextmessageend:
            showEndMessage.toggle()
        case .menu:
            trainViewModel.resetPlayerJourney()
            advViewModel.resetStoryline()
            showJourneySheet.toggle()
        case .map:
            goToMap.toggle()
        case .unknown:
            break
        case .none:
            break
        }
        
    }
}

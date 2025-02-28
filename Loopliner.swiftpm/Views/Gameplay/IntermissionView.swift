//
//  IntermissionView.swift
//  Loopliner
//
//  Created by Lonard Steven on 31/01/25.
//

import SwiftUI
import SwiftData

struct IntermissionView: View {
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject private var dataManager: SwiftDataManager
    
    @Binding var intermissionMode: IntermissionViewMode
    
    @StateObject private var timeHelper = TimeHelper.shared
    @StateObject private var audioManager = AudioManager.helper
    
    @AppStorage("musicEnabled") private var isMusicEnabled: Bool = true
    
    @EnvironmentObject var trainViewModel: TrainViewModel
    @EnvironmentObject var advViewModel: ADVStoryViewModel
    @EnvironmentObject var messageViewModel: MessageViewModel
    
    @State private var triggerSignalChange = false
    @State private var goToMap = false
    
    @State private var randomDelay: Int = 0
    @State private var randomMessage: String = "Normal"
    @State private var delayMessage: String = "Normal"
    @State private var randomMessageColor: Color = Color.white
    @State private var actualArrivalTime: Date = Date()
    
    @Binding var showJourneySheet: Bool
    
    let randomDelayInSeconds = Int.random(in: 0...600)
    
    var trainImage: String? = "JR205_1"
    
    let currentTrainCondition: [String] = [
        "Only a few people inside",
        "Several people inside",
        "Seats are mostly used",
        "Full seat, few door edges filled",
        "Full seat, all door edges filled",
        "Somewhat packed",
        "Very packed"
    ]
    
    let currentTrainConditionColors: [String: Color] = [
        "Only a few people inside" : Color.green,
        "Several people inside": Color.green,
        "Seats are mostly used": Color.green,
        "Full seat, few door edges filled": Color.yellow,
        "Full seat, all door edges filled": Color.yellow,
        "Somewhat packed": Color.red,
        "Very packed": Color.red
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ZStack(alignment: .topLeading) {
                    StopButton(showJourneySheet: $showJourneySheet)
                        .padding(.all, geo.size.width * 0.048)
                        .accessibilityLabel("Stop button")
                        .accessibilityHint("Select to stop the journey and back to main menu.")
                }
                .zIndex(1)
                
                if let playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext) {
                    
                    ZStack(alignment: .bottomLeading) {
                        VStack(alignment: .leading) {
                            Text(playerJourney.currentStation?.name ?? "No station")
                                .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.024))
                            
                            if let randomTime = timeHelper.randomTime {
                                Text(timeHelper.formattedTime(randomTime))
                                    .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.024))
                            } else {
                                Text("Time Error")
                                    .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.024))
                            }
                        }
                    }
                    .zIndex(0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(.all, geo.size.width * 0.032)
                    .accessibilityLabel("Current station: \(playerJourney.currentStation?.name ?? "No station"), Current time: \(timeHelper.formattedTime(timeHelper.randomTime ?? Date()))")
                    
                    VStack {
                        if let trainImage = playerJourney.currentTrain?.trainImage {
                            Image(trainImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height * 0.7)
                                .clipped()
                                .position(x: geo.size.width / 2, y: (geo.size.height * 0.7) / 2)
                                .padding(.bottom, 8)
                                .accessibilityHidden(true)
                        } else {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height * 0.7)
                                .clipped()
                                .position(x: geo.size.width / 2, y: (geo.size.height * 0.7) / 2)
                                .padding(.bottom, 8)
                                .accessibilityHidden(true)
                        }
                        
                        
                        switch intermissionMode {
                        case .waiting:
                            VStack {
                                HStack {
                                    Text("You will aboard the")
                                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.024))
                                        .frame(maxWidth: geo.size.width * 0.25, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text(playerJourney.currentTrain?.name ?? "6000")
                                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.064))
                                        .frame(maxWidth: geo.size.width * 0.55, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                }
                                .accessibilityElement(children: .ignore)
                                
                                VStack(alignment: .leading) {
                                    Text("arriving at \(timeHelper.formattedTimeForTrainSelect(actualArrivalTime))")
                                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.018))
                                    
                                    HStack {
                                        Image(systemName: "clock.badge.exclamationmark.fill")
                                            .frame(maxWidth: geo.size.width * 0.040, alignment: .leading)
                                            .accessibilityHidden(true)
                                        
                                        Text(delayMessage)
                                            .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.028))
                                    }
                                    .accessibilityLabel("Delay status: \(delayMessage)")
                                    
                                    HStack {
                                        Image(systemName: "person.2.wave.2.fill")
                                            .frame(maxWidth: geo.size.width * 0.040, alignment: .leading)
                                            .accessibilityHidden(true)
                                        
                                        Text(randomMessage)
                                            .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.028))
                                            .foregroundStyle(randomMessageColor)
                                    }
                                    .accessibilityLabel("Train condition: \(randomMessage)")
                                }
                                .accessibilityElement(children: .ignore)
                            }
                            .padding(.horizontal, geo.size.width * 0.032)
                            .padding(.vertical, geo.size.width * 0.064)
                            .onAppear {
                                actualArrivalTime = playerJourney.currentTrain?.stops[safe: playerJourney.currentStationIndex]?.arrivalTime ?? Time(hour: "10", minute: "45").date
                                
                                randomMessage = currentTrainCondition.randomElement() ?? "Unknown condition"
                                randomMessageColor = currentTrainConditionColors[randomMessage] ?? Color.gray
                                delayMessage = formatDelayMessage(seconds: randomDelayInSeconds)
                                
                                if !playerJourney.shouldTriggerTransitEvent {
                                    DispatchQueue.main.async {
                                        audioManager.playBackgroundMusicSecondLayer(assetName: "Train Entering", startTime: 4.5, endTime: 20.2)
                                    }
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    intermissionMode = .aboarding
                                }
                            }
                            
                        case .aboarding:
                            VStack {
                                HStack {
                                    VStack(alignment: .center, spacing: geo.size.width * 0.008) {
                                        HStack {
                                            Text("You are now in")
                                                .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.032))
                                                .frame(maxWidth: geo.size.width * 0.35, alignment: .trailing)
                                                .multilineTextAlignment(.leading)
                                            
                                            Text(playerJourney.currentTrain?.name ?? "6000")
                                                .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.064))
                                                .frame(maxWidth: geo.size.width * 0.55, alignment: .leading)
                                                .padding(.horizontal, geo.size.width * 0.008)
                                                .multilineTextAlignment(.leading)
                                        }
                                        .accessibilityElement(children: .combine)
                                        
                                        SignalStatusBox(geo: geo, triggerChange: $triggerSignalChange)
                                            .frame(width: geo.size.width * 0.384, height: geo.size.height * 0.150)
                                            .padding(.bottom, geo.size.width * 0.016)
                                            .accessibilityLabel("Signal status box, showing current signal status. Trigger status: \(triggerSignalChange ? "true" : "false")")
                                    }
                                    
                                    SignalLight(geo: geo, triggerChange: $triggerSignalChange)
                                        .frame(width: geo.size.width * 0.064, height: geo.size.height * 0.256)
                                        .padding(.all, geo.size.width * 0.032)
                                        .sensoryFeedback(.start, trigger: triggerSignalChange)
                                        .accessibilityLabel("Signal light, showing current signal status. Trigger status: \(triggerSignalChange ? "true" : "false")")
                                }
                                NavigationLink("", destination: MapView(showJourneySheet: $showJourneySheet, lapsedStations: playerJourney.lapsedStations, mapViewMode: .journey), isActive: $goToMap)
                                    .hidden()
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    triggerSignalChange.toggle()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                                    audioManager.playBackgroundMusicSecondLayer(assetName: "Train Leaving")
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                                    trainViewModel.moveStations(playerJourney: playerJourney)
                                    goToMap.toggle()
                                }
                            }
                            
                        case .unknown:
                            Text("IntermissionView Mode: Unknown")
                        }
                    }
                    .onAppear {
                        if isMusicEnabled && !audioManager.isMusicPlaying {
                            audioManager.playBackgroundMusic(assetName: "Loopliner Through Transport", loopStartTime: 0.0, loopEndTime: 15.3)
                        }
                    }
                }
            }
            .ignoresSafeArea(.all)
            .background(trainViewModel.getLatestJourney(modelContext: modelContext)?.currentBackgroundColor.opacity(0.5) ?? Color("EarlyPlayColor").opacity(0.5))
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func formatDelayMessage(seconds: Int) -> String {
        let minutes = seconds / 60
        
        if minutes > 0 {
            return "\(minutes) minute\(minutes > 1 ? "s" : "") delay"
        } else if minutes == 0 {
            return "On time"
        } else {
            return "Early arrival!"
        }
    }
}

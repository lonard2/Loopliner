//
//  MenuView.swift
//  Loopliner
//
//  Created by Lonard Steven on 19/01/25.
//

import SwiftUI

struct MenuView: View {
    // SwiftData stuffs
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject private var dataManager: SwiftDataManager
    
    // Initialization of a player's journey
    @State private var trainArrivalSet: TrainSettings = .nonselected
    
    // gradients for the menu items
    private var greenTopGradient = Gradient(colors: [
        Color("MenuLimeGreen"),
        Color("MenuLimeGreenLite")
    ])
    
    private var orangeBottomLeftGradient = Gradient(colors: [
        Color("MenuOrangeOne"),
        Color("MenuOrangeTwo"),
        Color("MenuOrangeThree")
    ])
    
    private var redBottomRightGradient = Gradient(colors: [
        Color("MenuRedOne"),
        Color("MenuRedTwo"),
        Color("MenuRedThree")
    ])
    
    // arrival time set
    private let arrivalTime: [Time] = [
        Time(hour: "10", minute: "35"),
        Time(hour: "11", minute: "09"),
        Time(hour: "11", minute: "34"),
    ]
    
    // navigation stuffs
    @State private var goToCreditsView = false
    @State private var goToSettingsView: Bool = false
    @State private var goToMap: Bool = false
    @State private var showJourneySheet: Bool = false
    @State private var isInStoryMode: Bool = false
    
    // Helper & storage
    @StateObject private var audioManager = AudioManager.helper
    @AppStorage("musicEnabled") private var isMusicEnabled: Bool = true
    @AppStorage("sfxEnabled") private var isSFXEnabled: Bool = true
    @AppStorage("colorblindModeEnabled") private var isColorblindModeEnabled = false
    
    // view model initialization
    @EnvironmentObject var advViewModel: ADVStoryViewModel
    @EnvironmentObject var trainViewModel: TrainViewModel
    @EnvironmentObject var messageViewModel: MessageViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    GeneralMenuButton(title: "Journey of a Smart Commuter",
                                      description: "Could Robert reaches his dream campus, on an novel-but-inspiring journey?",
                                      icon: "train.side.front.car",
                                      toggleAction: {
                        AudioManager.helper.playSFX(assetName: "Button Pressing")
                        withAnimation {
                            isInStoryMode.toggle()
                        }
                    },
                                      fillStyle: .gradient(gradient: greenTopGradient,
                                                           centerPosition: .center,
                                                           startAngle: .degrees(0),
                                                           endAngle: .degrees(110)),
                                      geo: geo,
                                      widthFactor: 0.85,
                                      heightFactor: 0.45,
                                      iconColor: Color("TrainGreen"))
                                        .accessibilityLabel("Start Journey of a Smart Commuter mode")
                                        .accessibilityHint("Select to begin your journey")
                    
                    
                    if isInStoryMode {
                        Spacer()
                        VStack {
                            Text("Select your first train arrival time...")
                                .font(.custom("SpaceGrotesk-Light", size: geo.size.width * 0.032))
                            HStack(spacing: 64) {
                                ForEach(arrivalTime, id: \.self) { time in
                                    Button(action: {
                                        AudioManager.helper.playSFX(assetName: "Button Pressing")
                                        
                                        switch (time.hour, time.minute) {
                                            case ("10", "35"):
                                            trainArrivalSet = .train1035
                                            advViewModel.startStoryline("intro")
                                            
                                            case ("11", "09"):
                                            trainArrivalSet = .train1109
                                            advViewModel.startStoryline("intro2")
                                            
                                            case ("11", "34"):
                                            trainArrivalSet = .train1134
                                            advViewModel.startStoryline("intro3")
                                            
                                            default:
                                            trainArrivalSet = .train1035
                                            advViewModel.startStoryline("intro")
                                        }
                                        
                                        trainViewModel.initializePlayerJourney(for: trainArrivalSet, modelContext: modelContext)
                                        
                                        showJourneySheet.toggle()
                                    }) {
                                        FlipClock(geo: geo, hour: time.hour, minute: time.minute)
                                            .accessibilityLabel("Arrival time at \(time.hour) (\(time.minute))")
                                            .accessibilityHint("Select to set your arrival time")
                                    }
                                }
                            }
                        }
                        .animation(.easeInOut(duration: 0.5), value: isInStoryMode)
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                AudioManager.helper.playSFX(assetName: "Button Pressing")
                                withAnimation {
                                    isInStoryMode.toggle()
                                }
                            }) {
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(
                                        Color("MiscButtonColor")
                                    )
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.06)
                                    .padding(.all, 16)
                                    .overlay {
                                        HStack(alignment: .center) {
                                            
                                            Image(systemName: "arrowshape.backward.fill")
                                                .font(.system(size: geo.size.width * 0.032))
                                                .accessibilityHidden(true)
                                            
                                            Text("Back")
                                                .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.028))
                                        }
                                    }
                            }
                            .accessibilityLabel("Back button")
                            .accessibilityHint("Select to close the arrival time selection menu.")
                            Spacer()
                            
                            Image("Loopliner logo dark")
                                .resizable()
                                .frame(width: geo.size.width * 0.256, height: geo.size.height * 0.064)
                                .accessibilityLabel("Loopliner")
                        }
                        
                        .animation(.easeInOut(duration: 0.5), value: isInStoryMode)
                    } else {
                        HStack {
                            GeneralMenuButton(title: "Map",
                                              description: "Check the Jakarta’s train transport map.", icon: "map.fill",
                                              toggleAction: {
                                AudioManager.helper.playSFX(assetName: "Button Pressing")
                                goToMap = true
                            },
                                              fillStyle: .gradient(gradient: orangeBottomLeftGradient,
                                                                   centerPosition: .center,
                                                                   startAngle: .degrees(80),
                                                                   endAngle: .degrees(240)),
                                              geo: geo,
                                              widthFactor: 0.85,
                                              heightFactor: 0.25,
                                              iconColor: Color("MapOrange"))
                                                .accessibilityLabel("Open the map")
                                                .accessibilityHint("Select to see the Jakarta’s train transport map.")
                            
                            NavigationLink("", destination: MapView(showJourneySheet: $showJourneySheet), isActive: $goToMap)
                                .hidden()
                        }
                        .animation(.easeInOut(duration: 0.5), value: isInStoryMode)
                        
                        
                        HStack {
                            Button(action: {
                                AudioManager.helper.playSFX(assetName: "Button Pressing")
                                
                                goToCreditsView = true
                            }) {
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(
                                        Color("MiscButtonColor")
                                    )
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.06)
                                    .padding(.all, 16)
                                    .overlay {
                                        HStack(alignment: .center) {
                                            
                                            Image(systemName: "person.circle.fill")
                                                .font(.system(size: geo.size.width * 0.032))
                                                .accessibilityHidden(true)
                                            
                                            Text("Credits")
                                                .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.028))
                                        }
                                    }
                            }
                            .accessibilityLabel("Open the credits")
                            .accessibilityHint("Select to see Loopliner credits.")
                            
                            Button(action: {
                                AudioManager.helper.playSFX(assetName: "Button Pressing")
                                goToSettingsView = true
                            }) {
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(
                                        Color("MiscButtonColor")
                                    )
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.06)
                                    .padding(.all, 16)
                                    .overlay {
                                        HStack(alignment: .center) {
                                            
                                            Image(systemName: "gearshape.fill")
                                                .font(.system(size: geo.size.width * 0.032))
                                                .accessibilityHidden(true)
                                            
                                            Text("Settings")
                                                .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.028))
                                        }
                                    }
                            }
                            .accessibilityLabel("Open the settings")
                            .accessibilityHint("Select to review the game settings")
                            Spacer()
                            
                            NavigationLink("", destination: SettingsView(), isActive: $goToSettingsView)
                                .hidden()
                            NavigationLink("", destination: CreditsView(), isActive: $goToCreditsView)
                                .hidden()
                            
                            Image("Loopliner logo dark")
                                .resizable()
                                .frame(width: geo.size.width * 0.256, height: geo.size.height * 0.064)
                        }
                        .animation(.easeInOut(duration: 0.5), value: isInStoryMode)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 8)
                        
                    }
                }
                .minimumScaleFactor(0.55)
                .foregroundStyle(Color.black)
                .padding(.horizontal, 64)
                .padding(.vertical, 32)
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Color("MainColor"))
                .onAppear {
                    trainViewModel.resetPlayerJourney()
                    if isMusicEnabled && !audioManager.isMusicPlaying {
                        audioManager.playBackgroundMusic(assetName: "Loopliner Menu - short", loopStartTime: 0, loopEndTime: 13.2)
                    }
                }
                .fullScreenCover(isPresented: $showJourneySheet, onDismiss: audioManager.stopBackgroundMusic) {
                    NavigationStack {
                        if let latestJourney = trainViewModel.getLatestJourney(modelContext: modelContext) {
                            ADVView(showJourneySheet: $showJourneySheet)
                        } else {
                            Text("No journey available")
                        }
                    }
                    .onChange(of: showJourneySheet) { newValue in
                        if newValue {
                            dataManager.fetchLatestPlayerJourney()
                        }
                    }
                    .onDisappear {
                        if isMusicEnabled && !audioManager.isMusicPlaying {
                            audioManager.playBackgroundMusic(assetName: "Loopliner Menu - short", loopStartTime: 0, loopEndTime: 13.2)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

//#Preview {
//    MenuView()
//}

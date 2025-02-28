//
//  InteractiveView.swift
//  Loopliner
//
//  Created by Lonard Steven on 31/01/25.
//

import SwiftUI
import SwiftData

struct InteractiveView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    
    var advImage: String?
    @StateObject private var timeHelper = TimeHelper.shared
    
    // for the payment mode
    @State private var showWarning: String? = nil
    @State private var draggedItem: String? = nil
    
    // navigation related stuffs
    @Binding var interactiveMode: InteractiveViewMode
    @State var intermissionMode: IntermissionViewMode = .waiting
    @State private var goToMessage = false
    @State private var goToIntermission = false
    @State private var goToADV = false
    
    @Binding var showJourneySheet: Bool
    
    @StateObject private var audioManager = AudioManager.helper
    @EnvironmentObject private var dataManager: SwiftDataManager
    
    @AppStorage("musicEnabled") private var isMusicEnabled: Bool = true
    
    @State private var playerJourney: PlayerJourney?
    
    @EnvironmentObject var trainViewModel: TrainViewModel
    @EnvironmentObject var advViewModel: ADVStoryViewModel
    @EnvironmentObject var messageViewModel: MessageViewModel
    
    var body: some View {
        GeometryReader { geo in
            if let playerJourney: PlayerJourney = trainViewModel.getLatestJourney(modelContext: modelContext) {
                ZStack {
                    ZStack(alignment: .topLeading) {
                        StopButton(showJourneySheet: $showJourneySheet)
                            .padding(.all, geo.size.width * 0.048)
                                .accessibilityLabel("Stop button")
                                .accessibilityHint("Select to stop the journey and back to main menu.")
                    }
                    .zIndex(1)
                    
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
                            .accessibilityLabel("Current station: \(playerJourney.currentStation?.name ?? "No station"), Current time: \(timeHelper.formattedTime(timeHelper.randomTime ?? Date()))")
                        }
                        .zIndex(0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(.all, geo.size.width * 0.032)
                
                        ZStack {
                            VStack {
                                if let advImage = playerJourney.currentAdvImage {
                                    Image(advImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width, height: geo.size.height * 0.5)
                                        .clipped()
                                            .accessibilityHidden(true)
                                } else {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .resizable()
                                        .frame(width: geo.size.width * 0.32, height: geo.size.height * 0.25)
                                            .accessibilityHidden(true)
                                }
                                
                                ChoiceTextView(geo: geo, interactiveMode: interactiveMode)
                            }
                            
                        }
                        .padding(.vertical, 64)

                        
                        ZStack {
                            switch interactiveMode {
                            case .paymentTapIn:
                                PaymentTapInView(geo: geo, showWarning: $showWarning, draggedItem: $draggedItem, interactiveMode: $interactiveMode)
                                
                            case .paymentTapOut:
                                PaymentTapOutView(geo: geo, showWarning: $showWarning, draggedItem: $draggedItem, interactiveMode: $interactiveMode)
                                
                            case .balanceCheck:
                                BalanceCheckView(geo: geo, interactiveMode: $interactiveMode)
                                
                            case .balanceCheckEnd:
                                BalanceCheckEndView(geo: geo, interactiveMode: $interactiveMode)
                                
                            case .platformSelect:
                                PlatformSelectInteractiveView(geo: geo, interactiveMode: $interactiveMode, showJourneySheet: $showJourneySheet)
                                
                            case .trainSelect:
                                TrainSelectInteractiveView(geo: geo, interactiveMode: $interactiveMode)
                                
                            case .goToMessage(let condition):
                                Group {
                                    NavigationLink("", destination: MessageView(showJourneySheet: $showJourneySheet, conditionNumber: condition), isActive: $goToMessage)
                                        .onAppear {
                                            goToMessage.toggle()
                                        }
                                }
                                
                            case .goToAdv(let storyline):
                                Group {
                                    NavigationLink("", destination: ADVView(showJourneySheet: $showJourneySheet), isActive: $goToADV)
                                        .hidden()
                                        .onAppear {
                                            advViewModel.startStoryline(storyline)
                                            goToADV.toggle()
                                        }
                                }
                                
                            case .goToIntermission:
                                Group {
                                    NavigationLink("", destination: IntermissionView(intermissionMode: $intermissionMode, showJourneySheet: $showJourneySheet), isActive: $goToIntermission)
                                        .hidden()
                                        .onAppear {
                                            goToIntermission.toggle()
                                        }
                                }
                            case .smallChoice:
                                SmallChoiceInteractiveView(geo: geo, interactiveMode: $interactiveMode, goToADV: $goToADV, showJourneySheet: $showJourneySheet)
                                
                            case .bigChoice:
                                BigChoiceInteractiveView(geo: geo, goToADV: $goToADV, showJourneySheet: $showJourneySheet)
                                
                            case .unknown:
                                VStack {
                                    Text("InteractiveView Mode: unknown")
                                }
                            }
                        }
                        .zIndex(1)
                }
                .onAppear {
                    if playerJourney.currentStation?.id == "23" {
                        trainViewModel.handleTransitStationEvent(playerJourney.currentStation) { newMode in
                            interactiveMode = newMode
                        }
                    }
                }
                .background(trainViewModel.getLatestJourney(modelContext: modelContext)?.currentBackgroundColor.opacity(0.5) ?? Color("EarlyPlayColor").opacity(0.5))
                .navigationBarBackButtonHidden(true)
                .frame(width: geo.size.width, height: geo.size.height)
                .alert(item: $showWarning) { warning in
                    Alert(title: Text("Wrong Action"), message: Text(warning), dismissButton: .default(Text("OK")))
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    struct ChoiceTextView: View {
        let geo: GeometryProxy
        let interactiveMode: InteractiveViewMode
        
        var body: some View {
            if [.smallChoice, .bigChoice].contains(interactiveMode) {
                Text("- select your choice above -")
                    .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.016))
                    .opacity(0.5)
                    .padding(.all, geo.size.width * 0.008)
                    .tracking(10)
            }
        }
    }
    
    struct PaymentTapInView: View {
        let geo: GeometryProxy
        
        @Binding var showWarning: String?
        @Binding var draggedItem: String?
        
        @Binding var interactiveMode: InteractiveViewMode
        @Namespace private var animationNamespace
        
        var body: some View {
            VStack {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        DropTargetView(geo: geo, image: "QR Ticket Scanner", validItem: "smartphone", draggedItem: $draggedItem) {
                            AudioManager.helper.playSFX(assetName: "Payment Tapping")
                            interactiveMode = .platformSelect
                        }
                        .gesture(DragGesture())
                        .frame(width: geo.size.width * 0.200, height: geo.size.height * 0.370)
                        .padding(.all, geo.size.width * 0.012)
                        .sensoryFeedback(.success, trigger: draggedItem)
                        .accessibilityLabel("QR Ticket Scanner")
                        .accessibilityHint("Use your smartphone to scan a QR code here for tap in.")
                        
                        DropTargetView(geo: geo, image: "Card Tap Reader", validItem: "walletCard", draggedItem: $draggedItem) {
                            AudioManager.helper.playSFX(assetName: "Payment Tapping")
                            interactiveMode = .platformSelect
                        }
                        .gesture(DragGesture())
                        .frame(width: geo.size.width * 0.200, height: geo.size.height * 0.370)
                        .padding(.all, geo.size.width * 0.012)
                        .sensoryFeedback(.success, trigger: draggedItem)
                        .accessibilityLabel("Card Tap Reader")
                        .accessibilityHint("Use your electronic card to tap here for tap in.")
                    }
                    .padding(.all, geo.size.width * 0.012)
                    
                    DropTargetView(geo: geo, image: "Card Check Reader", validItem: "walletCard", draggedItem: $draggedItem) {
                        AudioManager.helper.playSFX(assetName: "Payment Tapping")
                        interactiveMode = .balanceCheck
                    }
                    .gesture(DragGesture())
                    .frame(width: geo.size.width * 0.225, height: geo.size.height * 0.180)
                    .sensoryFeedback(.success, trigger: draggedItem)
                    .accessibilityLabel("Card Check Reader")
                    .accessibilityHint("Use your electronic card to tap here for check your card's balance.")
                }
                .padding()
                
                Spacer(minLength: geo.size.width * 0.003)
                
                VStack(alignment: .trailing) {
                    HStack(alignment: .bottom, spacing: 16) {
                        DraggableItem(geo: geo, image: "Smartphone", itemType: "smartphone", draggedItem: $draggedItem, animationNamespace: animationNamespace)
                            .frame(width: geo.size.width * 0.160, height: geo.size.height * 0.290)
                            .sensoryFeedback(.impact(weight: .heavy), trigger: draggedItem)
                            .accessibilityLabel("Smartphone")
                            .accessibilityHint("Use it for tap in at QR scanner.")
                        
                        DraggableItem(geo: geo, image: "Wallet Card", itemType: "walletCard", draggedItem: $draggedItem, animationNamespace: animationNamespace)
                            .frame(width: geo.size.width * 0.160, height: geo.size.height * 0.290)
                            .sensoryFeedback(.impact(weight: .light), trigger: draggedItem)
                            .accessibilityLabel("Electronic wallet card")
                            .accessibilityHint("Use it for tap in at card tap reader or you could see your card balance at the check reader.")
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.vertical, geo.size.width * 0.008)
                    .padding(.horizontal, geo.size.width * 0.032)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.vertical, geo.size.width * 0.008)
                .padding(.horizontal, geo.size.width * 0.032)
            }
        }
    }
    
    struct PaymentTapOutView: View {
        let geo: GeometryProxy
        
        @Binding var showWarning: String?
        @Binding var draggedItem: String?
        
        @Binding var interactiveMode: InteractiveViewMode
        
        @Namespace private var animationNamespace
        
        @EnvironmentObject var trainViewModel: TrainViewModel
        
        var body: some View {
            VStack {
                HStack(alignment: .center) {
                    DropTargetView(geo: geo, image: "QR Ticket Scanner", validItem: "smartphone", draggedItem: $draggedItem) {
                        trainViewModel.payTicket()
                        AudioManager.helper.playSFX(assetName: "Payment Tapping")
                        interactiveMode = .balanceCheckEnd
                    }
                    .gesture(DragGesture())
                    .frame(width: geo.size.width * 0.200, height: geo.size.height * 0.370)
                    .padding(.all, geo.size.width * 0.012)
                    .sensoryFeedback(.success, trigger: draggedItem)
                    .accessibilityLabel("QR Ticket Scanner")
                    .accessibilityHint("Use your smartphone to scan a QR code here for tap out.")
                    
                    DropTargetView(geo: geo, image: "Card Tap Reader", validItem: "walletCard", draggedItem: $draggedItem) {
                        trainViewModel.payTicket()
                        AudioManager.helper.playSFX(assetName: "Payment Tapping")
                        interactiveMode = .balanceCheckEnd
                    }
                    .gesture(DragGesture())
                    .frame(width: geo.size.width * 0.200, height: geo.size.height * 0.370)
                    .padding(.all, geo.size.width * 0.012)
                    .sensoryFeedback(.success, trigger: draggedItem)
                    .accessibilityLabel("Card Tap Reader")
                    .accessibilityHint("Use your electronic card to tap here for tap out.")
                }
                .padding()
                
                Spacer(minLength: geo.size.width * 0.003)
                
                VStack(alignment: .trailing) {
                    HStack(alignment: .bottom, spacing: 16) {
                        DraggableItem(geo: geo, image: "Smartphone", itemType: "smartphone", draggedItem: $draggedItem, animationNamespace: animationNamespace)
                            .frame(width: geo.size.width * 0.160, height: geo.size.height * 0.290)
                            .sensoryFeedback(.impact(weight: .heavy), trigger: draggedItem)
                            .accessibilityLabel("Smartphone")
                            .accessibilityHint("Use it for tap out at QR scanner.")
                        
                        DraggableItem(geo: geo, image: "Wallet Card", itemType: "walletCard", draggedItem: $draggedItem, animationNamespace: animationNamespace)
                            .frame(width: geo.size.width * 0.160, height: geo.size.height * 0.290)
                            .sensoryFeedback(.impact(weight: .light), trigger: draggedItem)
                            .accessibilityLabel("Electronic wallet card")
                            .accessibilityHint("Use it for tap out at card tap reader.")
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.vertical, geo.size.width * 0.008)
                    .padding(.horizontal, geo.size.width * 0.032)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.vertical, geo.size.width * 0.008)
                .padding(.horizontal, geo.size.width * 0.032)

            }
        }
    }
    
    struct BalanceCheckView: View {
        let geo: GeometryProxy
        
        @State private var playerJourney: PlayerJourney?
        
        @Binding var interactiveMode: InteractiveViewMode
        
        @Environment(\.modelContext) private var modelContext
        @EnvironmentObject var trainViewModel: TrainViewModel
        
        var body: some View {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    CheckMachineView(geo: geo, balance: playerJourney?.currentMoney ?? 10000)
                    Spacer()
                    HStack {
                        Spacer()
                        if playerJourney?.currentMoney ?? 10000 >= 100000 {
                            RobertBubble(geo: geo, content: "There is still many.\nI shouldn’t top-up more.", image: "Robert glasses side smile")
                                .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.18, alignment: .trailing)
                                .zIndex(1)
                            
                        } else if playerJourney?.currentMoney ?? 10000 < 100000 && playerJourney?.currentMoney ?? 10000 >= 50000  {
                            RobertBubble(geo: geo, content: "It seems I need to top-up later.", image: "Robert glasses smile")
                                .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.18, alignment: .trailing)
                                .zIndex(1)
                        } else {
                            RobertBubble(geo: geo, content: "Ouch, my wallet card balance is running low. After I go home, I should top-up it.", image: "Robert glasses sad")
                                .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.18, alignment: .trailing)
                                .zIndex(1)
                        }
                    }
                    .padding(.trailing, geo.size.width * 0.032)
                    .padding(.bottom, geo.size.width * 0.008)
                }
                .onAppear {
                    playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext)
                }
                .onTapGesture {
                    interactiveMode = .paymentTapIn
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct BalanceCheckEndView: View {
        let geo: GeometryProxy
        
        @State private var playerJourney: PlayerJourney?
        @Binding var interactiveMode: InteractiveViewMode
        
        @Environment(\.modelContext) private var modelContext
        @EnvironmentObject var trainViewModel: TrainViewModel
        @EnvironmentObject var advViewModel: ADVStoryViewModel
        
        var body: some View {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    CheckMachineView(geo: geo, balance: playerJourney?.currentMoney ?? 100000)
                    Spacer()
                    HStack {
                        Spacer()
                        if playerJourney?.currentMoney ?? 10000 >= 100000 {
                            RobertBubble(geo: geo, content: "Hooray, the balance is still huge enough!", image: "Robert glasses")
                                .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.18, alignment: .trailing)
                                .zIndex(1)
                            
                        } else if playerJourney?.currentMoney ?? 10000 < 100000 && playerJourney?.currentMoney ?? 10000 >= 50000  {
                            RobertBubble(geo: geo, content: "Hmm, few days later, I probably top-up it.", image: "Robert glasses side smile")
                                .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.18, alignment: .trailing)
                                .zIndex(1)
                        } else {
                            RobertBubble(geo: geo, content: "Oh no, I almost ran out of money...", image: "Robert glasses sad")
                                .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.18, alignment: .trailing)
                                .zIndex(1)
                                
                        }
                    }
                    .padding(.trailing, geo.size.width * 0.032)
                    .padding(.bottom, geo.size.width * 0.008)
                }
                .onAppear {
                    playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    
                    DispatchQueue.main.async {
                        if playerJourney?.smilePoint ?? 0 > 1 {
                            interactiveMode = .goToAdv(withStoryline: "endPostArrival1")
                        } else {
                            interactiveMode = .goToAdv(withStoryline: "endPostArrival2")
                        }
                    }
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct PlatformSelectInteractiveView: View {
        let geo: GeometryProxy
        
        @State private var playerJourney: PlayerJourney?
        @Binding var interactiveMode: InteractiveViewMode
        @Binding var showJourneySheet: Bool
        
        @Environment(\.modelContext) private var modelContext
        @Environment(\.colorScheme) private var colorScheme
        @EnvironmentObject var trainViewModel: TrainViewModel
        
        var body: some View {
            ZStack(alignment: .bottomTrailing) {
                let station = playerJourney?.currentStation ?? Station(id: "16", name: "Rajawali", x: 0.85, y: 0.32)
                 VStack {
                     Spacer()
                     PlatformSelectView(geo: geo, station: station, interactiveMode: $interactiveMode, showJourneySheet: $showJourneySheet)
                         .foregroundStyle(Color.white)
                         .padding(.vertical, geo.size.width * 0.016)
                         .padding(.horizontal, geo.size.width * 0.032)
                     
                     Spacer()
                     HStack {
                         Spacer()
                         if ((playerJourney?.shouldTriggerTransitEvent) != nil) {
                             RobertBubble(geo: geo, content: "I arrived at \(station.name)! Where to go next?", image: "Robert glasses confused")
                                 .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.15)
                                 .zIndex(1)
                         } else {
                             RobertBubble(geo: geo, content: "Umm, I already at \(station.name) station. Where to go next?", image: "Robert glasses confused")
                                 .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.15)
                                 .zIndex(1)
                         }
                     }
                     .padding(.trailing, geo.size.width * 0.032)
                     .padding(.bottom, geo.size.width * 0.008)
                 }
                 .onAppear {
                     playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext)
                 }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct TrainSelectInteractiveView: View {
        let geo: GeometryProxy
        
        @State private var playerJourney: PlayerJourney?
        @Binding var interactiveMode: InteractiveViewMode
        
        @Environment(\.modelContext) private var modelContext
        @Environment(\.colorScheme) private var colorScheme
        @EnvironmentObject var trainViewModel: TrainViewModel
        
        var body: some View {
            let station = playerJourney?.currentStation ?? Station(id: "16", name: "Rajawali", x: 0.85, y: 0.32)
            VStack {
                TrainSelectView(geo: geo, trains: trainViewModel.trains, stations: trainViewModel.stations,  arrivalStation: station, interactiveMode: $interactiveMode, playerJourney: playerJourney ?? PlayerJourney())
                    .foregroundStyle(Color.white)
                    .padding(.vertical, geo.size.width * 0.032)
                
                HStack {
                    Spacer()
                    RobertBubble(geo: geo, content: "There are two trains. Cisauk should be within 38 minutes of ride. I should arrive for my bus before 12.15.", image: "Robert glasses confused")
                    .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.18)
                    .zIndex(1)
                }
                .padding(.trailing, geo.size.width * 0.032)
                .padding(.bottom, geo.size.width * 0.008)
            }
            .onAppear {
                playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext)
            }
        }
    }
    
    struct SmallChoiceInteractiveView: View {
        let geo: GeometryProxy
        
        @State private var playerJourney: PlayerJourney?
        
        @Binding var interactiveMode: InteractiveViewMode
        @Binding var goToADV: Bool
        @Binding var showJourneySheet: Bool
        
        @Environment(\.modelContext) private var modelContext
        @EnvironmentObject var trainViewModel: TrainViewModel
        @EnvironmentObject var advViewModel: ADVStoryViewModel
        
        @StateObject private var audioManager = AudioManager.helper
        @AppStorage("musicEnabled") private var isMusicEnabled: Bool = true
        
        var body: some View {
            
            VStack {
                let choices = advViewModel.currentStoryline[advViewModel.currentIndex].choices
                 VStack {
                     Spacer()
                     SmallChoiceButton(geo: geo, choices: choices ?? []) { choice in
                         advViewModel.startStoryline(choice.nextStep)
                         goToADV.toggle()
                     }
                     Spacer()
                     
                     HStack {
                         Spacer()
                         RobertBubble(geo: geo, content: advViewModel.currentStoryline[advViewModel.currentIndex].bubbleMessage, image: advViewModel.currentStoryline[advViewModel.currentIndex].bubbleImage)
                         .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.18)
                         .zIndex(1)
                     }
                     .padding(.trailing, geo.size.width * 0.032)
                     .padding(.bottom, geo.size.width * 0.008)
                 }
                 .onAppear {
                     playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext)
                 }
                 
                 NavigationLink("", destination: ADVView(showJourneySheet: $showJourneySheet), isActive: $goToADV)
                     .hidden()
            }
            .onAppear {
                if isMusicEnabled && !audioManager.isMusicPlaying {
                    DispatchQueue.main.async {
                        audioManager.playBackgroundMusic(assetName: "Loopliner Interact Choices", loopStartTime: 0, loopEndTime: 17.35)
                    }
                }
            }
        }
    }
    
    struct BigChoiceInteractiveView : View {
        let geo: GeometryProxy
        
        @State private var playerJourney: PlayerJourney?
        
        @Binding var goToADV: Bool
        @Binding var showJourneySheet: Bool
        
        @Environment(\.modelContext) private var modelContext
        @EnvironmentObject var trainViewModel: TrainViewModel
        @EnvironmentObject var advViewModel: ADVStoryViewModel
        
        @StateObject private var audioManager = AudioManager.helper
        @AppStorage("musicEnabled") private var isMusicEnabled: Bool = true
        
        var body: some View {
            VStack {
                let choices = advViewModel.currentStoryline[advViewModel.currentIndex].bigChoices
                 VStack {
                     Spacer()
                     LargeChoiceButton(geo: geo, choices: choices ?? []) { choice in
                         advViewModel.startStoryline(choice.nextStep)
                         goToADV.toggle()
                     }
                     Spacer()
                     
                     HStack {
                         Spacer()
                         RobertBubble(geo: geo, content: advViewModel.currentStoryline[advViewModel.currentIndex].bubbleMessage, image: advViewModel.currentStoryline[advViewModel.currentIndex].bubbleImage)
                         .frame(width: geo.size.width * 0.60, height: geo.size.height * 0.18)
                         .zIndex(1)
                     }
                     .padding(.trailing, geo.size.width * 0.032)
                     .padding(.bottom, geo.size.width * 0.008)
                 }
                 .onAppear {
                     playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext)
                 }
                 
                 NavigationLink("", destination: ADVView(showJourneySheet: $showJourneySheet), isActive: $goToADV)
                     .hidden()
            }
            .onAppear {
                if isMusicEnabled && !audioManager.isMusicPlaying {
                    DispatchQueue.main.async {
                        audioManager.playBackgroundMusic(assetName: "Loopliner Interact Choices", loopStartTime: 0, loopEndTime: 17.35)
                    }
                }
            }
        }
    }
}

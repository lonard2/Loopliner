//
//  ADVStoryViewModel.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftUI
import SwiftData
import Combine

class ADVStoryViewModel: ObservableObject {
    @Published var playerJourney: PlayerJourney?
    @ObservedObject private var dataManager: SwiftDataManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: SwiftDataManager) {
        self.dataManager = dataManager
        dataManager.$playerJourney
            .receive(on: DispatchQueue.main)
            .sink { [weak self] playerJourney in
                self?.playerJourney = playerJourney
            }
            .store(in: &cancellables)
        
    }
    
    @Published var currentStoryline: [Storyline] = []
    @Published var currentIndex: Int = 0
    
    static let introStoryline: [Storyline] = [
        Storyline(line: "Wow, I got accepted at my dreamed campus!\n I should get prepare for my journey...", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "I also riding the public transport for the first time, \n especially train... Just now, I heard terms like\n “signal”...", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "Train 6020, signal 5. Train is ready to go.", imageName: "asset_station_rajawali", character: Characters(name: "Station Announcer", sprite: "Conductor portrait female"), transition: .none, conditionNumber: 1),
        Storyline(line: "The door will close in a moment.\n (door closes)\n (train moves)", imageName: "asset_station_cisauk", character: Characters(name: "Train 6019 announcer", sprite: "Conductor portrait"), transition: .none, conditionNumber: 1),
        Storyline(line: "Yep, many things about the public transport world should I know & understand.", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "And... I should know how to behave well during\n my trip. I should respect everyone else inside the system, isn’t it?", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "Okay... Let’s get inside the station.", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "I should have to arrive at 12.15, as the nearest\n residential bus service to my place will depart.\nDon’t make me late!", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .message, conditionNumber: 1)
    ]
    
    static let introStoryline2: [Storyline] = [
        Storyline(line: "Wow, I got accepted at my dreamed campus!\n I should get prepare for my journey...", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "I also riding the public transport for the first time,\n especially train... Just now, I heard terms like \n “instructions”...", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "Train 6022, signal 5. Train is ready to go.", imageName: "asset_station_rajawali", character: Characters(name: "Station Announcer", sprite: "Robert glasses"), transition: .none),
        Storyline(line: "The door will close in a moment.\n (door closes)\n (train moves)", imageName: "asset_station_cisauk", character: Characters(name: "Train 6021 announcer", sprite: "Conductor portrait"), transition: .none, conditionNumber: 1),
        Storyline(line: "Yep, many things about the public transport world should I know & understand.", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "And... I should know how to behave well during\n my trip. I should respect everyone else inside the system, isn’t it?", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "Okay... Let’s get inside the station.", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "I should have to arrive at 13.30, as the nearest\n residential bus service to my place will depart.\n Don’t make me late!", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .message, conditionNumber: 1)
    ]
    
    static let introStoryline3: [Storyline] = [
        Storyline(line: "Wow, I got accepted at my dreamed campus!\n I should get prepare for my journey...", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "I also riding the public transport for the first time,\n especially train... Just now, I heard terms like \n “instructions”...", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "Train 6024, signal 5. Train is ready to go.", imageName: "asset_station_rajawali", character: Characters(name: "Station Announcer", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "The door will close in a moment.\n (door closes)\n (train moves)", imageName: "asset_station_cisauk", character: Characters(name: "Train 6023 announcer", sprite: "Conductor portrait"), transition: .none, conditionNumber: 1),
        Storyline(line: "Yep, many things about the public transport world should I know & understand.", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "And... I should know how to behave well during\n my trip. I should respect everyone else inside the system, isn’t it?", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "Okay... Let’s get inside the station.", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 1),
        Storyline(line: "I should have to arrive at 13.30, as the nearest\n residential bus service to my place will depart.\n Don’t make me late!", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .message, conditionNumber: 1)
    ]
    
    static let introStorylineMissed: [Storyline] = [
        Storyline(line: "I'm getting on wrong platform! The incoming train looks like going for my station in Tanah Abang.", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses sad"), transition: .none, conditionNumber: 6),
        Storyline(line: "The train crossing is now closed... It seems I'm will be late. Thank you, Robert!", imageName: "asset_station_rajawali", character: Characters(name: "Robert", sprite: "Robert glasses sad"), transition: .message, conditionNumber: 6)
    ]
    
    static let transitStorylineMissed: [Storyline] = [
        Storyline(line: "Yikes, I'm now waiting for some time here and no train arrived yet.\nLet's ask someone to confirm if I on the right track.", imageName: "asset_station_manggarai", character: Characters(name: "Robert", sprite: "Robert glasses exhausted"), transition: .none, conditionNumber: 5),
        Storyline(line: "Excuse me, this is going for Cisauk?", imageName: "asset_station_manggarai", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 5),
        Storyline(line: "I'm sorry, but this is not going to Cisauk. This for the Cikarang line.", imageName: "asset_station_manggarai", character: Characters(name: "Passenger", sprite: "Male passenger 3"), transition: .none, conditionNumber: 5),
        Storyline(line: "Ah. Oh, no... I'm going on the wrong platform. And that train far from here, seems going to Tangerang... I'm lost!", imageName: "asset_station_manggarai", character: Characters(name: "Robert", sprite: "Robert glasses sad"), transition: .message, conditionNumber: 5)
    ]
    
    static let thiefStorylineIntro: [Storyline] = [
        Storyline(line: "(gets up and leave the train in Robert’s carriage)", imageName: "asset_train_in", character: Characters(name: "Passenger", sprite: "Male passenger 1"), transition: .none),
        Storyline(line: "(hears music and seeing the surroundings)", imageName: "asset_train_in_2", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none),
        Storyline(line: "Hmm, ah, is that a phone?", imageName: "asset_train_in", character: Characters(name: "Station Announcer", sprite: "Robert glasses confused"), transition: .interactiveSmallChoice, choices: [
                Choice(text: "Report it to the security officer", nextStep: "thief1", verdict: .good),
                  Choice(text: "Putting it on the bag", nextStep: "thief2", verdict: .bad),
                  Choice(text: "Leave it here", nextStep: "thief3", verdict: .apathy)
        ], bubbleMessage: "Ah, there is a phone here, but it’s not mine.", bubbleImage: "Robert glasses confused"
            )
    ]
    
    static let thiefStorylineOne: [Storyline] = [
        Storyline(line: "Excuse me, here is the phone dropped by a passenger. I didn’t know the passenger details, but it was dropped after it stopped at previous station.", imageName: "asset_train_in_2", character: Characters(name: "Robert", sprite: "Robert glasses speaking"), transition: .none, conditionNumber: 101),
        Storyline(line: "Thank you for your report!", imageName: "asset_train_in_2", character: Characters(name: "Security Officer", sprite: "Security Guard"), transition: .none, conditionNumber: 101),
        Storyline(line: "(via walkie-talkie, barely audible) ... Carriage 5, there is a missing phone...", imageName: "asset_train_in_2", character: Characters(name: "Security Officer", sprite: "Security Guard"), transition: .none, conditionNumber: 101),
        Storyline(line: "(Wow, I felt happy & relieved... Hope that passenger found it.)", imageName: "asset_train_in_2", character: Characters(name: "Security Officer", sprite: "Robert glasses"), transition: .outcome, conditionNumber: 101)
    ]
    
    static let thiefStorylineTwo: [Storyline] = [
        Storyline(line: "(Putting the phone in the bag)", imageName: "asset_train_in", character: Characters(name: "Robert", sprite: "Robert glasses side smile"), conditionNumber: 102),
        Storyline(line: "Hmm?", imageName: "asset_train_in", character: Characters(name: "Security Officer", sprite: "Security Guard"), transition: .outcome, conditionNumber: 102)
    ]
    
    static let thiefStorylineThree: [Storyline] = [
        Storyline(line: "(Leave the phone there)", imageName: "asset_train_in", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 103),
        Storyline(line: "Excuse me, is this phone yours?", imageName: "asset_train_in", character: Characters(name: "Security Officer", sprite: "Security Guard"), transition: .none, conditionNumber: 103),
        Storyline(line: "No, sir. It seems that a passenger there leaving in previous station left it.", imageName: "asset_train_in", character: Characters(name: "Robert", sprite: "Robert glasses speaking"), transition: .none, conditionNumber: 103),
        Storyline(line: "Ah, okay. Thank you.", imageName: "asset_train_in", character: Characters(name: "Security Officer", sprite: "Robert glasses"), transition: .none, conditionNumber: 103),
        Storyline(line: "(Why I didn't report it out of my goodwill...)", imageName: "asset_train_in", character: Characters(name: "Robert", sprite: "Robert glasses sad"), transition: .outcome, conditionNumber: 103)
    ]
    
    static let prioritySeatStorylineIntro: [Storyline] = [
        Storyline(line: "(going in Robert’s train carriage with her child, which is currently full for the seats)", imageName: "asset_train_in_3", character: Characters(name: "Elderly passenger", sprite: "Female passenger 3"), transition: .none),
        Storyline(line: "(seeing that passenger going in and moving my way)\n(What should I do, Robert?)", imageName: "asset_train_in_3", character: Characters(name: "Robert", sprite: "Robert glasses confused"), transition: .interactiveSmallChoice, choices: [
            Choice(text: "Zzz... Zzz...", nextStep: "priority1", verdict: .apathy),
              Choice(text: "Give the seat to them", nextStep: "priority3", verdict: .good),
              Choice(text: "Stay there while awake", nextStep: "priority2", verdict: .apathy)
            ], bubbleMessage: "Mom & her child is going in train, however my carriage is full on seat...", bubbleImage: "Robert glasses side smile")
    ]
    
    static let prioritySeatStorylineOne: [Storyline] = [
        Storyline(line: "Let’s sleep, then...", imageName: "asset_train_in_3", character: Characters(name: "Robert", sprite: "Robert glasses side smile"), transition: .none, conditionNumber: 104),
        Storyline(line: "Zzz... Zzz...", imageName: "asset_train_in_3", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 104),
        Storyline(line: "(Hmm..., he is sleeping, or not?)", imageName: "asset_train_in_3", character: Characters(name: "Elderly passenger", sprite: "Female passenger 3"), transition: .outcome, conditionNumber: 104),
    ]
    
    static let prioritySeatStorylineTwo: [Storyline] = [
        Storyline(line: "Okay, let’s keep here for now.", imageName: "asset_train_in_3", character: Characters(name: "Robert", sprite: "Robert glasses side smile"), transition: .none, conditionNumber: 103),
        Storyline(line: "(moving thru Robert's seat) Sorry, could you provide seat for them as priority users?", imageName: "asset_train_in_3", character: Characters(name: "Security officer", sprite: "Security Guard Female"), transition: .none, conditionNumber: 103),
        Storyline(line: "Ah, okay. Here.", imageName: "asset_train_in_3", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 103),
        Storyline(line: "Thank you!", imageName: "asset_train_in_3", character: Characters(name: "Elderly passenger", sprite: "Female passenger 3"), transition: .outcome, conditionNumber: 103)
    ]
    
    static let prioritySeatStorylineThree: [Storyline] = [
        Storyline(line: "Ma’am! Here’s your seat. (to other passenger besides me) Excuse me, could you provide your seat for that woman’s child?", imageName: "asset_train_in_3", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .none, conditionNumber: 101),
        Storyline(line: "Okay, here’s your seat.", imageName: "asset_train_in_3",  character: Characters(name: "Passenger", sprite: "Female passenger 2"), transition: .none, conditionNumber: 101),
        Storyline(line: "Thank you very much!", imageName: "asset_train_in_3",  character: Characters(name: "Elderly passenger", sprite: "Female passenger 3"), transition: .none, conditionNumber: 101),
        Storyline(line: "You’re welcome, and enjoy your trip~", imageName: "asset_train_in_3", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .outcome, conditionNumber: 101)
    ]
    
    static let endStorylineCisaukPreArrival: [Storyline] = [
        Storyline(line: "I’m approaching my station... Cisauk!", imageName: "asset_train_in_4", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .interactiveBigChoice, bigChoices: [
            BigChoice(text: "Exit train", nextStep: "endArrival", icon: "door.left.hand.open"),
            BigChoice(text: "Stay on train", nextStep: "endArrivalBad", icon: "hand.raised.fill"),
            ], bubbleMessage: "Cisauk! Hmm, may I get out?", bubbleImage: "Robert glasses")
    ]
    
    static let endStorylineCisaukArrivalBad: [Storyline] = [
        Storyline(line: "... Oh, no! The door is closed. And I can’t get out until the next station to get a 'going back' train.", imageName: "asset_train_in_door", character: Characters(name: "Robert", sprite: "Robert glasses sad"), transition: .none, conditionNumber: 5),
        Storyline(line: "I'm probably be late, because I need to wait some time. Calm down, Robert.", imageName: "asset_train_in_door", character: Characters(name: "Robert", sprite: "Robert glasses sad"), transition: .message, conditionNumber: 5)
    ]
    
    static let endStorylineCisaukArrival: [Storyline] = [
        Storyline(line: "Great, I’m now here in Cisauk! Now, I need to get out.", imageName: "asset_station_cisauk_2", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .paymentTapOut)
    ]
    
    static let endStorylineCisaukPostArrival1: [Storyline] = [
        Storyline(line: "That’s all from the train... Next up, I could use the free shuttle bus or use share motorcycle.", imageName: "asset_station_cisauk_2", character: Characters(name: "Robert", sprite: "Robert glasses"), conditionNumber: 2),
        Storyline(line: "When the next shuttle bus... Yes, De Park 2 bus should be depart soon. Let’s move then.", imageName: "asset_station_cisauk_intermoda", character: Characters(name: "Robert", sprite: "Robert glasses"), transition: .message, conditionNumber: 2)
    ]
    
    static let endStorylineCisaukPostArrival2: [Storyline] = [
        Storyline(line: "Huah, that marks the end of my commuting time, for now. But, what's kind of this feeling?", imageName: "asset_station_cisauk_2", character: Characters(name: "Robert", sprite: "Robert glasses exhausted"), conditionNumber: 3),
        Storyline(line: "Yes, the feeling of an apathy commuter, maybe. Looks like I'm being called to be a smart commuter.", imageName: "asset_station_cisauk_intermoda", character: Characters(name: "Robert", sprite: "Robert glasses sad"), conditionNumber: 3),
        Storyline(line: "Okay, that's not the problem right now. The bus will depart soon. Hurry!", imageName: "asset_station_cisauk_intermoda", character: Characters(name: "Robert", sprite: "Robert glasses exhausted"), transition: .message, conditionNumber: 3)
    ]
    
    static let storylineMapping: [String: [Storyline]] = [
        "intro": introStoryline,
        "intro2": introStoryline2,
        "intro3": introStoryline3,
        "introBad": introStorylineMissed,
        "thiefIntro": thiefStorylineIntro,
        "thief1": thiefStorylineOne,
        "thief2": thiefStorylineTwo,
        "thief3": thiefStorylineThree,
        "transitBad": transitStorylineMissed,
        "priorityIntro": prioritySeatStorylineIntro,
        "priority1": prioritySeatStorylineOne,
        "priority2": prioritySeatStorylineTwo,
        "priority3": prioritySeatStorylineThree,
        "endPreArrival": endStorylineCisaukPreArrival,
        "endArrivalBad": endStorylineCisaukArrivalBad,
        "endArrival": endStorylineCisaukArrival,
        "endPostArrival1": endStorylineCisaukPostArrival1,
        "endPostArrival2": endStorylineCisaukPostArrival2
    ]
    
    func startStoryline(_ name: String) {
        if let storyline = Self.storylineMapping[name] {
            DispatchQueue.main.async {
                self.currentStoryline = storyline
                self.currentIndex = 0
            }
        } else {
        }
    }
    
    func selectChoice(_ choice: Choice) {
        dataManager.fetchJourney()
        if let nextStory = Self.storylineMapping[choice.nextStep] {
            DispatchQueue.main.async {
                self.currentStoryline = nextStory
                self.currentIndex = 0
            }
        }
    }
    
    func provideCurrentAdvImage(withImage: String) {
        playerJourney?.currentAdvImage = withImage
        dataManager.saveChanges()
    }
    
    func provideCurrentBackgroundColor(color: Color) {
        playerJourney?.currentBackgroundColorHex = Converter.hexString(from: color)
        playerJourney?.currentBackgroundColorAccessibleHex = Converter.hexString(from: color)
        dataManager.saveChanges()
    }
    
    func resetStoryline() {
        currentStoryline = ADVStoryViewModel.introStoryline
        currentIndex = 0
    }
}

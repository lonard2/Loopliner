//
//  MessageViewModel.swift
//  Loopliner
//
//  Created by Lonard Steven on 30/01/25.
//

import SwiftUI
import SwiftData
import Combine

class MessageViewModel: ObservableObject {
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
    
    
    @Published var currentMessage: [Message] = message
    @Published var currentMessageIndex: Int = 0
    
    @Published var currentOutcome: [Outcome] = outcomes
    @Published var currentOutcomeIndex: Int = 0
    
    static let message: [Message] = [
        Message(id: "1", messageName: "intro_1", messageTitle: "Make Robert commute at his campus on-time!", messageBody: "Don’t make Robert late, thus missing his study there. Ah, also make sure to get Robert being a smart commuter by interacting positively to himself and his environment.", messageIcon: "Robert glasses", nextActionIcon: "play.fill", nextActionTitle: "Next", backgroundColor: Color("IntroColor"), conditionNumber: 1, messageNextStep: .none),
        Message(id: "2", messageName: "intro_2", messageTitle: "Before we depart...", messageBody: "Loopliner is an interactive game for experiencing & learning what it's like being a commuter. It takes you in helm of a new commuter, Robert which got a study opportunity in Tangerang, Indonesia.\n\nHe had a plan to go there by going from Rajawali station standing in platform 2 for getting a Cikarang Line (blue line) train, later getting a transit in Tanah Abang station via Kampung Bandan station. From there, he should take the Rangkasbitung line (green line) in platform 5 & 6 for getting out in Cisauk station.\n\nTo be able to succeed, guide him to the Cisauk station as quickly as possible. Besides that, he needs to be taught the right ways to commute, by you, the player. Thus, do the things right, like as with responsible & smart commuter!\n\nGood luck and have a nice trip!", messageIcon: "questionmark.diamond.fill", nextActionIcon: "play.fill", nextActionTitle: "Continue", backgroundColor: Color("IntroColor"), conditionNumber: 1, messageNextStep: .map),
        Message(id: "3", messageName: "success_message", messageTitle: "Robert successfully commute!", messageBody: "Being a smart commuter is a huge feat for him, which will make a great precedent to his life in the future.\nKeep up the great job, Robert.", messageIcon: "checkmark.circle.fill", secondMessageIcon: "Robert glasses side smile", nextActionIcon: "play.fill", nextActionTitle: "Next", backgroundColor: Color("SuccessBackgroundColor"), conditionNumber: 2, messageNextStep: .nextmessageend),
        Message(id: "4", messageName: "apathy_message", messageTitle: "Robert arrived, but have one thing to do.", messageBody: "He’s still not understand what’s to be a smart commuter. Try to increase your apathy, maybe?", messageIcon: "minus.circle.fill", secondMessageIcon: "Robert glasses neutral", nextActionIcon: "play.fill", nextActionTitle: "Next", backgroundColor: Color("ApathyBackgroundColor"), conditionNumber: 3, messageNextStep: .nextmessageend),
        Message(id: "5", messageName: "bad_message_general", messageTitle: "Try again better, Robert!", messageBody: "Looks like Robert is missing something, that led to missing his intended train for getting on time to his campus. Check again your time & planning, okay?", messageIcon: "x.circle.fill", secondMessageIcon: "Robert glasses sad", nextActionIcon: "play.fill", nextActionTitle: "Next", backgroundColor: Color("FailedBackgroundColor"), conditionNumber: 4, messageNextStep: .nextmessageend),
        Message(id: "6", messageName: "bad_message_missed", messageTitle: "You missed, Robert!", messageBody: "Robert miss the final destination, and later going to stations far, far away.\nHe got out and later take another train in opposite direction, only met with him missing his next transportation. Better plan, Robert!", messageIcon: "x.circle.fill", secondMessageIcon: "Robert glasses sad", nextActionIcon: "play.fill", nextActionTitle: "Next", backgroundColor: Color("FailedBackgroundColor"), conditionNumber: 5, messageNextStep: .nextmessageend),
        Message(id: "7", messageName: "bad_message_missed_early", messageTitle: "Oh no, missed!", messageBody: "Robert seems to confused, being waiting on the wrong platform.\nAfter a train to wrong direction arrived, he jumps in. Some time passed and he suddenly shocked to see that he gets on the wrong train.\nBe careful next time!", messageIcon: "x.circle.fill", secondMessageIcon: "Robert glasses sad", nextActionIcon: "play.fill", nextActionTitle: "Next", backgroundColor: Color("FailedBackgroundColor"), conditionNumber: 6, messageNextStep: .nextmessageend),
        Message(id: "8", messageName: "end_screen", messageTitle: "Thank you for using Commuter Line service!", messageBody: "Robert was using the KRL Commuter Line service in Jakarta region. Known as the most popular commuter train in Indonesia, almost 800.000 daily users use the service even frequently reaching more at holidays which counts at about 1.3 million users per day.\n\nOperated since 1925, the service is now operating with five different lines (with an additional airport line) serving numerous areas in Metropolitan Jakarta.With the large development of public transportation service in Jakarta nowadays, with one reason to reduce emissions in city, it’s also now integrated with various modes. Those includes BRT or bus rapid transit (Transjakarta) and MRT/metro.\n\nThank you for playing Loopliner, and always be a smart commuter!\nLonard Steven", messageIcon: "exclamationmark.bubble.fill", nextActionIcon: "arrow.uturn.left", nextActionTitle: "Loop back to main", backgroundColor: Color("NeutralBackgroundColor"), conditionNumber: 7, messageNextStep: .menu)
    ]
    
    static let outcomes: [Outcome] = [
        Outcome(id: "1", outcomeName: "Success Outcome", outcomeTitle: "Hooray!", outcomeBody: "You’re doing the right thing!\nMake the public transport safer & better for everyone by helping them.", outcomeIcon: "heart.fill", outcomeIconColor: Color.white, nextActionIcon: "play.fill", nextActionTitle: "Continue", shapeBackgroundColor: Color("SuccessOutcomeColor"), conditionNumber: 101, outcomeNextStep: .map),
        Outcome(id: "2", outcomeName: "Crime Outcome", outcomeTitle: "Oh no...", outcomeBody: "You are arrested by the security guard, and later blacklisted from riding the train system due to commiting a crime.\nA crime is harming you, someone & everyone, so say no to that!", outcomeIcon: "heart.slash.fill", outcomeIconColor: Color("FailedOutcomeIconColor"), nextActionIcon: "arrow.uturn.left", nextActionTitle: "Loop back to main", shapeBackgroundColor: Color("FailedOutcomeColor"), rotateShape: 30, conditionNumber: 102, outcomeNextStep: .menu),
        Outcome(id: "3", outcomeName: "Apathy Outcome", outcomeTitle: "It’s a shame...", outcomeBody: "Do you want to be an apathy public transport user?\nPublic transport is a way to practice your kindness to others, so get proactive as a user :)", outcomeIcon: "face.smiling.inverse", outcomeIconColor: Color("ApathyOutcomeIconColor"), nextActionIcon: "play.fill", nextActionTitle: "Continue", shapeBackgroundColor: Color("ApathyOutcomeColor"), rotateShape: 30, conditionNumber: 103, outcomeNextStep: .map),
        Outcome(id: "4", outcomeName: "Apathy Outcome by Sleeping", outcomeTitle: "It’s a shame...", outcomeBody: "Do you want to be an apathy public transport user, even by sleeping?\nPublic transport is a way to practice your kindness to others, so get proactive as a user :)", outcomeIcon: "face.smiling.inverse", outcomeIconColor: Color("ApathyOutcomeIconColor"), nextActionIcon: "play.fill", nextActionTitle: "Continue", shapeBackgroundColor: Color("ApathyOutcomeColor"), rotateShape: 30, conditionNumber: 104, outcomeNextStep: .map)
    ]
    
    static func getMessages(for condition: String) -> [Message] {
        return message.filter{ $0.conditionNumber == Int(condition) }
    }
    
    static func getOutcomes(for condition: String) -> [Outcome] {
        return outcomes.filter{ $0.conditionNumber == Int(condition) }
    }
}

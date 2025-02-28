//
//  Message.swift
//  Loopliner
//
//  Created by Lonard Steven on 30/01/25.
//

import SwiftUI
import SwiftData

@Model
class Message {
    var id: String
    var messageName: String
    var messageTitle: String
    var messageBody: String
    
    var messageIcon: String
    var secondMessageIcon: String?
    
    var nextActionIcon: String
    var nextActionTitle: String
    
    var backgroundColorHex: String
    var conditionNumber: Int
    
    var messageNextStep: MessageNextStep?
    
    init(id: String, messageName: String, messageTitle: String, messageBody: String, messageIcon: String, secondMessageIcon: String? = nil, nextActionIcon: String, nextActionTitle: String, backgroundColor: Color, conditionNumber: Int, messageNextStep: MessageNextStep? = .none) {
        self.id = id
        self.messageName = messageName
        self.messageTitle = messageTitle
        self.messageBody = messageBody
        self.messageIcon = messageIcon
        self.secondMessageIcon = secondMessageIcon
        self.nextActionIcon = nextActionIcon
        self.nextActionTitle = nextActionTitle
        self.backgroundColorHex = Converter.hexString(from: backgroundColor)
        self.conditionNumber = conditionNumber
        self.messageNextStep = messageNextStep
    }
    
    var backgroundColor: Color {
        Converter.color(from: backgroundColorHex) ?? .black
    }
}

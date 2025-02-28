//
//  ADV.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftData

@Model
class Characters: Identifiable {
    var name: String
    var sprite: String
    
    init(name: String, sprite: String) {
        self.name = name
        self.sprite = sprite
    }
}

@Model
class Storyline: Identifiable {
    var line: String
    var imageName: String?
    var choices: [Choice]?
    var bigChoices: [BigChoice]?
    var character: Characters?
    var transition: StorylineTransition
    var conditionNumber: Int?
    
    var bubbleMessage: String?
    var bubbleImage: String?
    
    init(line: String, imageName: String? = nil, character: Characters? = nil, transition: StorylineTransition = .none, conditionNumber: Int? = nil, choices: [Choice]? = nil, bigChoices: [BigChoice]? = nil, bubbleMessage: String? = nil, bubbleImage: String? = nil) {
        self.line = line
        self.imageName = imageName
        self.character = character
        self.transition = transition
        self.conditionNumber = conditionNumber
        self.choices = choices
        self.bigChoices = bigChoices
        self.bubbleImage = bubbleImage
        self.bubbleMessage = bubbleMessage
    }
}

@Model
class Choice: Identifiable {
    var text: String
    var nextStep: String
    var verdict: String?
    
    init(text: String, nextStep: String, verdict: Verdict? = nil) {
        self.text = text
        self.nextStep = nextStep
        self.verdict = verdict?.rawValue
    }
    
    var verdictEnum: Verdict? {
        return Verdict(rawValue: verdict ?? "")
    }
}

@Model
class BigChoice: Identifiable {
    var text: String
    var nextStep: String
    var verdict: String?
    var icon: String
    
    init(text: String, nextStep: String, verdict: Verdict? = nil, icon: String) {
        self.text = text
        self.nextStep = nextStep
        self.verdict = verdict?.rawValue
        self.icon = icon
    }
    
    var verdictEnum: Verdict? {
        return Verdict(rawValue: verdict ?? "")
    }
}



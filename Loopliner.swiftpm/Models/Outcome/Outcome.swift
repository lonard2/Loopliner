//
//  Outcome.swift
//  Loopliner
//
//  Created by Lonard Steven on 31/01/25.
//

import SwiftUI
import SwiftData

@Model
class Outcome {
    var id: String
    var outcomeName: String
    var outcomeTitle: String
    var outcomeBody: String
    
    var outcomeIcon: String
    var outcomeIconColorHex: String
    
    var nextActionIcon: String
    var nextActionTitle: String
    
    var shapeBackgroundColorHex: String
    var rotateShape: Int?
    var conditionNumber: Int
    
    var outcomeNextStep: OutcomeNextStep?
    
    init(id: String, outcomeName: String, outcomeTitle: String, outcomeBody: String, outcomeIcon: String, outcomeIconColor: Color, nextActionIcon: String, nextActionTitle: String, shapeBackgroundColor: Color, rotateShape: Int? = nil, conditionNumber: Int, outcomeNextStep: OutcomeNextStep? = .none) {
        self.id = id
        self.outcomeName = outcomeName
        self.outcomeTitle = outcomeTitle
        self.outcomeBody = outcomeBody
        self.outcomeIcon = outcomeIcon
        self.outcomeIconColorHex = Converter.hexString(from: outcomeIconColor)
        self.nextActionIcon = nextActionIcon
        self.nextActionTitle = nextActionTitle
        self.shapeBackgroundColorHex = Converter.hexString(from: shapeBackgroundColor)
        self.rotateShape = rotateShape
        self.conditionNumber = conditionNumber
        self.outcomeNextStep = outcomeNextStep
    }
    
    var shapeBackgroundColor: Color {
        Converter.color(from: shapeBackgroundColorHex) ?? .black
    }
    
    var outcomeIconColor: Color {
        Converter.color(from: outcomeIconColorHex) ?? .black
    }
}

//
//  Verdict.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

enum Verdict: String, Codable {
    case good
    case bad
    case apathy
    case nonverdictable
    case unknown
}

enum OutcomeNextStep: String, Codable  {
    case map
    case menu
    case unknown
}

enum MessageNextStep: String, Codable {
    case nextmessageend
    case menu
    case map
    case unknown
}

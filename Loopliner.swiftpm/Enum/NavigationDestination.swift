//
//  NavigationDestination.swift
//  Loopliner
//
//  Created by Lonard Steven on 21/01/25.
//

enum NavigationDestination: Hashable {
    case menuView
    case settingsView
}

enum StorylineTransition: Codable {
    case message
    case map
    case interactiveBigChoice
    case interactiveSmallChoice
    case outcome
    case paymentTapIn
    case paymentTapOut
    case none
}

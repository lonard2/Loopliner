//
//  TrainSettings.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

enum TrainSettings: Int, Equatable, Codable {
    case train1035 = 1 // set time & train running 10.35
    case train1109 = 2 // set time & train running 11.09
    case train1134 = 3 // set time & train running 11.34
    case nonselected = 0
}

enum MapViewMode {
    case interactive
    case journey
    case unknown
}

enum InteractiveViewMode: Equatable {
    case paymentTapIn
    case paymentTapOut
    case balanceCheck
    case balanceCheckEnd
    case platformSelect
    case trainSelect
    case goToMessage(withCondition: Int)
    case goToIntermission
    case goToAdv(withStoryline: String)
    case smallChoice
    case bigChoice
    case unknown
}

enum IntermissionViewMode {
    case waiting
    case aboarding
    case unknown
}

enum DraggableItemType {
    case smartphone
    case walletCard
}


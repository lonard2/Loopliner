//
//  DragItem.swift
//  Loopliner
//
//  Created by Lonard Steven on 06/02/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct DragItem: Codable, Transferable {
    let itemType: String
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .plainText)
    }
}

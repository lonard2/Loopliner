//
//  DropTargetView.swift
//  Loopliner
//
//  Created by Lonard Steven on 01/02/25.
//

import SwiftUI

struct DropTargetView: View {
    let geo: GeometryProxy
    var image: String
    var validItem: String
    @Binding var draggedItem: String?
    var onDropAction: () -> Void
    
    var body: some View {
        Image(image)
            .resizable()
            .scaleEffect(draggedItem == validItem ? 1.1 : 1.0)
            .onDrop(of: [.text], isTargeted: nil) { providers in
                if let provider = providers.first {
                    provider.loadObject(ofClass: NSString.self) { object, _ in
                        if let droppedItem = object as? String {
                            DispatchQueue.main.async {
                                if droppedItem == validItem {
                                    onDropAction()
                                    draggedItem = nil
                                } else {
                                    showInvalidDropWarning()
                                    draggedItem = nil
                                }
                            }
                        }
                    }
                    return true
                }
                return false
            }
            .onChange(of: draggedItem) { _ in
                withAnimation(.bouncy()) {}
            }
    }
    
    private func showInvalidDropWarning() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name("InvalidDropWarning"), object: draggedItem ==   "You use the wrong item!\nSmartphone are used for scanning your paid QR Ticket at the QR Scanner and the card are used for tapping at the ticket machine.")
        }
    }
}

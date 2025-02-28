//
//  DraggableItem.swift
//  Loopliner
//
//  Created by Lonard Steven on 01/02/25.
//

import SwiftUI

struct DraggableItem: View {
    let geo: GeometryProxy
    let image: String
    let itemType: String
    @Binding var draggedItem: String?
    var animationNamespace: Namespace.ID
    
    var body: some View {
        Image(image)
            .resizable()
            .matchedGeometryEffect(id: itemType, in: animationNamespace)
            .scaleEffect(draggedItem == itemType ? 1.2 : 1.0)
            .onDrag {
                draggedItem = itemType
                return NSItemProvider(object: itemType as NSString)
            }
            .onChange(of: draggedItem) { _ in
                withAnimation(.interactiveSpring()) {}
            }
    }
}

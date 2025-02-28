//
//  SmallChoiceButton.swift
//  Loopliner
//
//  Created by Lonard Steven on 03/02/25.
//

import SwiftUI

struct SmallChoiceButton: View {
    let geo: GeometryProxy
    let choices: [Choice]
    let onChoiceSelected: (Choice) -> Void
    
    @StateObject private var imageView = ImageView()
    
    @Namespace private var animationNamespace
    
    var gridColumns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    var body: some View {
        VStack(alignment: .center) {
            if choices.isEmpty {
                Text("No choices available")
                    .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.024))
            } else {
                smallChoicesGrid
            }
        }
        .minimumScaleFactor(0.55)
    }
    
    private var smallChoicesGrid: some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(choices, id: \.id) { choice in
                smallChoicesCard(for: choice)
                    .onTapGesture {
                        AudioManager.helper.playSFX(assetName: "Button Pressing")
                        onChoiceSelected(choice)
                    }
            }
        }
        .padding(.all, 8)
        .frame(alignment: .center)
    }
    
    private func smallChoicesCard(for choice: Choice) -> some View {
        @Namespace var animationNamespace
        
        return RoundedRectangle(cornerRadius: 24)
            .fill(Color("ChoiceButtonColor"))
            .frame(width: geo.size.width * 0.24, height: geo.size.height * 0.18)
            .overlay {
                VStack {
                    Text(choice.text)
                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.032))
                        .matchedGeometryEffect(id: "smallChoiceText-\(choice.text)", in: animationNamespace)
                        .multilineTextAlignment(.center)
                }
                .foregroundStyle(Color.black)
                .shadow(radius: 8)
                .transition(.scale.combined(with: .opacity))
                .animation(.spring(response: 0.35, dampingFraction: 0.8), value: choice)
                .padding(.all, 8)
                .frame(alignment: .center)
            }
            .accessibilityLabel("Choice item: \(choice.text)")
            .accessibilityHint("Select to pick the \(choice.text) choice")
    }
}

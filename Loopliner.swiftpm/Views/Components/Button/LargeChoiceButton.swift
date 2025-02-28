//
//  LargeChoiceButton.swift
//  Loopliner
//
//  Created by Lonard Steven on 03/02/25.
//

import SwiftUI

struct LargeChoiceButton: View {
    let geo: GeometryProxy
    let choices: [BigChoice]
    let onChoiceSelected: (BigChoice) -> Void
    
    @StateObject private var imageView = ImageView()
    
    @Namespace private var animationNamespace
    
    var gridColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .center) {
            if choices.isEmpty {
                Text("No choices available")
                    .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.064))
            } else {
                largeChoicesGrid
            }
        }
    }
    
    private var largeChoicesGrid: some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(choices, id: \.id) { train in
                largeChoiceCard(for: train)
                .onTapGesture {
                    AudioManager.helper.playSFX(assetName: "Button Pressing")
                    onChoiceSelected(train)
                }
            }
        }
        .padding(.all, 8)
        .frame(alignment: .center)
    }
    
    private func largeChoiceCard(for choice: BigChoice) -> some View {
        @Namespace var animationNamespace
        
        return RoundedRectangle(cornerRadius: 24)
            .fill(Color("LargeChoiceButtonColor"))
            .frame(width: geo.size.width * 0.28, height: geo.size.height * 0.48)
            .overlay {
                VStack {
                    if UIImage(systemName: choice.icon) != nil {
                        Image(systemName: choice.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.128)
                            .accessibilityHidden(true)
                    } else {
                        Image(choice.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.128)
                            .accessibilityHidden(true)
                    }
                    
                    Text(choice.text)
                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.032))
                        .matchedGeometryEffect(id: "choiceText-\(choice.text)", in: animationNamespace)
                        .multilineTextAlignment(.center)
                }
                .foregroundStyle(Color.black)
                .shadow(radius: 8)
                .transition(.scale.combined(with: .opacity))
                .animation(.spring(response: 0.35, dampingFraction: 0.8), value: choice)
                .padding(.all, 8)
                .frame(alignment: .center)
                .accessibilityLabel("Choice item: \(choice.text)")
                .accessibilityHint("Select to pick the \(choice.text) choice")
            }
    }
}

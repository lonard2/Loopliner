//
//  PlatformSelectView.swift
//  Loopliner
//
//  Created by Lonard Steven on 02/02/25.
//

import SwiftUI

struct PlatformSelectView : View {
    let geo: GeometryProxy
    let station: Station
    @Binding var interactiveMode: InteractiveViewMode
    @Binding var showJourneySheet: Bool
    
    @Namespace private var animationNamespace
    
    var gridColumns: [GridItem] {
        let columnCount = min(station.platforms.count, max(3, Int(sqrt(Double(station.platforms.count)).rounded())))
        return Array(repeating: GridItem(.flexible(), spacing: 8), count: columnCount)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            LazyVGrid(columns: gridColumns, spacing: 8) {
                ForEach(station.platforms.sorted(by: { $0.id < $1.id }), id: \.id) { platform in
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color("PlatformSelectButtonColor"))
                        .frame(width: geo.size.width * 0.32, height: geo.size.height * 0.64)
                        .overlay {
                            VStack(alignment: .center) {
                                Text("PLATFORM")
                                    .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.024))
                                    .matchedGeometryEffect(id: "platformTitle-\(platform.id)", in: animationNamespace)
                                
                                Text(platform.platformName)
                                    .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.160))
                                    .matchedGeometryEffect(id: "platformName-\(platform.id)", in: animationNamespace)
                                
                                Text(platform.platformDesc)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.028))
                                    .matchedGeometryEffect(id: "platformDesc-\(platform.id)", in: animationNamespace)
                            }
                            .shadow(radius: 8)
                            .transition(.scale.combined(with: .opacity))
                            .animation(.spring(response: 0.35, dampingFraction: 0.8), value: station)
                            .padding(.all, 8)
                            .frame(alignment: .center)
                        }
                        .onTapGesture {
                            AudioManager.helper.playSFX(assetName: "Button Pressing")
                            handlePlatformSelection(station: station, platform: platform)
                        }
                        .minimumScaleFactor(0.55)
                        .accessibilityElement(children: .combine)
                }
            }
        }
        .foregroundStyle(.white)
    }
    
    func handlePlatformSelection(station: Station, platform: StationPlatforms) {
        switch (station.id, platform.id) {
        case ("16", "1"):
            DispatchQueue.main.async {
                interactiveMode = .goToAdv(withStoryline: "introBad")
            }
        case ("16", "2"):
            DispatchQueue.main.async {
                interactiveMode = .goToIntermission
            }
        case ("23", "1"):
            DispatchQueue.main.async {
                interactiveMode = .goToAdv(withStoryline: "transitBad")
            }
        case ("23", "2"):
            DispatchQueue.main.async {
                interactiveMode = .trainSelect
            }
        default:
            DispatchQueue.main.async {
                interactiveMode = .unknown
            }
        }
    }
}

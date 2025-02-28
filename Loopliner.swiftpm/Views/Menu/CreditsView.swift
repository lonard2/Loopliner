//
//  CreditsView.swift
//  Loopliner
//
//  Created by Lonard Steven on 12/02/25.
//

import SwiftUI

struct CreditsView: View {
    // gradients for the menu items
    private var creditsBoxGradient = Gradient(colors: [
        Color("CreditsGreyOne"),
        Color("CreditsGreyTwo"),
        Color("CreditsGreyThree")
    ])
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var audioManager = AudioManager.helper
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(AngularGradient(gradient: creditsBoxGradient, center: .center, startAngle: .degrees(0), endAngle: .degrees(200)))
                        .frame(width: geo.size.width * 0.92, height: geo.size.height * 0.86)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 4)
                        .overlay {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .frame(width: geo.size.width * 0.016, height: geo.size.height * 0.016)
                                        .accessibilityHidden(true)
                                    
                                    Text("Pictures & icons")
                                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.016))
                                }
                                .padding(.vertical, geo.size.width * 0.004)
                                
                                
                                Text("All images shown in the journey are taken by myself,  during period of March - December 2024 in several Jakarta commuter line stations: Rajawali, Kampung Bandan, Tanah Abang, Manggarai, and Cisauk.\nExceptions include: 2 Commuter Line train pictures, used in intermission view, which are explicitly declared as public domain via Creative Commons Zero 1.0 license by their owners:\n[(https://commons.wikimedia.org/wiki/File:KRL_205JR.jpg)](https://commons.wikimedia.org/wiki/File:KRL_205JR.jpg)\n[(https://commons.wikimedia.org/wiki/File:JR_205_Masuk_Jakarta_Kota.jpg)](https://commons.wikimedia.org/wiki/File:JR_205_Masuk_Jakarta_Kota.jpg)\nAll icons used in this game are based on SF Symbols 6.0")
                                        .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.016))
                                
                                HStack {
                                    Text("T")
                                        .font(.system(size: geo.size.width * 0.016))
                                        .fontWeight(.light)
                                        .accessibilityHidden(true)
                                    
                                    Text("Typography")
                                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.016))
                                }
                                .padding(.vertical, geo.size.width * 0.004)
                                
                                Text("All fonts used are open-source fonts & licensed under SIL Open Font License 1.1 (https://openfontlicense.org/):\nSpace Grotesk [(https://github.com/floriankarsten/space-grotesk)](https://github.com/floriankarsten/space-grotesk), Unica One [(https://github.com/etunni/unica)](https://github.com/etunni/unica) & Space Mono [(https://github.com/googlefonts/spacemono)](https://github.com/googlefonts/spacemono)")
                                    .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.016))
                                
                                HStack {
                                    Image(systemName: "music.note")
                                        .resizable()
                                        .frame(width: geo.size.width * 0.016, height: geo.size.height * 0.024)
                                        .accessibilityHidden(true)
                                    
                                    Text("Music & Sound effects")
                                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.016))
                                }
                                .padding(.vertical, geo.size.width * 0.004)
                                
                                Text("All music are created by myself, using GarageBand for iOS.\nSound effects are all made by freesound_community [(https://pixabay.com/users/freesound_community-46691455/)](https://pixabay.com/users/freesound_community-46691455/) from Pixabay:\nbutton-pressed  [(https://pixabay.com/sound-effects/button-pressed-38129/)](https://pixabay.com/sound-effects/button-pressed-38129/), Electric train [(https://pixabay.com/sound-effects/electric-train-27377/)](https://pixabay.com/sound-effects/electric-train-27377/), Train entering & leaving station [(https://pixabay.com/sound-effects/train-entering-and-leaving-station-23301/)](https://pixabay.com/sound-effects/train-entering-and-leaving-station-23301/), correct [(https://pixabay.com/sound-effects/correct-38597/)](https://pixabay.com/sound-effects/correct-38597/) and Short beep tone [(https://pixabay.com/sound-effects/short-beep-tone-47916/)](https://pixabay.com/sound-effects/short-beep-tone-47916/)")
                                    .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.014))
                                
                                HStack {
                                    Image(systemName: "paintpalette.fill")
                                        .resizable()
                                        .frame(width: geo.size.width * 0.016, height: geo.size.height * 0.016)
                                        .accessibilityHidden(true)
                                    
                                    Text("Art & assets")
                                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.016))
                                }
                                .padding(.vertical, geo.size.width * 0.004)
                                
                                Text("All character portraits are made by me in Inkscape, an open-source vector graphics software.\nIn addition to that, app logo & payment assets (card reader, smartphone, etc.) are all drawn in Figma by myself, too.")
                                    .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.016))
                            }
                            .accessibilityElement(children: .ignore)
                            .padding(.horizontal, 64)
                            .padding(.vertical, 32)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        }
                    
                    HStack {
                        Button(action: {
                            AudioManager.helper.playSFX(assetName: "Button Pressing")
                            dismiss()
                        }) {
                            RoundedRectangle(cornerRadius: 32)
                                .fill(
                                    Color("MiscButtonColor")
                                )
                                .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.06)
                                .padding(.all, 16)
                                .overlay {
                                    HStack(alignment: .center) {
                                        
                                        Image(systemName: "arrowshape.backward.fill")
                                            .font(.system(size: 48))
                                        
                                        Text("Back")
                                            .font(.custom("SpaceGrotesk-Bold", size: 32))
                                    }
                                }
                        }
                        .accessibilityLabel("Back button")
                        .accessibilityHint("Select to back to the main menu.")
                        
                        Spacer()
                        
                        Text("CREDITS")
                            .font(.custom("UnicaOne-Regular", size: geo.size.width * 0.072))
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 8)
                }
            }
            .foregroundStyle(Color.black)
            .padding(.all, 64)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color("MainColor"))
            .navigationBarBackButtonHidden(true)
        }
    }
}

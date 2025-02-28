//
//  RobertBubble.swift
//  Loopliner
//
//  Created by Lonard Steven on 01/02/25.
//

import SwiftUI

struct RobertBubble: View {
    let geo: GeometryProxy
    var content: String?
    var image: String?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 32)
            .fill(Color.white)
            .overlay {
                HStack {
                    if let content = content {
                        Text(content)
                            .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.024))
                            .padding()
                            .foregroundColor(.black)
                    } else {
                        Text("No text provided")
                            .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.024))
                            .padding()
                            .foregroundColor(.black)
                    }
                    
                    if let image = image {
                        Image(image)
                            .resizable()
                            .frame(maxWidth: geo.size.width * 0.128, maxHeight: geo.size.height * 0.160)
                            .padding()
                    } else {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(maxWidth: geo.size.width * 0.128, maxHeight: geo.size.height * 0.160)
                            .padding()
                    }
                }
                .accessibilityElement(children: .combine)
                .fixedSize(horizontal: false, vertical: true)
            }
    .minimumScaleFactor(0.5)
    }
}

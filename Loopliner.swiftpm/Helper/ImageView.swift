//
//  ImageView.swift
//  Loopliner
//
//  Created by Lonard Steven on 31/01/25.
//

import SwiftUI

class ImageView: ObservableObject {
    static let shared = ImageView()
    
    func imageViewSetup(for image: String) -> some View {
        GeometryReader { geo in
            if UIImage(systemName: image) != nil {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(image)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

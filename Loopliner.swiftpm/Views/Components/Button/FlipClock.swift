//
//  FlipClock.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftUI

struct FlipClock: View {
    let geo: GeometryProxy
    var hour: String
    var minute: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color("FlipClockBG"))
            .frame(width: geo.size.width * 0.160, height: geo.size.height * 0.128)
            .overlay {
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: geo.size.width * 0.064, height: geo.size.height * 0.096)
                        .overlay {
                            Text(hour)
                                .font(.system(size: geo.size.width * 0.032))
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 4)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: geo.size.width * 0.064, height: geo.size.height * 0.096)
                        .overlay {
                            Text(minute)
                                .font(.system(size: geo.size.width * 0.032))
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 4)
                }
                .padding(.all, 8)
            }
    }
}

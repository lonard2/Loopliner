//
//  CheckMachineView.swift
//  Loopliner
//
//  Created by Lonard Steven on 01/02/25.
//

import SwiftUI

struct CheckMachineView: View {
    let geo: GeometryProxy
    var content: String?
    var image: String?
    var balance: Int
    
    @StateObject private var formatting = Formatting.shared
        
    var body: some View {
        RoundedRectangle(cornerRadius: 32)
            .frame(width: geo.size.width * 0.72, height: geo.size.height * 0.60)
            .foregroundStyle(Color("CheckBalanceColor"))
            .overlay {
                VStack(spacing: 8) {
                    Text("JAKARTA COMMUTER SYSTEM")
                        .font(.custom("SpaceMono-Bold", size: geo.size.width * 0.032))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                    Text("REMAINING BALANCES")
                        .font(.custom("SpaceMono-Bold", size: geo.size.width * 0.032))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formatting.formatToRupiah(balance))
                        .font(.custom("SpaceMono-Bold", size: geo.size.width * 0.032))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            .accessibilityElement(children: .combine)
    }
}

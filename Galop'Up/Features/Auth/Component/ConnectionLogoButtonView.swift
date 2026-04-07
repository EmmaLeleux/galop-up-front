//
//  GoogleButtonView.swift
//  Galop'Up
//
//  Created by Emma on 07/04/2026.
//

import SwiftUI

struct ConnectionLogoButtonView: View {
    var logo: ImageResource
    var body: some View {
        Image(logo)
            .resizable()
            .scaledToFit()
            .padding(15)
            .overlay(
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2).foregroundStyle(.darkBrown)
            )
            .frame(width: 100)
        
        
    }
}

#Preview {
    ConnectionLogoButtonView(logo: .google)
}

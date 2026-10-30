//
//  ConversationComponentView.swift
//  Galop'Up
//
//  Created by Emma on 07/06/2026.
//

import SwiftUI

struct ConversationComponentView: View {
    var text: String
    var directionDroite: Bool = false
    var body: some View {
        
        VStack(spacing: 0) {
                    Text(text)
                .font(.custom("Lato-Regular", size: 16))
                        .foregroundStyle(.darkBrown)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .frame(maxWidth: 300, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.darkBrown)
                                )
                        )
                    
            Image(.bubbleTail)
                
                .padding(EdgeInsets(top: -0.7, leading: directionDroite ? 0 : -40, bottom: 0, trailing: directionDroite ? -40 : 0))
                .zIndex(1)
                .scaleEffect(x: directionDroite ? 1 : -1)
                }
            

    }
}

#Preview {
    ConversationComponentView(text: "Hello")
}

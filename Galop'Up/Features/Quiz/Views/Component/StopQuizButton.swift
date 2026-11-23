//
//  StopQuizButton.swift
//  Galop'Up
//
//  Created by Emma on 03/11/2026.
//

import SwiftUI

struct StopQuizButton: View {
    @Binding var playQuizVM: PlayQuizViewModel
    var body: some View {
        Button(action: {
            playQuizVM.openPopup.toggle()
        }, label: {
            Image(.plus)
                .foregroundStyle(.darkBrown)
                .rotationEffect(Angle(degrees: 45))
                .padding(10)
        })
    }
}


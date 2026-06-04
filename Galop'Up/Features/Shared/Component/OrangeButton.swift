//
//  OrangeButtonComponent.swift
//  Galop'Up
//
//  Created by Emma on 27/05/2026.
//

import SwiftUI

extension View {
    @ViewBuilder
    func orangeButton(
    ) -> some View {

            self
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .font(.custom("Lato-Bold", size: 14))
            .frame(maxWidth: .infinity)
            .foregroundStyle(.orangeBackground)
            .background(.orangeButton)
            .clipShape(Capsule())
    }
}

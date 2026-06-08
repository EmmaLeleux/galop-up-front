//
//  MascotteSize.swift
//  Galop'Up
//
//  Created by Emma on 07/06/2026.
//

import SwiftUI

extension View {
    @ViewBuilder
    func mascotteSize(
    ) -> some View {

            self
            .scaledToFit()
            .frame(height: 184)
    }
}

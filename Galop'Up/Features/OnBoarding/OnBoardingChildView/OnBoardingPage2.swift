//
//  OnBoardingPage2.swift
//  Galop'Up
//
//  Created by Emma on 03/06/2026.
//

import SwiftUI

struct OnBoardingPage2: View {
    var onComplete: () -> Void
    var body: some View {
        VStack{
            Text("page 2")
            Button("Suivant") {
                onComplete()
            }
        }
    }
}

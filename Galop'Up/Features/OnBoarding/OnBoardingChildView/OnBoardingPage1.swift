//
//  OnBoardingPage1.swift
//  Galop'Up
//
//  Created by Emma on 03/06/2026.
//

import SwiftUI

struct OnBoardingPage1: View {
    var onComplete: () -> Void
    var body: some View {
        VStack{
            Text("page 1")
            Button("Suivant") {
                onComplete()
            }
        }
        
    }
}

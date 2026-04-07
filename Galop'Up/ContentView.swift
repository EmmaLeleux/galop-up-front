//
//  ContentView.swift
//  Galop'Up
//
//  Created by Emma on 07/04/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.orangeBackground
                .ignoresSafeArea()
            
            VStack {
                Button(action:{
                    
                }, label: {
                    ConnectionLogoButtonView(logo: .google)
                })
                
            }
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}

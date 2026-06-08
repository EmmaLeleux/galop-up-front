//
//  ContentView.swift
//  Galop'Up
//
//  Created by Emma on 07/04/2026.
//

import SwiftUI

struct ContentView: View {
    @State var authService = AuthService()
    var googleFunction = GoogleFunctions()
    var body: some View {
        ZStack{
            Color.orangeBackground
                .ignoresSafeArea()
        
            if authService.isAuthenticated {
                if authService.currentUser?.level == nil{
                    OnBoardingView()
                }
                else{
                    VStack {
                        Button(action:{
                            Task{
                               try await authService.fetchUser()
                            }
                            
                        }, label: {
                            Text("fetch")
                        })
                        
                        Button(action:{
                            authService.logout()
                        }, label: {
                            Text("logout")
                        })
                        
                    }
                    .padding()
                }
                
            }
            else{
                authentificationView()
            }
        }
        .environment(authService)
        
    }
}

#Preview {
    ContentView()
}

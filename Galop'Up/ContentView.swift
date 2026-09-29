//
//  ContentView.swift
//  Galop'Up
//
//  Created by Emma on 07/04/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthService.self) var authService
    @Environment(\.scenePhase) private var scenePhase
    var googleFunction = GoogleFunctions()
    var body: some View {
        ZStack{
            Color.orangeBackground
                .ignoresSafeArea()
        
            if authService.isCheckingSession {
                        ProgressView() //TODO: mettre le splash screen à la place
                    }
            
            else if authService.isAuthenticated {
                if authService.currentUser?.level == nil{
                    OnBoardingView()
                }
               
            
                else{
                    TabView{
                        
                        
                        DashboardQuizView()
                            .tabItem {
                                Image(.chronoIcon)
                                
                                Text("S'entraîner")
                            }
                        
                        
                        LessonView()
                            .tabItem {
                                Image(.bookIcon)
                                
                                Text("Apprendre")
                            }
                        
                        
                        EventView()
                            .tabItem {
                                Image(.horseTrailer)
                                
                                Text("Evènements")
                            }
                        
                        
                        
                        ForumView()
                            .tabItem {
                                Image(.horseSpeaking)
                                
                                Text("Forum")
                            }
                    }
                    .tint(.customBrown)
                    .foregroundStyle(.customBrown)
                }
                
            }
            else{
                authentificationView()
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
                    if newPhase == .active {
                        Task {
                            try? await authService.fetchUser()
                        }
                    }
                }
        
        
    }
}

#Preview {
    let tokenStore = TokenStore()
    ContentView().environment(AuthService(apiClient: APIClient(tokenStore: tokenStore), tokenStore: tokenStore))
}

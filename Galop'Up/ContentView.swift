//
//  ContentView.swift
//  Galop'Up
//
//  Created by Emma on 07/04/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthViewModel.self) var authVM
    @Environment(QuizSessionViewModel.self) var quizVM
    @Environment(\.scenePhase) private var scenePhase
    var googleFunction = GoogleFunctions()
    var body: some View {
        ZStack{
            Color.orangeBackground
                .ignoresSafeArea()
            
            if authVM.isCheckingSession {
                SplashScreenView()                    }
            
            else if authVM.isAuthenticated {
                
                if authVM.currentUser?.level == nil{
                    OnBoardingView()
                }
                
                
                else{
                    
                    if let session = quizVM.activeSession, session.status != .ABANDONE {
                        if session.status == .EN_COURS{
                            QuizGameView()
                                .transition(.move(edge: .bottom))
                                .zIndex(1)
                        }
                        else if session.status == .TERMINE{
                            ResultQuizView()
                        }
                        
                    }
                    
                    else{
                        NavigationStack{
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
                }
                
                ErrorMessageComponentView()
                
            }
            else{
                authentificationView()
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                Task {
                    try? await authVM.fetchUser()
                }
            }
        }
        
        
    }
}


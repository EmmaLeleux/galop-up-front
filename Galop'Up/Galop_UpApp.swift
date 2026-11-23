//
//  Galop_UpApp.swift
//  Galop'Up
//
//  Created by Emma on 07/04/2026.
//

import SwiftUI

@main
struct Galop_UpApp: App {
    let authVM: AuthViewModel
    let pictureVM: PictureViewModel
    let postVM: PostViewModel
    let quizVM: QuizSessionViewModel
    let errorVM: ErrorViewModel
    let eventVM: EventViewModel
    let lessonVM: LessonViewModel
    
    init() {
        let tokenStore = TokenStore()
        errorVM = ErrorViewModel()
        let apiClient = APIClient(tokenStore: tokenStore, errorViewModel: errorVM)
        authVM = AuthViewModel(apiClient: apiClient, tokenStore: tokenStore)
        pictureVM = PictureViewModel(apiClient: apiClient)
        postVM = PostViewModel(apiClient: apiClient)
        quizVM = QuizSessionViewModel(apiClient: apiClient)
        eventVM = EventViewModel(apiClient: apiClient)
        lessonVM = LessonViewModel(apiClient: apiClient)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authVM)
                .environment(pictureVM)
                .environment(postVM)
                .environment(quizVM)
                .environment(errorVM)
                .environment(eventVM)
                .environment(lessonVM)
                
        }
    }
}

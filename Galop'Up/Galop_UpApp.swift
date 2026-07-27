//
//  Galop_UpApp.swift
//  Galop'Up
//
//  Created by Emma on 07/04/2026.
//

import SwiftUI

@main
struct Galop_UpApp: App {
    let authService: AuthService

    init() {
            let tokenStore = TokenStore()
            let apiClient = APIClient(tokenStore: tokenStore)
            authService = AuthService(apiClient: apiClient, tokenStore: tokenStore)
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authService)
        }
    }
}

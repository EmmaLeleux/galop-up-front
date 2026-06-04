//
//  GoogleFunctions.swift
//  Galop'Up
//
//  Created by Emma on 07/04/2026.
//

import SwiftUI
import GoogleSignIn

struct GoogleFunctions{
    func handleSignInButton(authService: AuthService) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            print("There is no active window scene")
            return
        }
        
        guard
            let rootViewController = windowScene.keyWindow?.rootViewController
        else {
            print("There is no key window or root view controller")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: rootViewController
        ) { signInResult, error in
            guard let result = signInResult else {
                print("Error signing in: \(error?.localizedDescription ?? "No error description")")
                return
            }
            authService.loginWithGoogle(googleToken: result.user.idToken?.tokenString ?? "")
        }
    }
}



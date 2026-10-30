//
//  ProfilView.swift
//  Galop'Up
//
//  Created by Emma on 01/10/2026.
//

import SwiftUI

struct ProfilView: View {
    @Environment(AuthViewModel.self) var authVM
    var body: some View {
        if let user = authVM.currentUser{
            VStack{
                HStack(spacing: 50){
                    ProfilPictureComponentView(pictureUser: user.picture, size: 200)
                    
                    Text(user.username ?? "")
                    

                }
                
                Button(action: {
                    Task{
                        try await authVM.logout()
                    }
                }, label: {
                    Text("Déconnexion")
                        .CustomButton(width: 200)
                })
            }
        }
        
    }
}


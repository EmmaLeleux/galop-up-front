//
//  AuthentificationView.swift
//  Galop'Up
//
//  Created by Emma on 22/05/2026.
//

import SwiftUI

struct authentificationView: View {
    @State var isConnexion: Bool = true
    var googleFunction = GoogleFunctions()
    @Environment(AuthService.self) var authService
    @FocusState var isFocused: Bool
    var body: some View {
        
        ZStack{
            Color.orangeBackground.ignoresSafeArea()
                .onTapGesture{
                    isFocused = false
                }
            
            VStack {
                
                Image(.galopUpTitle)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 74)
                
                Image(.galopinHeureux)
                    .resizable()
                    .mascotteSize()
                    .padding(.bottom, -85)
                    .padding(.top, -10)
                    .zIndex(1)
                
                VStack(spacing: 20){
                    
                    
                    Text(isConnexion ? "SE CONNECTER" : "S'INSCRIRE")
                        .font(.custom("Nunito", size: 20))
                        .foregroundStyle(.customBrown)
                        .fontWeight(.medium)
                    
                    if isConnexion{
                        ConnexionView(isFocused: $isFocused)
                    }
                    
                    else {
                        InscriptionView(isFocused: $isFocused)
                    }
                    
                    if let error = authService.errorMessage{
                        Text(error)
                            .font(.custom("Lato-Bold", size: 14))
                            .foregroundStyle(.customRed)
                    }
                    
                    Text("Ou \(isConnexion ? "se connecter" : "s'inscrire") avec :")
                        .font(.custom("Lato-Bold", size: 16))
                        .foregroundStyle(.customBrown)
                    
                    Button(action:{
                        googleFunction.handleSignInButton(authService: authService)
                    }, label: {
                        ConnectionLogoButtonView(logo: .google)
                    })
                    
                    HStack{
                        Text(isConnexion ? "Pas encore inscrit ?" : "Déjà un compte ?")
                        
                        Button(action:{
                            authService.errorMessage = nil
                            isConnexion.toggle()
                        }, label: {
                            Text(isConnexion ? "Créer un compte" : "Se connecter")
                                .foregroundStyle(.orangeButton)
                        })
                        .id(isConnexion)
                    }
                    .font(.custom("Lato-Bold", size: 12))
                }
                .padding()
                .padding(.top, 75)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(.customBrown), lineWidth: 3)
                )
                
                Spacer()
            }
            .padding()
            
            
        }
        
        
    }
}

#Preview {
    let tokenStore = TokenStore()
    authentificationView().environment(AuthService(apiClient: APIClient(tokenStore: tokenStore), tokenStore: tokenStore))
}

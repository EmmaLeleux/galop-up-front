//
//  OnBoardingProfilPicture.swift
//  Galop'Up
//
//  Created by Emma on 08/06/2026.
//

import SwiftUI
import PhotosUI

struct OnBoardingProfilPicture: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @Environment(AuthService.self) var authService
    var onComplete: () -> Void
    
    var body: some View {
        VStack{
            ConversationComponentView(text: "Enchanté \(authService.currentUser?.username ?? "") ! Et si tu choisissais une photo de profil pour commencer ?")
            Image(.galopinHeureux)
                .resizable()
                .mascotteSize()
                .padding(.bottom, 15)
            
            
            Group{
                
                if let avatarImage {
                    avatarImage
                        .resizable()
                    
                }
                else{
                    Image(.profilPictureAnonyme)
                    
                        .resizable()
                    
                    
                }
            }
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(.circle)
            
            
            
            HStack{
                Image(.profilPictureAnonyme)
                    .resizable()
                    .scaledToFit()
                
                Image(.profilPictureAnonyme)
                    .resizable()
                    .scaledToFit()
                
                Image(.profilPictureAnonyme)
                    .resizable()
                    .scaledToFit()
                
                PhotosPicker(selection: $avatarItem, matching: .images){
                    
                    ZStack{
                        
                        if let avatarImage{
                            avatarImage
                                .resizable()
                                .scaledToFit()
                                .clipShape(.circle)
                        }
                        else{
                            
                        
                        if let photo =  authService.currentUser?.picture{
                            AsyncImage(url: URL(string: photo)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.circle)
                                
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                        Image(.iconAppareilPhoto)
                            .resizable()
                            .padding(20)
                            .scaledToFit()
                            
                            .overlay(
                                
                                Circle()
                                    .stroke(lineWidth: 1).foregroundStyle(.darkBrown)
                            )
                        

                        
                    }
                }

                
            }
            .padding()
            
            Button("Suivant") {
                onComplete()
            }
            .CustomButton()
            
            Button("Passer") {
                onComplete()
            }
            .foregroundStyle(.customBrown)
        }
        .onChange(of: avatarItem) {
            Task {
                if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                    avatarImage = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
}



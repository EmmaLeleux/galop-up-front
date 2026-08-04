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
            .frame(width: 170, height: 170)
            .clipShape(.circle)
            
            
            
            HStack{
                //TODO: faire une route assignPicture qui assigne une image à un user sans uploadé de nouvelle image pour les photos proposée nativement.
                
                Image(.profilPictureAnonyme)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                
                Spacer()
                
                Image(.profilPictureAnonyme)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                
                Spacer()
                
                Button(action:{
                    avatarImage = Image(.galopinTriste)
                },
                       label:{
                    Image(.profilPictureAnonyme)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                })
                
                
                Spacer()
                
                PhotosPicker(selection: $avatarItem, matching: .images){
                    
                    ZStack{
                        
                        if let avatarImage{
                            avatarImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .overlay(.white.opacity(0.3))
                                .clipShape(.circle)
                        }
                        else{
                            
                            
                            if let photo =  authService.currentUser?.picture{
                                AsyncImage(url: URL(string: photo.url)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 70, height: 70)
                                        .overlay(.white.opacity(0.3))
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
                        
                        
                        
                        
                        
                    }
                    .frame(width: 70, height: 70)
                    .overlay(
                        
                        Circle()
                            .stroke(lineWidth: 1).foregroundStyle(.darkBrown)
                    )
                    
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



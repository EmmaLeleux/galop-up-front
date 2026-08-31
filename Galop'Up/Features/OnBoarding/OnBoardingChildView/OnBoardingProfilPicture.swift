//
//  OnBoardingProfilPicture.swift
//  Galop'Up
//
//  Created by Emma on 08/06/2026.
//

import SwiftUI
import PhotosUI

struct OnBoardingProfilPicture: View {
    @State private var onBoardingPictureVM: OnBoardingPictureViewModel = OnBoardingPictureViewModel()
    @Environment(AuthService.self) var authService
    @Environment(PictureService.self) var pictureService
    var onComplete: () -> Void
    
    var body: some View {
        VStack{
            ConversationComponentView(text: "Enchanté \(authService.currentUser?.username ?? "") ! Et si tu choisissais une photo de profil pour commencer ?")
            Image(.galopinHeureux)
                .resizable()
                .mascotteSize()
                .padding(.bottom, 15)
            
            
            Group{
                
                if let avatarImage =  onBoardingPictureVM.avatarImage{
                    avatarImage
                        .resizable()
                    
                }
                
                else if let avatarDefaultImage = onBoardingPictureVM.avatarDefaultImage{
                    AsyncImage(url: URL(string: avatarDefaultImage.url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(.circle)
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
                else if let avatarUser = authService.currentUser?.picture{
                    AsyncImage(url: URL(string: avatarUser.url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(.circle)
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                else{
                   
                    Image(.profilPictureAnonyme)
                    
                        .resizable()
                    
                    
                }
            }
            .scaledToFill()
            .frame(width: 170, height: 170)
            .clipShape(.circle)
            
            
            
            ScrollView(.horizontal){
                HStack{
                    
                    
                    
                    
                    
                    
                    
                    PhotosPicker(selection: $onBoardingPictureVM.avatarItem, matching: .images){
                        
                        ZStack{
                            
                            if let avatarImage = onBoardingPictureVM.avatarImage{
                                avatarImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .overlay(.white.opacity(0.3))
                                    .clipShape(.circle)
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
                    
                    Spacer()
                    
                    ForEach(pictureService.defaultPictures){ picture in
                        
                        ZStack{
                            
                            Button(action:{
                                if onBoardingPictureVM.avatarDefaultImage?.id == picture.id{
                                    onBoardingPictureVM.avatarDefaultImage = nil
                                }
                                else{
                                    onBoardingPictureVM.avatarDefaultImage = picture
                                    onBoardingPictureVM.avatarImage = nil
                                    onBoardingPictureVM.avatarItem = nil
                                    onBoardingPictureVM.avatarData = nil
                                }
                            },
                                   label:{
                                AsyncImage(url: URL(string: picture.url)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .overlay{
                                            if onBoardingPictureVM.avatarDefaultImage?.key == picture.key {
                                                Circle()
                                                    .fill(Color.white.opacity(0.3))
                                                    .stroke(.darkBrown, lineWidth: 2)
                                            }
                                            
                                            
                                        }
                                        .clipShape(.circle)
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                            })
                            
                            if onBoardingPictureVM.avatarDefaultImage?.id == picture.id{
                                VStack(alignment: .trailing){
                                    
                                    ZStack{
                                        
                                        Circle().fill(Color.darkBrown)
                                        
                                        Image(.check)
                                            .resizable()
                                            .padding(3)
                                            .scaledToFit()
                                    }
                                    .frame(width: 17, height: 17)
                                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 0))
                                    
                                    Spacer()
                                }
                                .frame(width: 70, height: 70)
                                
                            }
                            
                            
                        }
                        .frame(width: 70, height: 70)
                        
                        
                        
                    }
                    
                }
                .padding()
            }
            
            Button("Suivant") {
                Task{
                    do{
                        
                        try await authService.updateUser(userInfos: UserInfoToUpdate( picture: onBoardingPictureVM.avatarData, pictureInBase: onBoardingPictureVM.avatarDefaultImage?.id))
                        onComplete()
                    }
                    catch{
                        print(error)
                    }
                }
            }
            .CustomButton()
            
            Button("Passer") {
                onComplete()
            }
            .foregroundStyle(.customBrown)
        }
        .onAppear(){
            Task{
                try await pictureService.fetchPictureDefault()
            }
        }
        .onChange(of: onBoardingPictureVM.avatarItem) {
            Task {
                if let loaded = try? await onBoardingPictureVM.avatarItem?.loadTransferable(type: Data.self) {
                    onBoardingPictureVM.avatarData = loaded
                    
                    if let uiImage = UIImage(data: loaded) {
                        onBoardingPictureVM.avatarImage = Image(uiImage: uiImage)
                    }
                    onBoardingPictureVM.avatarDefaultImage = nil
                } else {
                    print("Failed")
                }
            }
        }
    }
}



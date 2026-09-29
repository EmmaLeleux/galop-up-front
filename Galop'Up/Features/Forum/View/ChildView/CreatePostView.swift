//
//  CreatePostView.swift
//  Galop'Up
//
//  Created by Emma on 19/09/2026.
//

import SwiftUI
import PhotosUI

struct CreatePostView: View {
    @Environment(AuthService.self) var authService
    @Environment(PostService.self) var postService
    @Binding var isShowingSheet: Bool
    @State var createPostVM: CreatePostViewModel = CreatePostViewModel()
    var body: some View {
        ZStack{
            Color.orangeBackground
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        isShowingSheet.toggle()
                    }, label: {
                        Image(.plus)
                            .foregroundStyle(.darkBrown)
                            .rotationEffect(Angle(degrees: 45))
                            .padding(10)
                        
                        
                    })
                    
                    Spacer()
                    Button(action: {
                        Task{
                            try await postService.createPost(postInfo: CreatePostRequest(title: createPostVM.title, content: createPostVM.content, pictures: createPostVM.postPictureData))
                            
                            isShowingSheet = false
                        }
                        
                    }, label: {
                        Text("Poster")
                    })
                    .CustomButton(width: 100)
                }
                .padding(.bottom)
                
                
                HStack(alignment: .top){
                    ProfilPictureComponentView(pictureUser: authService.currentUser?.picture, size: 45)
                    
                    VStack{
                        ZStack(alignment: .leading) {
                            if createPostVM.title.isEmpty {
                                Text("Titre")
                                    .foregroundColor(.customGrey.opacity(0.6))
                                    .padding()
                            }
                            
                            TextField("", text: $createPostVM.title, axis: .vertical)
                                .lineLimit(1...3)
                                .foregroundColor(.darkBrown)
                                .padding()
                                .onChange(of: createPostVM.title) { _, newValue in
                                    if newValue.count > 60 {
                                        createPostVM.title = String(newValue.prefix(60))
                                    }
                                }
                        }
                        .font(.custom("Nunito", size: 20))
                        
                        ZStack(alignment: .topLeading) {
                            if createPostVM.content.isEmpty {
                                Text("Ecrire un post...")
                                    .foregroundColor(.customGrey.opacity(0.6))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                            }
                            
                            TextEditor(text: $createPostVM.content)
                                .foregroundColor(.customBrown)
                                .scrollContentBackground(.hidden)
                                .frame(minHeight: 100, maxHeight: 250)
                                .padding(.horizontal, 12)
                        }
                        .font(.custom("Lato-Regular", size: 14))
                        
                        
                    }
                }
                
                PhotoPostView(localPictures: createPostVM.listImage)
                Spacer()
                
                VStack{
                    Text("Ajouter une photo \(createPostVM.postPictureData.count)/4")
                    
                    HStack{
                        ForEach(createPostVM.listImage, id: \.self){image in
                            
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        if createPostVM.postPictureData.count < 4 {
                            PhotosPicker(selection: $createPostVM.postPictureItem, maxSelectionCount: 4 - createPostVM.postPictureData.count, matching: .images){
                                
                                
                                Image(.plus)
                                    .resizable()
                                    .foregroundStyle(.darkBrown)
                                    .padding(20)
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 1).foregroundStyle(.darkBrown)
                                    )
                                
                            }
                        }
                    }
                    .onChange(of: createPostVM.postPictureItem) {
                        Task {
                            for item in createPostVM.postPictureItem{
                                if let loaded = try? await item.loadTransferable(type: Data.self) {
                                    createPostVM.postPictureData.append(loaded)
                                    
                                    if let uiImage = UIImage(data: loaded) {
                                        createPostVM.listImage.append(uiImage)
                                    }
                                } else {
                                    print("Failed")
                                }
                            }
                            
                        }
                    }
                }
            }.padding()
        }
    }
}


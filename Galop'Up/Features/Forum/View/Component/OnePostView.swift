//
//  OnePostView.swift
//  Galop'Up
//
//  Created by Emma on 31/08/2026.
//

import SwiftUI

struct OnePostView: View {
    var postVM: PostViewModel
    @Environment(PostService.self) var postService
    @Environment(AuthService.self) var authService

    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack(spacing: 21){
                HStack{
                    HStack{
                        ProfilPictureComponentView(pictureUser: postVM.post.author.picture)
                        
                        Text(postVM.post.author.username ?? "")
                            .font(.custom("Nunito", size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.customBrown)
                    }
                    
                    Spacer()
                    
                    HStack{
                        
                        Text(postVM.post.createdAt.relativeDisplayString)
                            .font(.custom("Nunito", size: 14))
                        
                        
                        Button(action:{
                            postVM.isMenuOpen.toggle()
                        }, label: {
                            Image(.menuPost)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 11)
                        })
                        
                        
                        
                    }
                    .foregroundStyle(.customGrey)
                    
                }
                
                HStack{
                    VStack(alignment: .leading, spacing: 12){
                        Text(postVM.post.title)
                            .font(.custom("Nunito", size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.darkBrown)
                            .lineLimit(2)
                        
                        Text(postVM.post.content)
                            .font(.custom("Lato-Regular", size: 14))
                            .foregroundStyle(.customGrey)
                            .lineLimit(postVM.contentLineLimit)
                        
                        if postVM.isTruncated{
                            
                            
                            Button(action: {
                                postVM.isExpanded.toggle()
                            }, label: {
                                Text(postVM.isExpanded ? "Voir moins" : "Voir plus")
                                    .font(.custom("Nunito", size: 12))
                                    .foregroundStyle(.darkBrown)
                            })
                        }
                        
                    }
                    Spacer()
                }
                
                if postVM.post.pictures.count > 0{
                    PhotoPostView(pictures: postVM.post.pictures)
                    
                }
                
                HStack{
                    Button(action:{
                        Task{
                            if let user = authService.currentUser{
                                try await postService.likeOrDislike(post: postVM.post, user: user)

                            }

                        }
                    }, label: {
                        Text("\(postVM.post.likes.count)")
                        Image(postVM.post.isLikeByMe ? .heartFill : .heart)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    })
                    
                    
                    Spacer()
                }
                .foregroundStyle(.customBrown)
            }
            if postVM.isMenuOpen{
                Button(action:{
                    
                }, label: {
                    Text("Signaler")
                        .font(.custom("Nunito", size: 12))
                        .foregroundStyle(Color.customBrown)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(
                            Color.customWhite
                                .clipShape(
                                    UnevenRoundedRectangle(
                                        topLeadingRadius: 20,
                                        bottomLeadingRadius: 20,
                                        bottomTrailingRadius: 20,
                                        topTrailingRadius: 0
                                    )
                                ).shadow(
                                    color: .darkBrown.opacity(0.1),
                                    radius: 12,
                                    y: 4
                                )
                        )
                    
                }
                ).offset(y: 30)
                
            }
        }
        
        
        .padding()
    }
}


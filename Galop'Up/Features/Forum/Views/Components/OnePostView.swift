//
//  OnePostView.swift
//  Galop'Up
//
//  Created by Emma on 31/08/2026.
//

import SwiftUI

struct OnePostView: View {
    var post: Post
    @State var onePostVM: OnePostViewModel
    @Environment(PostViewModel.self) var postVM
    @Environment(AuthViewModel.self) var authVM

    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack(spacing: 21){
                HStack{
                    HStack{
                        ProfilPictureComponentView(pictureUser: post.author.picture)
                        
                        Text(post.author.username ?? "")
                            .font(.custom("Nunito", size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.customBrown)
                    }
                    
                    Spacer()
                    
                    HStack{
                        
                        Text(post.createdAt.relativeDisplayString)
                            .font(.custom("Nunito", size: 14))
                        
                        
                        Button(action:{
                            onePostVM.isMenuOpen.toggle()
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
                        Text(post.title)
                            .font(.custom("Nunito", size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.darkBrown)
                            .lineLimit(2)
                        
                        Text((try? AttributedString(
                            markdown: post.content,
                            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
                        )) ?? AttributedString(post.content))
                            .font(.custom("Lato-Regular", size: 14))
                            .foregroundStyle(.customGrey)
                            .lineLimit(onePostVM.contentLineLimit(post: post))
                        
                        if onePostVM.isTruncated(post: post){
                            
                            
                            Button(action: {
                                onePostVM.isExpanded.toggle()
                            }, label: {
                                Text(onePostVM.isExpanded ? "Voir moins" : "Voir plus")
                                    .font(.custom("Nunito", size: 12))
                                    .foregroundStyle(.darkBrown)
                            })
                        }
                        
                    }
                    Spacer()
                }
                
                if post.pictures.count > 0{
                    PhotoPostView(pictures: post.pictures)
                    
                }
                
                HStack{
                    Button(action:{
                        Task{
                            if let user = authVM.currentUser{
                                try await postVM.likeOrDislike(post: post, user: UserPublic(id: user.id, username: user.username, picture: user.picture))

                            }

                        }
                    }, label: {
                        Text("\(post.nbLikes)")
                        Image(post.isLikeByMe ? .heartFill : .heart)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    })
                    
                    
                    Spacer()
                }
                .foregroundStyle(.customBrown)
            }
            if onePostVM.isMenuOpen{
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


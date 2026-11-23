//
//  EventCardView.swift
//  Galop'Up
//
//  Created by Emma on 07/11/2026.
//

import SwiftUI

struct EventCardView: View {
    let event: EventCustom
    @Environment(EventViewModel.self) var eventVM
    @Environment(AuthViewModel.self) var authVM
    @Binding var allSelected: Bool
    var body: some View {
        VStack{
            
            ZStack{
                AsyncImage(url: URL(string: event.picture.url)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .clipped()
                
                
                VStack{
                    
                    HStack{
                        Spacer()
                        
                        Button(action:{
                            Task{
                                if let user = authVM.currentUser{
                                    try await eventVM.likeOrDislike(event: event, user: UserPublic(id: user.id, username: user.username, picture: user.picture))
                                    
                                    if !allSelected{
                                        if let index = eventVM.events.firstIndex(where: { $0.self.id == event.id }){
                                            eventVM.events.remove(at: index)

                                        }
                                    }
                                    
                                }
                                
                            }
                        },
                               label: {
                                Image(event.isLikeByMe ? .heartFill : .heart)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .padding()
                            })
                        
                    }
                    Spacer()
                }
            }
            
            
            
            HStack{
                VStack(alignment: .leading){
                    Text(event.name)
                        .foregroundStyle(.darkBrown)
                        .font(.custom("Nunito", size: 24))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    Text(event.startDate.formatted(date: .long, time: .omitted))
                        .font(.custom("Lato-Regular", size: 14))
                        .foregroundStyle(.customGrey)
                }
                Spacer()
                if let levelMax = event.levelMax, let levelMin = event.levelMin{
                    Text("Galop \(levelMin.numberGalop) à \(levelMax.numberGalop)")
                        .foregroundStyle(.darkBrown)
                        .font(.custom("Lato-Bold", size: 12))
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.customGreen))
                }
                
            }
            .padding()
            
        }
        
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal)
    }
}



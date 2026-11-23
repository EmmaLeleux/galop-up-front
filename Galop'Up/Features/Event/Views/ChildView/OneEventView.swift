//
//  OneEventView.swift
//  Galop'Up
//
//  Created by Emma on 09/11/2026.
//

import SwiftUI
import MapKit

struct OneEventView: View {
    let event: EventCustom
    @Environment(EventViewModel.self) var eventVM
    @Environment(AuthViewModel.self) var authVM

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack{
            
            Color.orangeBackground.ignoresSafeArea()
            
            ScrollView{
                ZStack{
                    AsyncImage(url: URL(string: event.picture.url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .clipped()
                    
                    
                    VStack{
                        
                        HStack{
                            
                            
                            Spacer()
                            
                            Button(action:{
                                Task{
                                    if let user = authVM.currentUser{
                                        try await eventVM.likeOrDislike(event: event, user: UserPublic(id: user.id, username: user.username, picture: user.picture))
                                        
                                    }
                                    
                                }
                            }, label: {
                                Image(event.isLikeByMe ? .heartFill : .heart)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .padding()
                            })
                            
                        }
                        .padding(.top, 50)
                        Spacer()
                    }
                }
                
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(event.name)
                                .foregroundStyle(.darkBrown)
                                .font(.custom("Nunito", size: 24))
                                .fontWeight(.bold)
                            
                            Text("\(event.startDate.formatted(.dateTime.day().month(.wide).year().locale(Locale(identifier: "fr_FR")))) . \(event.startDate.formatted(date: .omitted, time: .shortened)) - \(event.endDate.formatted(date: .omitted, time: .shortened))")
                            .font(.custom("Lato-Bold", size: 14))
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
                    .padding(.vertical)
                    
                    HStack{
                        Image(.mark)
                        
                        VStack(alignment: .leading){
                            Text("\(event.placeName)")
                                .font(.custom("Lato-Bold", size: 14))
                                .foregroundStyle(.customBrown)
                            Text("\(event.address)")
                                .font(.custom("Lato-Bold", size: 12))
                                .foregroundStyle(.customGrey)
                        }
                        
                        Spacer()
                        
                        Button(action:{
                            eventVM.openDirections(to: event)
                        },label:{
                            Text("Itinéraire")
                                .font(.custom("Lato-Bold", size: 12))
                                .foregroundStyle(.customBrown)
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke(lineWidth: 2).foregroundStyle(.customBrown))
                        })
                    }
                    
                    Text(event.description.description)
                        .font(.custom("Lato-Regular", size: 15))
                        .foregroundStyle(.customBrown)
                        .padding(.vertical)
                    
                    HStack{
                        Spacer()
                        
                        VStack{
                            Image(.horseIcon)
                            
                            Text(event.typeEvent.name)
                                .foregroundStyle(.customBrown)
                                .font(.custom("Lato-Regular", size: 12))
                        }
                        
                        Spacer()
                        
                        VStack{
                            Image(.horlogeIcon)
                            
                            Text("\(event.startDate.formatted(date: .omitted, time: .shortened)) - \(event.endDate.formatted(date: .omitted, time: .shortened))")
                                .foregroundStyle(.customBrown)
                                .font(.custom("Lato-Regular", size: 12))
                        }
                        
                        Spacer()
                        
                        VStack{
                            Image(.capacityIcon)
                            
                            if let capacity = event.capacity {
                                Text("\(capacity) places")
                                    .foregroundStyle(.customBrown)
                                    .font(.custom("Lato-Regular", size: 12))
                            } else {
                                Text("Pas de limite")
                                    .foregroundStyle(.customBrown)
                                    .font(.custom("Lato-Regular", size: 12))
                            }
                            
                        }
                        Spacer()
                    }
                    .padding(.vertical ,10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.customWhite).stroke(.customBrown))
                    .padding()
                    
                    
                    HStack{
                        Text("Informations pratiques :")
                            .font(.custom("Lato-Bold", size: 16))
                            .foregroundStyle(.customBrown)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                    }
                    
                    HStack{
                        Text("Tarif")
                            .font(.custom("Lato-Bold", size: 14))
                            .foregroundStyle(.customBrown)
                        
                        Spacer()
                        
                        if let price = event.price {
                            Text(price.formatted(.currency(code: "EUR").locale(Locale(identifier: "fr_FR"))))                                .font(.custom("Lato-Regular", size: 14))
                                .foregroundStyle(.customBrown)
                        } else {
                            Text("Gratuit")
                                .font(.custom("Lato-Regular", size: 14))
                                .foregroundStyle(.customBrown)
                        }
                    }
                    .padding(5)
                    Divider()
                        .foregroundStyle(.customBrown)
                    
                    HStack{
                        Text("Niveau recommandé")
                            .font(.custom("Lato-Bold", size: 14))
                            .foregroundStyle(.customBrown)
                        
                        Spacer()
                        
                        if let levelMax = event.levelMax, let levelMin = event.levelMin{
                            Text("Galop \(levelMin.numberGalop) à \(levelMax.numberGalop)")
                                .font(.custom("Lato-Regular", size: 14))
                                .foregroundStyle(.customBrown)
                        } else {
                            Text("Tout niveau")
                                .font(.custom("Lato-Regular", size: 14))
                                .foregroundStyle(.customBrown)
                        }
                    }
                    .padding(5)
                    Divider()
                        .foregroundStyle(.customBrown)
                    
                    HStack{
                        Text("Equipement")
                            .font(.custom("Lato-Bold", size: 14))
                            .foregroundStyle(.customBrown)
                        
                        Spacer()
                        
                        if let equipement = event.equipment {
                            Text("\(equipement)")
                                .font(.custom("Lato-Regular", size: 14))
                                .foregroundStyle(.customBrown)
                        } else {
                            Text("Pas d'équipement requis")
                                .font(.custom("Lato-Regular", size: 14))
                                .foregroundStyle(.customBrown)
                        }
                    }
                    .padding(5)
                    Divider()
                        .foregroundStyle(.customBrown)
                    
                    HStack{
                        Text("Inscription jusqu'au")
                            .font(.custom("Lato-Bold", size: 14))
                            .foregroundStyle(.customBrown)
                        
                        Spacer()
                        
                        if let deadline = event.deadline {
                            Text(deadline.formatted(.dateTime.day().month(.wide).year().locale(Locale(identifier: "fr_FR"))))                .font(.custom("Lato-Regular", size: 14))
                                .foregroundStyle(.customBrown)
                        } else {
                            Text("Sans inscription")
                                .font(.custom("Lato-Regular", size: 14))
                                .foregroundStyle(.customBrown)
                        }
                    }
                    .padding(5)
                    Divider()
                        .foregroundStyle(.customBrown)
                        .padding(.bottom, 30)
                    
                    let coordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)

                            Map(initialPosition: .region(MKCoordinateRegion(
                                center: coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                            ))) {
                                Marker(event.placeName, coordinate: coordinate)
                            }
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
                
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

//
//  EventView.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import SwiftUI

struct EventView: View {
    @Environment(EventViewModel.self) var eventVM
    @State var allSelected: Bool = true
    @Namespace private var pill
    
    var body: some View {
        ZStack{
            Color.orangeBackground.ignoresSafeArea()
            
            VStack{
                HeaderView(title: "Événements", description: "Stages, concours, conférences : retrouve tous les rendez-vous équestres à venir.")
                    
                
                ScrollView{
                    
                    
                    
                    HStack(spacing: 0){
                        Button(action: {
                            guard !allSelected else { return }
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) { allSelected = true }
                            Task {
                                do { try await eventVM.fetchEvents() }
                                catch { withAnimation { allSelected = false } }
                            }
                        }, label: {
                            Text("Tous")
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .font(.custom("Lato-Bold", size: 14))
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(allSelected ? .customWhite : .customBrown)
                                .background {
                                    if allSelected {
                                        Capsule().fill(.orangeButton)
                                            .matchedGeometryEffect(id: "pill", in: pill)
                                    }
                                }
                        })
                        
                        Button(action: {
                            guard allSelected else { return }
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) { allSelected = false }
                            Task {
                                do { try await eventVM.fetchLikesEvents() }
                                catch { withAnimation { allSelected = true } }
                            }
                        }, label: {
                            Text("Mes favoris")
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .font(.custom("Lato-Bold", size: 14))
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(allSelected ? .customBrown : .customWhite)
                                .background {
                                    if !allSelected {
                                        Capsule().fill(.orangeButton)
                                            .matchedGeometryEffect(id: "pill", in: pill)
                                    }
                                }
                        })
                    }
                    .padding()
                    LazyVStack(spacing: 15){
                        ForEach(eventVM.events) { event in
                            NavigationLink(destination: {
                                OneEventView(event: event)
                            }, label: {
                                EventCardView(event: event, allSelected: $allSelected)
                            })
                        }
                        
                    }
                }
            }
            .onAppear{
                Task{
                    try await eventVM.fetchEvents()
                }
            }
                
        }
    }
}

#Preview {
    EventView()
}

//
//  headerView.swift
//  Galop'Up
//
//  Created by Emma on 17/11/2026.
//

import SwiftUI

struct HeaderView: View {
    @Environment(AuthViewModel.self) var authVM
    var title: String
    var description: String
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(title)
                    .font(.custom("Nunito", size: 30))
                    .foregroundStyle(.customBrown)
                    .fontWeight(.bold)
                
                Text(description)
                    .font(.custom("Lato-Regular", size: 14))
                    .foregroundStyle(.darkBrown)
                    
                
            }
            Spacer(minLength: 50)
            
            NavigationLink(destination: ProfilView(), label: {
                ProfilPictureComponentView(pictureUser: authVM.currentUser?.picture, size: 50)
            })
        }
        .padding(.horizontal)
    }
}


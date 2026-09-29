//
//  ProfilPictureComponentView.swift
//  Galop'Up
//
//  Created by Emma on 20/09/2026.
//

import SwiftUI

struct ProfilPictureComponentView: View {
    let pictureUser: Picture?
    var size: CGFloat = 35
    var body: some View {
        Group{
            if let picture = pictureUser{
                AsyncImage(url: URL(string: picture.url)) { image in
                    image
                        .resizable()
                    
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
        .frame(width: size, height: size)
        .clipShape(.circle)
    }
}


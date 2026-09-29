//
//  OnePictureView.swift
//  Galop'Up
//
//  Created by Emma on 23/09/2026.
//

import SwiftUI

struct OnePictureView: View {
    var picture: Picture? = nil
    var localPicture: UIImage? = nil
    
    var body: some View {
        if let picture {
            AsyncImage(url: URL(string: picture.url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
        } else if let uiImage = localPicture {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            Color.gray
        }
    }
}


#Preview {
    OnePictureView()
}

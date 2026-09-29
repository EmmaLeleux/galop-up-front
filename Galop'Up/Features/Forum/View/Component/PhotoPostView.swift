//
//  photoPostView.swift
//  Galop'Up
//
//  Created by Emma on 01/09/2026.
//

import SwiftUI

struct PhotoPostView: View {
    var pictures: [Picture]? = nil
    var localPictures: [UIImage]? = nil
    
    private var count: Int {
        pictures?.count ?? localPictures?.count ?? 0
    }
    private var ratio: CGFloat {
        switch count {
        case 1: return 16/9
        case 2: return 20/9
        case 3: return 11/9
        case 4: return 1.5
        default: return 1
        }
    }
    
    var body: some View {
        GeometryReader{ geo in
            HStack{
                switch count {
                case 1:
                    OnePictureView(picture: pictures?[0], localPicture: localPictures?[0])
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                    
                    
                case 2:
                    ForEach(0..<2, id: \.self) { index in
                        OnePictureView(picture: pictures?[index], localPicture: localPictures?[index])
                            .frame(width: geo.size.width / 2 - 5, height: geo.size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .clipped()
                        
                    }
                case 3:
                    VStack{
                        HStack(){
                            ForEach(0..<2, id: \.self) { index in
                                if index < 2 {
                                    OnePictureView(picture: pictures?[index], localPicture: localPictures?[index])
                                        .frame(width: geo.size.width / 2 - 5, height: geo.size.height / 2 - 15)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .clipped()
                                }
                                
                            }
                        }
                        OnePictureView(picture: pictures?[2], localPicture: localPictures?[2])
                            .frame(width: geo.size.width, height: geo.size.height / 2 + 5)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .clipped()
                        
                    }
                case 4:
                    VStack{
                        HStack{
                            ForEach(0..<2, id: \.self) { index in
                                OnePictureView(picture: pictures?[index], localPicture: localPictures?[index])
                                    .frame(width: geo.size.width / 2 - 5, height: geo.size.height / 2 - 5)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .clipped()
                                
                                
                            }
                        }
                        
                        HStack{
                            
                            ForEach(2..<4, id: \.self) { index in
                                OnePictureView(picture: pictures?[index], localPicture: localPictures?[index])
                                    .frame(width: geo.size.width / 2 - 5, height: geo.size.height / 2 - 5)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .clipped()
                                
                                
                            }
                        }
                    }
                default: EmptyView()
                }
            }
        }
        
        .aspectRatio(ratio, contentMode: .fit)
        
    }
}

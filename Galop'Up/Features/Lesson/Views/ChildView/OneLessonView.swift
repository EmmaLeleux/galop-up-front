//
//  OneLessonView.swift
//  Galop'Up
//
//  Created by Emma on 22/11/2026.
//

import SwiftUI

struct OneLessonView: View {
    var lesson: Lesson
    @State private var contentHeight: CGFloat = 0
    var body: some View {
        ZStack{
            Color.orangeBackground.ignoresSafeArea()
            
            ScrollView{
                
                Color.clear
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                    .overlay {
                        AsyncImage(url: URL(string: lesson.picture.url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .clipped()
                
                Text(lesson.name)
                    .font(.custom("Nunito", size: 30))
                    .fontWeight(.bold)
                    .foregroundStyle(.customBrown)
                
                HTMLView(html: lesson.content, height: $contentHeight)
                    .frame(height: contentHeight)
            }
            .ignoresSafeArea(edges: .top)
            
        }
    }
}

//
//  OneLessonCardView.swift
//  Galop'Up
//
//  Created by Emma on 22/11/2026.
//

import SwiftUI

struct OneLessonCardView: View {
    var lesson: Lesson
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: lesson.picture.url)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            
            
            VStack(alignment: .leading){
                Text(lesson.name)
                    .font(.custom("Lato-Bold", size: 16))
                    .foregroundStyle(.customBrown)
                    .multilineTextAlignment(.leading)
                
                Text(lesson.description)
                    .font(.custom("Lato-Regular", size: 13))
                    .foregroundStyle(.customGrey)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Text(lesson.level.rawValue)
                .font(.custom("Lato-Bold", size: 16))
                .foregroundStyle(.darkBrown)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(Capsule().fill( Color(.customGreen.opacity(0.5))))
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 15).stroke(.customBrown, lineWidth: 2).fill(.customWhite)
                .shadow(color: .shadow.opacity(0.2), radius: 5)
        }
    }
}

#Preview {
    LessonView()
}

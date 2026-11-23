//
//  LessonView.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import SwiftUI

struct LessonView: View {
    @Environment(LessonViewModel.self) var lessonVM

    var body: some View {
        ZStack{
            Color.orangeBackground.ignoresSafeArea()
            
            VStack{
                HeaderView(title: "Leçons", description: "Des fiches claires pour réviser chaque Galop à ton rythme.")

                
                ScrollView{
                    ForEach(lessonVM.lessons) { lesson in
                        
                        NavigationLink(destination: {
                            OneLessonView(lesson: lesson)
                        }, label: {
                            OneLessonCardView(lesson: lesson)
                                    
                        })
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    }
                }
            }
            .onAppear {
                Task{
                    try await lessonVM.fetchLessons()
                }
            }
        }
    }
}

#Preview {
    LessonView()
}

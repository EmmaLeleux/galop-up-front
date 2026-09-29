//
//  ForumView.swift
//  Galop'Up
//
//  Created by Emma on 31/08/2026.
//

import SwiftUI

struct ForumView: View {
    @Environment(PostService.self) var postService
    @State var isShowingSheet: Bool = false
    var body: some View {
        
        ZStack{
            Color.orangeBackground.ignoresSafeArea()
            PostListView()
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        isShowingSheet.toggle()
                    }, label: {
                        Image(.plus)
                            .foregroundStyle(.white)
                            .padding()
                            .background{
                                Circle().fill(.orangeButton)
                            }
                        
                    })
                    .padding()
                }}
        }
        .sheet(isPresented: $isShowingSheet) {
            
        } content: {
            CreatePostView(isShowingSheet: $isShowingSheet)
                .interactiveDismissDisabled(true)
        }
        
        
    }
}

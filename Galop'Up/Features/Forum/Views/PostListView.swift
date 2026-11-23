//
//  PostListView.swift
//  Galop'Up
//
//  Created by Emma on 13/09/2026.
//

import SwiftUI

struct PostListView: View {
    @Environment(PostViewModel.self) var postVM
    var body: some View {
        
        
        ScrollView{
            LazyVStack{
                ForEach(postVM.posts) { post in
                    OnePostView(post: post, onePostVM: OnePostViewModel())
                        .overlay(
                            Rectangle()
                                .fill(Color.customGrey.opacity(0.5))
                                .frame(height: 1),
                            alignment: .bottom
                        )
                        .onAppear {
                            if post.id == postVM.posts.last?.id {
                                Task {
                                    await postVM.fetchNextPage()
                                }
                            }
                        }
                }
                if postVM.isLoading {
                    ProgressView()
                        .padding()
                }
            }
        }
        
        .task {
            if postVM.posts.isEmpty {
                await   postVM.fetchNextPage()
            }
        }
        .refreshable {
            await postVM.refresh()
        }
        
        
    }
}

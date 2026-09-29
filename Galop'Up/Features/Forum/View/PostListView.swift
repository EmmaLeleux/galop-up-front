//
//  PostListView.swift
//  Galop'Up
//
//  Created by Emma on 13/09/2026.
//

import SwiftUI

struct PostListView: View {
    @Environment(PostService.self) var postService
    var body: some View {
        
            ScrollView{
                LazyVStack{
                    ForEach(postService.posts) { post in
                        OnePostView(postVM: PostViewModel(post: post))
                            .overlay(
                                Rectangle()
                                    .fill(Color.customGrey.opacity(0.5))
                                    .frame(height: 1),
                                alignment: .bottom
                            )
                            .onAppear {
                                if post.id == postService.posts.last?.id {
                                    Task {
                                        await postService.fetchNextPage()
                                    }
                                }
                            }
                    }
                    if postService.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                
            }
        
        .task {
            if postService.posts.isEmpty {
                await   postService.fetchNextPage()
            }
        }
        .refreshable {
            await postService.refresh()
        }
        
        
    }
}

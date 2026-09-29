//
//  PostService.swift
//  Galop'Up
//
//  Created by Emma on 31/08/2026.
//

import Foundation

@Observable
@MainActor
class PostService {
    private let apiClient: APIClient
    
    var posts: [Post] = []
    var isLoading = false
    var canLoadMore = true
    
    private var cursor: String?
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchNextPage() async {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let response = try await fetchPosts(cursor: cursor)
            posts.append(contentsOf: response.posts)
            cursor = response.nextCursor
            canLoadMore = response.nextCursor != nil
        } catch {
            print("Erreur fetchNextPage : \(error)")
        }
    }
    
    func createPost(postInfo: CreatePostRequest) async throws{
        guard let url = URL(string: "http://localhost:8080/post") else {
            print("Wrong URL")
            return
        }
        let boundary = UUID().uuidString

                let data = try await apiClient.send { token in
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                    request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                    request.httpBody = Self.buildCreatePostBody(
                        title: postInfo.title,
                        content: postInfo.content,
                        pictures: postInfo.pictures,
                        boundary: boundary
                    )
                    return request
                }

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                _ = try decoder.decode(Post.self, from: data)

                await refresh()
            
    }
    
    
    private static func buildCreatePostBody(
            title: String,
            content: String,
            pictures: [Data],
            boundary: String
        ) -> Data {
            var body = Data()

            func appendField(name: String, value: String) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }

            appendField(name: "title", value: title)
            appendField(name: "content", value: content)

            for (index, imageData) in pictures.enumerated() {
                let info = detectImageFileInfo(from: imageData)

                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"pictures[\(index)]\"; filename=\"picture\(index).\(info.fileExtension)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \(info.mimeType)\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }

            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            return body
        }
    
    func refresh() async {
        cursor = nil
        canLoadMore = true
        posts = []
        await fetchNextPage()
    }
        
        func fetchPosts(cursor: String?) async throws -> PaginatedPosts{
            var urlString = "http://localhost:8080/post"
            
            if let cursor,
                       let encodedCursor = cursor.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                        urlString += "?cursor=\(encodedCursor)"
                    }
            
            guard let url = URL(string: urlString) else {
                print("Wrong URL")
                return PaginatedPosts(posts: [], nextCursor: nil)
                
            }
            
            let data = try await apiClient.send { token in
                var request = URLRequest(url: url)
                request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                return request
            }
            
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return try decoder.decode(PaginatedPosts.self, from: data)
           
        }
    
    func likeOrDislike(post: Post, user: User) async throws {
        let isLiking = post.isLikeByMe

        guard let url = URL(string: "http://localhost:8080/post/\(post.id)/like") else { return }

        let data = try await apiClient.send { token in
            var request = URLRequest(url: url)
            request.httpMethod = isLiking ? "DELETE" : "POST"
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            return request
        }

        //TODO: gérer la récupération d'erreur
        
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }

        if !isLiking {
            posts[index].likes.append(user)
        } else {
            posts[index].likes.removeAll { $0.id == user.id }
        }
        posts[index].isLikeByMe.toggle()
    }
        
    }

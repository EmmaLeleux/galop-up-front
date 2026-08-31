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
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    
    func fetchPosts() async throws -> [Post]{
        guard let url = URL(string: "http://localhost:8080/post") else {
            print("Wrong URL")
            return []
            
        }
       
        let data = try await apiClient.send { token in
                    var request = URLRequest(url: url)
                    request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                    return request
                }
                return try JSONDecoder().decode([Post].self, from: data)
    }
    
}

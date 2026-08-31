//
//  PictureService.swift
//  Galop'Up
//
//  Created by Emma on 12/08/2026.
//

import Foundation

@Observable
@MainActor
class PictureService {
    private let apiClient: APIClient
    
    var defaultPictures: [Picture] = []
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    
    func fetchPictureDefault() async throws {
        guard let url = URL(string: "http://localhost:8080/picture") else {
            print("Wrong URL")
            return
        }
       
        let data = try await apiClient.send { token in
                    var request = URLRequest(url: url)
                    request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                    return request
                }
                defaultPictures = try JSONDecoder().decode([Picture].self, from: data)
    }
    
}

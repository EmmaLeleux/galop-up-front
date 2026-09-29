//
//  QuizService.swift
//  Galop'Up
//
//  Created by Emma on 29/09/2026.
//

import Foundation

@Observable
@MainActor
class QuizService {
    private let apiClient: APIClient
    
    var quizzes: [Quiz] = []
    var isLoading = false
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    
    func fetchQuizzes() async throws -> [Quiz]{
        
        guard let url = URL(string: "http://localhost:8080/quiz") else {
            print("Wrong URL")
            return []
        }
        
        let data = try await apiClient.send { token in
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            return request
        }
        
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try decoder.decode([Quiz].self, from: data)
        
    }
    
}

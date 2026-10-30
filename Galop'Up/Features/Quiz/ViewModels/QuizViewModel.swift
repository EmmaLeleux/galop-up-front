//
//  QuizViewModel.swift
//  Galop'Up
//
//  Created by Emma on 29/09/2026.
//

import Foundation

@Observable
@MainActor
class QuizSessionViewModel {
    private let apiClient: APIClient
    
    var activeSession: QuizSession?
        var currentQuestion: Question?
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    
    func createQuizSession(quizSession: CreateQuizSession) async throws {
        guard let url = URL(string: "http://localhost:8080/quiz-session") else {
            print("Wrong URL")
            return
        }
        let body = try JSONEncoder().encode(quizSession)
        
        let data = try await apiClient.send { token in
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            request.httpBody = body
            return request
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(QuizSessionStart.self, from: data)
        
        activeSession = response.session
        currentQuestion = response.question

    }
    
    func updateQuizSession(answer: Answer) async throws {
        guard let url = URL(string: "http://localhost:8080/quiz-session") else {
            print("Wrong URL")
            return
        }
        let body = try JSONEncoder().encode(answer)
        
        let data = try await apiClient.send { token in
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            request.httpBody = body
            return request
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(QuizSessionStart.self, from: data)
        
        activeSession = response.session
        currentQuestion = response.question

    }
    
}

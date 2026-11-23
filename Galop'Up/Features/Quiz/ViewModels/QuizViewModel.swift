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
    var deadline: Date?
    private var finishRequested = false
    var isCorrect:Bool?
    
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    
    func updateDeadline(session: QuizSession) {
        if let remaining = session.remainingSeconds {
            deadline = Date().addingTimeInterval(remaining)
        }
    }
    
    
    func createQuizSession(quizSession: CreateQuizSession) async throws {
        finishRequested = false

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
        updateDeadline(session: response.session)
        
    }
    
    func getHistoryQuizSession() async throws -> [QuizSessionHistory] {
        guard let url = URL(string: "http://localhost:8080/quiz-session") else {
            print("Wrong URL")
            return []
        }
        
        let data = try await apiClient.send { token in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            return request
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode([QuizSessionHistory].self, from: data)
        
        return response
    }
    
    func updateQuizSession(answer: Answer) async throws -> QuizSessionStart{
        guard let url = URL(string: "http://localhost:8080/quiz-session") else {
            throw URLError(.badServerResponse)
        }
        
        let nbGoodAnswer = activeSession?.nbGoodAnswer ?? 0
        
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
        
        updateDeadline(session: response.session)
        isCorrect = response.session.nbGoodAnswer == nbGoodAnswer + 1
        
        return response
    }
    
    func changeQuestion(quizSession: QuizSessionStart) {
        activeSession = quizSession.session
        currentQuestion = quizSession.question
    }
    
    func sendStopRequest() async throws {
        guard let url = URL(string: "http://localhost:8080/quiz-session/stop") else {
            print("Wrong URL")
            return
        }
        
        let _ = try await apiClient.send { token in
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            return request
        }
        
    }
    
    func stopQuizSession() async {
        try? await sendStopRequest()
        
        activeSession = nil
        currentQuestion = nil
        deadline = nil
    }
    
    func sendFinishRequest() async throws -> QuizSessionStart?{
        guard let url = URL(string: "http://localhost:8080/quiz-session/finish") else {
            print("Wrong URL")
            return nil
        }
        
        let data = try await apiClient.send ({ token in
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            return request
        }, showGlobalError: false)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(QuizSessionStart.self, from: data)
        
        return response
        
    }
    
    func finishQuizSession() async {
        guard !finishRequested else { return }
        finishRequested = true
        
        for _ in 1...3 {
            if let quiz = try? await sendFinishRequest() {
                activeSession = quiz.session
                currentQuestion = nil
                deadline = nil
                return
            }
            try? await Task.sleep(for: .seconds(1))
        }
        
        
    }
}

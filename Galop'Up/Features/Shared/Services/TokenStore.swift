//
//  TokenStorage.swift
//  Galop'Up
//
//  Created by Emma on 22/07/2026.
//

import KeychainAccess
import Foundation



actor TokenStore {
    private let keychain = Keychain(service: "emma.Galop-Up")
    private(set) var accessToken: String?
    private(set) var refreshToken: String?
    
    init() {
        accessToken = try? keychain.get("authToken")
        refreshToken = try? keychain.get("refreshToken")
    }
    
    func setTokens(access: String, refresh: String) {
        accessToken = access
        refreshToken = refresh
        try? keychain.set(access, key: "authToken")
        try? keychain.set(refresh, key: "refreshToken")
    }
    
    func clear() {
        accessToken = nil
                refreshToken = nil
                try? keychain.remove("authToken")
                try? keychain.remove("refreshToken")
    }
    
    private var refreshTask: Task<String, Error>?
    
    func refreshAccessToken() async throws -> String {
        if let existing = refreshTask {
                   return try await existing.value
               }
        
               let task = Task<String, Error> {
                   guard let refreshToken else {
                       throw AuthError.noRefreshToken
                   }
        
                   guard let url = URL(string: "http://localhost:8080/auth/refresh-token") else {
                       throw URLError(.badURL)
                   }
        
                   var request = URLRequest(url: url)
                   request.httpMethod = "POST"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                   let body = ["refreshToken": refreshToken]
                   request.httpBody = try JSONEncoder().encode(body)
        
                   let (data, response) = try await URLSession.shared.data(for: request)
        
                   guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
                       throw AuthError.refreshFailed
                   }
        
                   let decoder = JSONDecoder()
                   decoder.dateDecodingStrategy = .iso8601
                   let decoded = try decoder.decode(LoginResponse.self, from: data)
        
                   self.setTokens(access: decoded.accessToken, refresh: decoded.refreshToken)
                   return decoded.accessToken
               }
        
               refreshTask = task
               defer { refreshTask = nil }
        
               do {
                   return try await task.value
               } catch {
                   NotificationCenter.default.post(name: .sessionExpired, object: nil)
                   clear()
                   throw error
               }
           }
       }

extension Notification.Name {
    static let sessionExpired = Notification.Name("sessionExpired")
}

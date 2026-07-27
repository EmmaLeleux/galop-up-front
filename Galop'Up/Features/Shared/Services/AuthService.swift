//
//  AuthService.swift
//  Galop'Up
//
//  Created by Emma on 20/05/2026.
//

import Foundation
import Observation
import KeychainAccess

@Observable
@MainActor
class AuthService {
    private let apiClient: APIClient
        private let tokenStore: TokenStore

        var currentUser: User?
        var errorMessage: String?
        var isAuthenticated: Bool { currentUser != nil }

        init(apiClient: APIClient, tokenStore: TokenStore) {
            self.apiClient = apiClient
            self.tokenStore = tokenStore
        }
    
    
    func fetchUser() async throws {
        guard let url = URL(string: "http://localhost:8080/user/me") else {
            print("Wrong URL")
            return
        }
       
        let data = try await apiClient.send { token in
                    var request = URLRequest(url: url)
                    request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                    return request
                }
                currentUser = try JSONDecoder().decode(User.self, from: data)
    }
    
    private func handleAuthResponse(_ data: Data) async throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(LoginResponse.self, from: data)

        await tokenStore.setTokens(access: decoded.accessToken, refresh: decoded.refreshToken)
        errorMessage = nil
        NotificationCenter.default.post(name: .didLogin, object: nil)

        try await fetchUser()
    }

    func register(email: String, password: String, confirmPassword: String) async throws {
        guard let url = URL(string: "http://localhost:8080/auth/register") else {
            print("Wrong URL")
            return
        }

        guard !password.isEmpty && !confirmPassword.isEmpty && !email.isEmpty else {
            errorMessage = "Veuillez renseigner tout les champs."
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Les deux mot de passe ne correspondent pas."
            return
        }
        guard email.contains("@"), email.contains(".") else {
            errorMessage = "Veuillez entrer un email valide"
            return
        }

        let body = ["email": email, "password": password, "confirmPassword": confirmPassword]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        try await handleAuthResponse(data)
    }

    func login(email: String, password: String) async throws {
        guard let url = URL(string: "http://localhost:8080/auth/login") else {
            print("Wrong URL")
            return
        }

        let body = ["email": email, "password": password]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        try await handleAuthResponse(data)
    }

    func loginWithGoogle(googleToken: String) async throws {
        guard let url = URL(string: "http://localhost:8080/auth/google") else {
            print("Wrong URL")
            return
        }

        let body = ["token": googleToken]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        try await handleAuthResponse(data)
    }
    
    func logout() async throws{
        guard let url = URL(string: "http://localhost:8080/auth/logout")
        else {
            print("mauvais url")
            return
        }
        
        let refreshToken = await tokenStore.refreshToken

            _ = try await apiClient.send { token in
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                request.httpBody = try? JSONEncoder().encode(["refreshToken": refreshToken ?? ""])
                return request
            }
        
        currentUser = nil
        await tokenStore.clear()
    }

        
    func updateUser(userInfos: UserInfoToUpdate) async throws {
        guard let url = URL(string: "http://localhost:8080/user")
        else {
            print("mauvais url")
            return
        }
            let data = try await apiClient.send { token in
                var request = URLRequest(url: url)
                request.httpMethod = "PATCH"
                request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                request.httpBody = try? JSONEncoder().encode(userInfos)
                return request
            }
            currentUser = try JSONDecoder().decode(User.self, from: data)
        }
}


extension Notification.Name {
    static let didLogin = Notification.Name("didLogin")
}

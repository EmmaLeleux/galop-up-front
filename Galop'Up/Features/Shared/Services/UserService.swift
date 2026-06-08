//
//  UserService.swift
//  Galop'Up
//
//  Created by Emma on 08/06/2026.
//


import Foundation
import Observation

@Observable
class UserService{
    var authService: AuthService?
    var errorMessage: String? = nil
    
    init() {
 
    }
  
    
    func setAuthService(_ auth: AuthService) {
            self.authService = auth
        }
    
    func updateUser(userInfos: UserInfoToUpdate) async throws {
        guard let authService else { return }
        guard  authService.accessToken != nil else {
            print("mauvais token")
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/user") else {
            print("mauvais URL")
            return
        }
        if authService.expirationDate == nil || Date() > authService.expirationDate! {
            
            try await authService.refreshAccessToken()
            
        }
    
        let body: UserInfoToUpdate = userInfos
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authService.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        
        do {
            
            
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("Error encodage body: \(error)")
            return
        }
        let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
                let decoded = try decoder.decode(User.self, from: data)
                await MainActor.run {
                    authService.currentUser = decoded
                }
    }
}

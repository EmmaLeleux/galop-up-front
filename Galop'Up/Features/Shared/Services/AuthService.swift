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
class AuthService {
    private let keychain = Keychain(service: "emma.Galop-Up")
    var accessToken: String? {
        didSet {
            if let accessToken = accessToken {
                try? keychain.set(accessToken, key: "authToken")
            } else {
                try? keychain.remove("authToken")
            }
        }
    }
    
    var refreshToken: String? {
        didSet {
            if let refreshToken = refreshToken {
                try? keychain.set(refreshToken, key: "refreshToken")
            } else {
                try? keychain.remove("refreshToken")
            }
        }
    }
    
    var expirationDate: Date? {
        didSet {
            if let date = expirationDate {
                try? keychain.set(ISO8601DateFormatter().string(from: date), key: "expirationDate")
            } else {
                try? keychain.remove("expirationDate")
            }
        }
    }
    
    var currentUser: User? {
        didSet {
            if let encoded = try? JSONEncoder().encode(currentUser) {
                try? keychain.set(encoded, key: "currentUser")
            } else {
                try? keychain.remove("currentUser")
            }
        }
    }
    
    var errorMessage: String? = nil
    var isAuthenticated: Bool {
        return accessToken != nil && currentUser != nil && refreshToken != nil
    }
    
    
    init() {
        
        accessToken = try? keychain.get("authToken") ?? nil
        refreshToken = try? keychain.get("refreshToken") ?? nil
        
        if let dateString = try? keychain.get("expirationDate"),
           let expiration = ISO8601DateFormatter().date(from: dateString){
            expirationDate = expiration
        }
        if let data = try? keychain.getData("currentUser"),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = user
        }
    }
    
    
    func fetchUser() async throws {
        guard let url = URL(string: "http://localhost:8080/user/me") else {
            print("Wrong URL")
            return
        }
        if expirationDate == nil || Date() > expirationDate! {
           
            try await refreshAccessToken()
            
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let accessToken = accessToken else {
            print("Token manquant")
            return
        }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do{
                    let decodedUser = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        self.currentUser = decodedUser
                    }
                }
                catch {
                    print("Error decoding: \(error)")
                }
            }
            else if let error {
                print("Error: \(error)")
            }
        }
        .resume()
    }
    
    func register(email: String, password: String, confirmPassword: String) async throws {
        guard let url = URL(string: "http://localhost:8080/auth/register") else {
            print("Wrong URL")
            return
        }
        
        guard password != "" && confirmPassword != "" && email != "" else {
            self.errorMessage = "Veuillez renseigner tout les champs."
            return
        }
        
        guard password == confirmPassword else {
            self.errorMessage = "Les deux mot de passe ne correspondent pas."
            return
        }
        
        guard email.contains("@") == true || email.contains(".") == true else{
            self.errorMessage = "Veuillez entrer un email valide"
            return
        }
        
        let body: [String: String] = [
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //route public
        
        do {
            
            
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("Error encodage body: \(error)")
            return
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
                let decoded = try decoder.decode(LoginResponse.self, from: data)
                await MainActor.run {
                    self.accessToken = decoded.accessToken
                    self.refreshToken = decoded.refreshToken
                    self.expirationDate = decoded.accessTokenExpiration
                    
                    self.errorMessage = nil
                    
                    UserDefaults.standard.set(decoded.accessToken, forKey: "authToken")
                    NotificationCenter.default.post(name: .didLogin, object: nil)
                }
        try await self.fetchUser()
    }
    
    func login(email: String, password: String) async throws {
        guard let url = URL(string: "http://localhost:8080/auth/login") else {
            print("Wrong URL")
            return
        }
        
        //créer le json  à envoyer
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //pas besoin d'authentification dans cette route, route public
        
        do {
            
            
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("Error encodage body: \(error)")
            return
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
                let decoded = try decoder.decode(LoginResponse.self, from: data)
                await MainActor.run {
                    self.accessToken = decoded.accessToken
                    self.refreshToken = decoded.refreshToken
                    self.expirationDate = decoded.accessTokenExpiration
                    
                    self.errorMessage = nil
                    
                    UserDefaults.standard.set(decoded.accessToken, forKey: "authToken")
                    NotificationCenter.default.post(name: .didLogin, object: nil)
                }
        try await self.fetchUser()
    }
    
    
    func loginWithGoogle(googleToken: String) async throws{
        guard let url = URL(string: "http://localhost:8080/auth/google") else {
            print("Wrong URL")
            return
        }
        
        let body: [String: String] = ["token": googleToken]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("Erreur encodage body: \(error)")
            return
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
                let decoded = try decoder.decode(LoginResponse.self, from: data)
                await MainActor.run {
                    self.accessToken = decoded.accessToken
                    self.refreshToken = decoded.refreshToken
                    self.expirationDate = decoded.accessTokenExpiration
                    
                    self.errorMessage = nil
                    
                    UserDefaults.standard.set(decoded.accessToken, forKey: "authToken")
                    NotificationCenter.default.post(name: .didLogin, object: nil)
                }
        try await self.fetchUser()
        
    }
    
    func logout(){
        guard let url = URL(string: "http://localhost:8080/auth/logout")
        else {
            print("mauvais url")
            return
        }
        
        let body: [String: String] = ["refreshToken": self.refreshToken ?? ""]
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(self.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("Erreur encodage body: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("erreur:", error)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    self.accessToken = nil
                    self.currentUser = nil
                    self.refreshToken = nil
                    self.expirationDate = nil
                    print("status:", httpResponse.statusCode)
                }

                if let data = data {
                    print("réponse:", String(data: data, encoding: .utf8) ?? "vide")
                }

            }.resume()
    }
    
    func refreshAccessToken() async throws{
        //TODO: la déconnection via ça est super lente
        guard let url = URL(string: "http://localhost:8080/auth/refresh-token") else {
            print("Wrong URL")
            return
        }
        
        
        //créer le json  à envoyer
        let body: [String: String] = [
            "refreshToken": self.refreshToken ?? "",
            "userId": self.currentUser?.id.description ?? ""
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //pas besoin d'authentification dans cette route, route public
        
        do {
            
            
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("Error encodage body: \(error)")
            return
        }
        let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decoded = try decoder.decode(LoginResponse.self, from: data)
                await MainActor.run {
                    self.accessToken = decoded.accessToken
                    self.refreshToken = decoded.refreshToken
                    self.expirationDate = decoded.accessTokenExpiration
                    self.errorMessage = nil
                    UserDefaults.standard.set(decoded.accessToken, forKey: "authToken")
                }
            } catch {
                await MainActor.run {
                    self.accessToken = nil
                    self.refreshToken = nil
                    self.currentUser = nil
                    self.expirationDate = nil
                    self.errorMessage = "Vous avez été déconnecté, veuillez vous reconnecter"
                }
                throw error
            }
    }
}


extension Notification.Name {
    static let didLogin = Notification.Name("didLogin")
}

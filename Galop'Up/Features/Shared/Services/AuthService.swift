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
    
    func fetchUser() {
        guard let url = URL(string: "http://localhost:8080/user/me") else {
            print("Wrong URL")
            return
        }
        if expirationDate == nil || Date() > expirationDate! {
           
            refreshAccessToken { success in
                        guard success else { return }
                        self.fetchUser()
                    }
            
                    return
            
            
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
    
    func register(email: String, password: String, confirmPassword: String) {
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decoded = try decoder.decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.accessToken = decoded.accessToken
                        self.refreshToken = decoded.refreshToken
                        self.expirationDate = decoded.accessTokenExpiration
                        self.fetchUser()
                        self.errorMessage = nil
                        
                        UserDefaults.standard.set(decoded.accessToken, forKey: "authToken")
                        NotificationCenter.default.post(name: .didLogin, object: nil)
                    }
                } catch{
                    DispatchQueue.main.async {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            self.errorMessage = errorResponse.localizedMessage
                        } else {
                            self.errorMessage = "Une erreur est survenue. Merci de réessayer"
                        }
                    }
                }
            } else if let error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func login(email: String, password: String) {
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decoded = try decoder.decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.accessToken = decoded.accessToken
                        self.refreshToken = decoded.refreshToken
                        self.expirationDate = decoded.accessTokenExpiration
                        self.fetchUser()
                        self.errorMessage = nil
                        
                        UserDefaults.standard.set(decoded.accessToken, forKey: "authToken")
                        NotificationCenter.default.post(name: .didLogin, object: nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "identifiant ou mot de passe incorrect"
                    }
                }
            } else if let error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    
    func loginWithGoogle(googleToken: String){
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decoded = try decoder.decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.accessToken = decoded.accessToken
                        self.refreshToken = decoded.refreshToken
                        self.expirationDate = decoded.accessTokenExpiration
                        self.fetchUser()
                        self.errorMessage = nil
                        
                        UserDefaults.standard.set(decoded.accessToken, forKey: "authToken")
                        NotificationCenter.default.post(name: .didLogin, object: nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "impossible de se connecter avec ce compte. Veuillez réessayer"
                    }
                }
            } else if let error {
                DispatchQueue.main.async {
                    self.errorMessage = "network error: \(error.localizedDescription)"
                }
            }
        }.resume()
        
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
    
    func refreshAccessToken(completion: @escaping (Bool) -> Void){
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decoded = try decoder.decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.accessToken = decoded.accessToken
                        self.refreshToken = decoded.refreshToken
                        self.expirationDate = decoded.accessTokenExpiration
                        self.errorMessage = nil
                        
                        UserDefaults.standard.set(decoded.accessToken, forKey: "authToken")
                        NotificationCenter.default.post(name: .didLogin, object: nil)
                        completion(true)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.accessToken = nil
                        self.refreshToken = nil
                        self.currentUser = nil
                        self.expirationDate = nil
                        self.errorMessage = "vous avez été déconnecté, veuillez vous reconnecter"
                        completion(false)
                    }
                }
            } else if let error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }.resume()
    }
}


extension Notification.Name {
    static let didLogin = Notification.Name("didLogin")
}

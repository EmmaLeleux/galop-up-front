//
//  ErrorMessage.swift
//  Galop'Up
//
//  Created by Emma on 28/05/2026.
//

import Foundation
struct ErrorResponse: Codable {
    let reason: String
    
    static let translationsError: [String: String] = [
            "EMAIL_ALREADY_EXISTS": "Cet email est déjà utilisé.",
            "INVALID_CREDENTIALS": "Mot de passe invalide.",
            "EMAIL_INVALID": "Email invalide.",
            "USERNAME_ALREADY_EXISTS": "Ce nom d'utilisateur est déjà utilisé.",
            "USER_NOT_FOUND": "Cet utilisateur n'existe pas.",
            "INVALID_TOKEN": "Le token est invalide ou a expiré. Veuillez vous reconnecter.",
            "PASSWORD_MISSING": "Le mot de passe est manquant.",
            "NOT_STRONG_ENOUGH": "Le mot de passe doit contenir au moins 8 caractères, 1 chiffre et 1 caractère spécial.",
            "PASSWORDS_NOT_CHECKED": "Les mots de passe ne correspondent pas.",
            "NO_GOOGLE_BODY": "Le corps de la demande Google est vide. Veuillez réessayer.",
        ]
        
        var localizedMessage: String {
            let listError = reason.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    let translated = listError.map { ErrorResponse.translationsError[$0] ?? $0 }
                    return translated.joined(separator: "\n")
        }
}

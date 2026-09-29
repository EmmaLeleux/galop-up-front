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
            "INVALID_MEDIA":"Les formats de fichiers acceptés sont uniquement JPEG, PNG et WebP.",
            "INVALID_CONTENT_TYPE":"Le fichier que vous avez envoyé n'est pas une image.",
            "ERROR_UPLOADING_PICTURE":"Une erreur est survenue pendant l'enregistrement de l'image. Veuillez réessayer.",
            "POST_NOT_CREATED":"Une erreur est survenue lors de la création de votre publication. Veuillez réessayer.",
            "CANNOT_UPDATE_BOTH_PICTURE_AND_PICTURE_IN_BASE": "Vous ne devez choisir qu'une seule image pour votre photo de profil.",
            "TOO_MANY_POST_PICTURES": "Vous ne pouvez pas ajouter plus de 4 images à votre publication.",
            "NOT_ENOUGH_PERMISSION": "Vous n'avez pas la permission de réaliser cette action."
        ]
        
        var localizedMessage: String {
            let listError = reason.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    let translated = listError.map { ErrorResponse.translationsError[$0] ?? $0 }
                    return translated.joined(separator: "\n")
        }
}

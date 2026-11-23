//
//  ErrorMessage.swift
//  Galop'Up
//
//  Created by Emma on 28/05/2026.
//

import Foundation
struct ErrorResponse: Codable, Equatable {
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
            "NOT_ENOUGH_PERMISSION": "Vous n'avez pas la permission de réaliser cette action.",
            "ANSWER_EMPTY": "Vous ne pouvez pas créer de question sans réponse.",
            "QUESTION_NOT_CREATED": "Une erreur est survenue, veuillez réessayer",
            "NUMBER_OF_ANSWER_NOT_VALID": "Vous n'avez pas sélectionné le nombre de réponse requis pour ce type de quiz",
            "AT_LEAST_ONE_ANSWER_MUST_BE_TRUE": "Il n'est pas possible de créer de question qui n'a pas de bonne réponse.",
            "TOO_MUCH_GOOD_ANSWER": "Vous avez sélectionné trop de bonnes réponses.",
            "POST_TITLE_OR_CONTENT_EMPTY": "Vous devez fournir un titre et du contenu pour votre publication.",
            "NO_QUESTION_AVAILABLE": "Aucune question n'a été trouvée.",
            "SESSION_NOT_FOUND": "Vous n'avez pas de quiz en cours",
            "ANSWER_NOT_FOUND": "La réponse que vous avez renseignée n'existe pas",
            "LIMIT_QUIZ_REACHED": "Vous avez atteint le nombre maximum de question pour ce quiz.",
            "QUIZ_ALREADY_FINISHED": "Le quiz auquel vous essayez de répondre est terminé ou abandonné.",
            "QUIZ_NOT_CONCERNED": "Il n'est possible d'utiliser cette action qu'avec les quiz contre la montre.",
            "TIMING_NOT_REACHED": "Il reste du temps avant la fin du quiz"
            
        ]
        
        var localizedMessage: String {
            let listError = reason.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    let translated = listError.map { ErrorResponse.translationsError[$0] ?? $0 }
                    return translated.joined(separator: "\n")
        }
}

//
//  ApiClient.swift
//  Galop'Up
//
//  Created by Emma on 23/07/2026.
//

import Foundation

struct APIClient {
    let tokenStore: TokenStore
    
    func send(_ makeRequest: @escaping (String?) -> URLRequest) async throws -> Data {
        let currentToken = await tokenStore.accessToken
           let request = makeRequest(currentToken)
           let (data, response) = try await URLSession.shared.data(for: request)

           guard let http = response as? HTTPURLResponse else {
               return data
           }

           if http.statusCode == 401 {
               let newToken = try await tokenStore.refreshAccessToken()
               let retryRequest = makeRequest(newToken)
               let (retryData, retryResponse) = try await URLSession.shared.data(for: retryRequest)

               guard let retryHttp = retryResponse as? HTTPURLResponse, retryHttp.statusCode != 401 else {
                   throw AuthError.refreshFailed
               }
               return retryData
           }

           return data
    }
}

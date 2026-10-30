//
//  ApiClient.swift
//  Galop'Up
//
//  Created by Emma on 23/07/2026.
//

import Foundation

struct APIClient {
    let tokenStore: TokenStore
    let errorViewModel: ErrorViewModel
    
    func send(_ makeRequest: @escaping (String?) -> URLRequest,
              showGlobalError: Bool = true) async throws -> Data {
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
            try await validate(retryHttp, data: retryData, showGlobalError: showGlobalError)
            return retryData
        }
        
        try await validate(http, data: data, showGlobalError: showGlobalError)
        return data
    }
    
    private func validate(_ http: HTTPURLResponse, data: Data, showGlobalError: Bool) async throws {
        guard !(200...299).contains(http.statusCode) else { return }
        
        let errorResponse = (try? JSONDecoder().decode(ErrorResponse.self, from: data))
        ?? ErrorResponse(reason: "UNKNOWN_ERROR")
        
        if showGlobalError {
            errorViewModel.show(error: errorResponse)
        }
        
        throw URLError(.badServerResponse)
    }
    
}

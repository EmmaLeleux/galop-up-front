//
//  ErrorClass.swift
//  Galop'Up
//
//  Created by Emma on 30/09/2026.
//

import Foundation
@Observable
@MainActor
class ErrorViewModel {
    var currentError: ErrorResponse?
 
    func show(error: ErrorResponse) {
        currentError = error
 
        Task { [weak self] in
            try? await Task.sleep(for: .seconds(4))
            if self?.currentError?.reason == error.reason {
                self?.currentError = nil
            }
        }
    }
 
    func dismiss() {
        currentError = nil
    }
}

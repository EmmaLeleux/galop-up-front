//
//  LessonViewModel.swift
//  Galop'Up
//
//  Created by Emma on 22/11/2026.
//

import Foundation
import MapKit

@Observable
@MainActor
class LessonViewModel {
    private let apiClient: APIClient
    
    var lessons: [Lesson] = []

    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
        
    func fetchLessons() async throws{
        guard let url = URL(string: "http://localhost:8080/lesson") else {
            print("Wrong URL")
            return
        }
            
            let data = try await apiClient.send { token in
                var request = URLRequest(url: url)
                request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                return request
            }
            
            
            let decoder = JSONDecoder()
            
            lessons = try decoder.decode([Lesson].self, from: data)
           
        }

        
    }

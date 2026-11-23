//
//  EventViewModel.swift
//  Galop'Up
//
//  Created by Emma on 07/11/2026.
//


import Foundation
import MapKit

@Observable
@MainActor
class EventViewModel {
    private let apiClient: APIClient
    
    var events: [EventCustom] = []

    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func openDirections(to event: EventCustom) {
        let location = CLLocation(latitude: event.latitude, longitude: event.longitude)
        let item = MKMapItem(location: location, address: nil)
        item.name = event.placeName
        item.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
        
    func fetchEvents() async throws{
        guard let url = URL(string: "http://localhost:8080/event") else {
            print("Wrong URL")
            return
        }
            
            let data = try await apiClient.send { token in
                var request = URLRequest(url: url)
                request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                return request
            }
            
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            events = try decoder.decode([EventCustom].self, from: data)
           
        }
    
    func fetchLikesEvents() async throws{
        guard let url = URL(string: "http://localhost:8080/event/like") else {
            print("Wrong URL")
            return
        }
            
            let data = try await apiClient.send { token in
                var request = URLRequest(url: url)
                request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                return request
            }
            
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            events = try decoder.decode([EventCustom].self, from: data)
           
        }
    
    func likeOrDislike(event: EventCustom, user: UserPublic) async throws {
        let isLiking = event.isLikeByMe

        guard let url = URL(string: "http://localhost:8080/event/\(event.id)/like") else { return }

        let _ = try await apiClient.send { token in
            var request = URLRequest(url: url)
            request.httpMethod = isLiking ? "DELETE" : "POST"
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            return request
        }
        
        guard let index = events.firstIndex(where: { $0.id == event.id }) else { return }

        
        events[index].isLikeByMe.toggle()
    }
        
    }

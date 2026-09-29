//
//  DateExtension.swift
//  Galop'Up
//
//  Created by Emma on 31/08/2026.
//

import Foundation

extension Date {
    var relativeDisplayString: String {
        let now = Date()
        let seconds = now.timeIntervalSince(self)
        
        if seconds < 60 {
            return "maintenant"
        }
        
        if seconds < 3600 {
            let minutes = Int(seconds / 60)
            return "il y a \(minutes) min"
        }
        
        let calendar = Calendar.current
        
        if calendar.isDateInToday(self) {
            let hours = Int(seconds / 3600)
            return hours == 1 ? "il y a 1 heure" : "il y a \(hours) heures"
        }
        
        if calendar.isDateInYesterday(self) {
            return "hier"
        }
        
        if let daysAgo = calendar.dateComponents([.day], from: self, to: now).day, daysAgo < 7 {
            return "il y a \(daysAgo) jours"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: self)
    }
}

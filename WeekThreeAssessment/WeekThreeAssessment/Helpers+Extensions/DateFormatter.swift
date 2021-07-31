//
//  DateFormatter.swift
//  WeekThreeAssessment
//
//  Created by Tim Green on 7/30/21.
//

import Foundation

extension DateFormatter {
    
    static let eventTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}  // End of extension

extension Date {
    
    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
} // End of extension

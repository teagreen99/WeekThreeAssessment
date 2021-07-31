//
//  Event+Convenience.swift
//  WeekThreeAssessment
//
//  Created by Tim Green on 7/30/21.
//

import CoreData


extension Event {
    @discardableResult
    convenience init(name: String, timeOfDay: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.timeOfDay = timeOfDay
    } // End of initializer
    
    func wasAttendedToday() -> Bool {
        guard let _ = (attendedDates as? Set<AttendedDate>)?.first(where: { attendedDate in
            guard let day = attendedDate.date else { return false }
            return Calendar.current.isDate(day, inSameDayAs: Date())
            
        })
        else { return false }
        return true
    }
} // End of extension

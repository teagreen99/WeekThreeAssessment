//
//  AttendedDate+ConVenience.swift
//  WeekThreeAssessment
//
//  Created by Tim Green on 7/30/21.
//

import CoreData

extension AttendedDate {
    @discardableResult
    convenience itit(date: Date, event: Event, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.date = date
        self.event = event
    }
}

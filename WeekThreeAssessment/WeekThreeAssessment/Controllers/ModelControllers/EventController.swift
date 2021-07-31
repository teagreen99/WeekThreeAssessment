//
//  EventController.swift
//  WeekThreeAssessment
//
//  Created by Tim Green on 7/30/21.
//

import CoreData

class EventController {
    
    // MARK: - Properties
    static let sharedInstance = EventController()
    
    var sections: [[Event]] { [notAttendedEvents, attendedEvents] }
    var attendedEvents: [Event] = []
    var notAttendedEvents: [Event] = []
    
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // FIXME: - Fill this out?
    private init() {}
    
    // MARK: - Functions
    func createEvent(name: String, timeOfDay: Date) {
        
        let event = Event(name: name, timeOfDay: timeOfDay)
        notAttendedEvents.append(event)
        print(sections[0][0])
        CoreDataStack.saveContext()
        
    } // End of function
    
    func fetchEvents() {
        let events = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        attendedEvents = events.filter { $0.wasAttendedToday() }
        notAttendedEvents = events.filter { !$0.wasAttendedToday() }
    } // End of function
    
    func updateEventDetails(_ event: Event, name: String, date: Date) {
        event.name = name
        event.timeOfDay = date
        
        CoreDataStack.saveContext()
    } // End of function
    
    func updateEventStatus(_ wasAttended: Bool, event: Event) {
        if wasAttended {
            AttendedDate(date: Date(), event: event)
            if let index = notAttendedEvents.firstIndex(of: event) {
                notAttendedEvents.remove(at: index)
                attendedEvents.append(event)
            }
        } else {
            let mutableAttendedDates = event.mutableSetValue(forKey: "attendedDates")
            if let attendedDate = (mutableAttendedDates as? Set<AttendedDate>)?.first(where: { takenDate in
                guard let date = takenDate.date else { return false }
                return Calendar.current.isDate(date, inSameDayAs: Date())
            }) {
                mutableAttendedDates.remove(attendedDate)
                if let index = attendedEvents.firstIndex(of: event) {
                    attendedEvents.remove(at: index)
                    notAttendedEvents.append(event)
                }
            }
        }
        CoreDataStack.saveContext()
    } // End of function
    
    func deleteEvent(_ event: Event) {
        
        if let index = notAttendedEvents.firstIndex(of: event) {
            notAttendedEvents.remove(at: index)
        } else if let index = attendedEvents.firstIndex(of: event) {
            attendedEvents.remove(at: index)
        }
        
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
    } // End of function
    
    
} // End of class

//
//  CoreDataStack.swift
//  WeekThreeAssessment
//
//  Created by Tim Green on 7/30/21.
//

import CoreData

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WeekThreeAssessment")
        container.loadPersistentStores { (storeDescription, error) in
            
            if let error = error {
                fatalError("Error loading persistent stores \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {

            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    }
}  // End of enum

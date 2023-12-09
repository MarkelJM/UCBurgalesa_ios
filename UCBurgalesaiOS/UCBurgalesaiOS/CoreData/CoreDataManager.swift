//
//  CoreDataManager.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 2/11/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RideCheckinModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - RideCheckin Management
    func saveRideCheckin(for rideId: String, hasStarted: Bool, hasCompleted: Bool, on date: Date) {
        let rideCheckin = RideCheckin(context: context)
        rideCheckin.rideId = rideId
        rideCheckin.hasStarted = hasStarted
        rideCheckin.hasCompleted = hasCompleted
        rideCheckin.checkinDate = date
        saveContext()
    }
    
    func getRideCheckin(for rideId: String, on date: Date) -> RideCheckin? {
        let fetchRequest: NSFetchRequest<RideCheckin> = RideCheckin.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "rideId == %@ AND checkinDate == %@", rideId, date as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Error fetching ride checkin status: \(error)")
            return nil
        }
    }
    
}

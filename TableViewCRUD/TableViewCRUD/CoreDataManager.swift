//
//  CoreDataManager.swift
//  TableViewCRUD
//
//  Created by RAGHAV SHARMA on 14/04/21.
//

import Foundation
import CoreData

public class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {
    }
    
    public lazy var persistanceContainer: NSPersistentContainer = {
        let persistanceContainer = NSPersistentContainer(name: "TableViewCRUD")
        persistanceContainer.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return persistanceContainer
    }()
    
    public lazy var managedObjectContext = CoreDataManager.shared.persistanceContainer.viewContext
    
    public func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func retrieve<T: NSManagedObject>(entityClass: T.Type, sortBy:String? = nil, predicate: String? = nil) -> [T]? {
        let entityName = NSStringFromClass(entityClass).split(separator: ".")[0]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(entityName))
        if let predicate = predicate {
            fetchRequest.predicate = NSPredicate(format: predicate, [])
        }
       // fetchRequest.propertiesToFetch
        if sortBy != nil {
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: sortBy, ascending: true)]
        }
        do {
           return try managedObjectContext.fetch(fetchRequest) as? [T]
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func delete() {
        
    }
}

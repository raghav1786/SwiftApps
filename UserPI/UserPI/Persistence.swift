
//
//  Persistence.swift
//  UserPI
//
//  Created by RAGHAV SHARMA on 14/05/22.
//

import CoreData
class PersistanceContainer: NSPersistentCloudKitContainer {
    override class func defaultDirectoryURL() -> URL {
        let url =  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "test.appGroup.com")!
        return url
    }
}

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: PersistanceContainer

    init(inMemory: Bool = false) {
        container = PersistanceContainer(name: "UserPI")
        let localPath = PersistanceContainer.defaultDirectoryURL()
print(localPath)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        // Create a store description for a local store
        let localStoreLocation = localPath.appendingPathComponent("UserPI.sqlite")
           let localStoreDescription =
               NSPersistentStoreDescription(url: localStoreLocation)
           localStoreDescription.configuration = "Local"

           // Create a store description for a CloudKit-backed local store
         let cloudStoreLocation = localPath.appendingPathComponent("cloud.sqlite")
           let cloudStoreDescription =
               NSPersistentStoreDescription(url: cloudStoreLocation)
           cloudStoreDescription.configuration = "Cloud"

           // Set the container options on the cloud store
           cloudStoreDescription.cloudKitContainerOptions =
               NSPersistentCloudKitContainerOptions(
                   containerIdentifier: "com.my.container")

           // Update the container's list of store descriptions
           container.persistentStoreDescriptions = [
            localStoreDescription,
            cloudStoreDescription
           ]

           // Load both stores
           container.loadPersistentStores { storeDescription, error in
               print("Description is:\(storeDescription)")
               guard error == nil else {
                   fatalError("Could not load persistent stores. \(error?.localizedDescription)")
               }
           }
    }
}


////
////  Persistence.swift
////  UserPI
////
////  Created by RAGHAV SHARMA on 14/05/22.
////
//
//import CoreData
//
//class PersistanceContainer: NSPersistentContainer {
//    override class func defaultDirectoryURL() -> URL {
//        let url =  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "test.appGroup.com")!
//        return url
//    }
//}
//
//
//struct PersistenceController {
//    static let shared = PersistenceController()
//
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//
//    let container: NSPersistentContainer
//
//    init(inMemory: Bool = false) {
//        container = PersistanceContainer(name: "UserPI")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        print(PersistanceContainer.defaultDirectoryURL())
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                Typical reasons for an error here include:
//                * The parent directory does not exist, cannot be created, or disallows writing.
//                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                * The device is out of space.
//                * The store could not be migrated to the current model version.
//                Check the error message to determine what the actual problem was.
//                */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//    }
//}

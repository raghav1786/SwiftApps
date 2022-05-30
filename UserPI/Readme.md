## User Personal Info
<img width="400" alt="Screenshot 2022-05-30 at 13 12 41" src="https://user-images.githubusercontent.com/53406407/170944371-31c06e6d-9c15-43fb-9570-2258903cf7b1.png">

## Overview 
A app created to support storing personal info to iCloud using [Core Data + icLoud] NSPersistanceCloudKitContainer.

## Requirements
* iOS 14+
* Swift 5.2



Happy coding! 😀


Details:
# Core Data + CloudKit

## ****Overview:****

Use Core Data with CloudKit to give users seamless access to the data in your app across all their devices.
Core Data with CloudKit combines the benefits of local persistence with cloud backup and distribution. Core Data provides powerful object graph management features for developing an app with structured data. CloudKit lets users access their data across every device on their iCloud account, while serving as an always-available backup service.

**Use Case:**

Need for storing and using personal Info on app that should be visible across user devices

Store information in persistence [core data] and then have it synced automatically to iCloud.
<img width="408" alt="cd-cloudkit-overview%402x" src="https://user-images.githubusercontent.com/53406407/170946244-7a706241-2d99-4612-90ff-da5bb24081f6.png">



## Setup:

- changing NSPersistentContainer to NSPersistentCloudKitContainer and enabling a few capabilities in the project settings related to iCloud.
- we should consider two persistence stores one for iCloud related data and one for local data.

```swift
import CoreData
class PersistanceContainer: NSPersistentCloudKitContainer {
    override class func defaultDirectoryURL() -> URL {
        let url =  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "test.appGroup.com")!
        return url
    }
}

private(set) lazy var storeContainer: NSPersistentCloudKitContainer = {
        enum Constants: String {
            case localSQLite = "UserPI.sqlite"
            case cloudSQLite = "cloud.sqlite"
            case cloudConfigurationName = "Cloud"
            case localConfigurationName = "Local"
        }
        let container = PersistanceContainer(name: modelName)

        let localPath = PersistanceContainer.defaultDirectoryURL()

        // Create a store description for a local store
        let localStoreLocation = localPath.appendingPathComponent(Constants.localSQLite.rawValue)
        let localStoreDescription =
            NSPersistentStoreDescription(url: localStoreLocation)
        localStoreDescription.configuration = Constants.localConfigurationName.rawValue

        // Create a store description for a CloudKit-backed local store
        let cloudStoreLocation = localPath.appendingPathComponent(Constants.cloudSQLite.rawValue)
        let cloudStoreDescription =
            NSPersistentStoreDescription(url: cloudStoreLocation)
        cloudStoreDescription.configuration = Constants.cloudConfigurationName.rawValue

        // Set the container options on the cloud store
        cloudStoreDescription.cloudKitContainerOptions =
            NSPersistentCloudKitContainerOptions(
                containerIdentifier: "com.development.UserPI.container")

        // Update the container's list of store descriptions
        container.persistentStoreDescriptions = [localStoreDescription,
                                                 cloudStoreDescription]

        container.loadPersistentStores { [weak self] _, error in
            guard let self = self else {
                TheUnexpectedHappened.thisShouldNeverHappen("No CoreDataStore instance!")
            }

            if let error = error {
                self.logger.error("Unresolved error \(error), \(error.localizedDescription)")
                TheUnexpectedHappened.thisShouldNeverHappen("CreatorsPersistentContainer couldn't be loaded")
            }
            self.logger.debug("CreatorsPersistentContainer loaded successfuly")
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        do {
            try container.viewContext.setQueryGenerationFrom(.current)
        } catch {
            fatalError("Failed to pin viewContext to the current generation: \(error)")
        }

        return container
    }()
```

we have to create two configurations in Core Data .xcDataModel.

1. Local Configuration [all entries we do not want to sync with iCloud]

eg. ItemEntity
<img width="850" alt="Screenshot%202022-05-16%20at%2012 38 02" src="https://user-images.githubusercontent.com/53406407/170946362-c941ff1f-a364-4b3a-ab8e-8af295dfc4ec.png">



1. Cloud Configuration [entries to be synced with iCloud]
eg. personalInfoEntity
    <img width="901" alt="Screenshot%202022-05-16%20at%2012 37 57" src="https://user-images.githubusercontent.com/53406407/170946382-daf454df-0ffe-4235-8cd3-b0c3cb039d71.png">


## CRUD Operation:
<img width="1241" alt="Screenshot%202022-05-16%20at%2012 47 02" src="https://user-images.githubusercontent.com/53406407/170947070-10100b88-4e5a-4d9c-bcd0-25c76ebbebc8.png">

| Add operation: |  Once data is saved to  personal info entity , same should be synced to iCloud. |
| --- | --- |
| Update operation: | update the existing core data entity will push the relevant changes to iCloud.  |
| Delete operation:  | delete the existing core data entity will push the relevant changes to iCloud.  |
| Fetch Operation: | since iCloud syncs with core data once app is build. so fetching core data entity will give us latest data.  |

## **Key Findings:**

 1. we should be mindful with migrations after adding  two configurations in Core Data [Local + Cloud] . Lightweight migration should be considered at least.

1. if we are using Enterprise provisioning profile , in iCloud developer console we should add  and push schema to Production in order to sync data from app to iCloud.
2. 

## Core Data Mirroring with iCloud.

<img width="615" alt="Screenshot%202022-05-16%20at%2013 02 13" src="https://user-images.githubusercontent.com/53406407/170947294-256277b7-4a74-4239-a1f5-c6677d8c05dc.png">

## POC app:

[UserPI.zip](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/78e771d1-5baa-4292-a667-4181ce601ae6/UserPI.zip)

## Important Links:

****[Mirroring a Core Data Store with CloudKit](https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit)****

[Setting Up Core Data with CloudKit](https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/setting_up_core_data_with_cloudkit)

[Creating a Core Data Model for CloudKit](https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/creating_a_core_data_model_for_cloudkit)
.[Syncing a Core Data Store with CloudKit](https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/syncing_a_core_data_store_with_cloudkit)
.[Reading CloudKit Records for Core Data](https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/reading_cloudkit_records_for_core_data)


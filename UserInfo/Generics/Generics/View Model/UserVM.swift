//
//  ViewModel.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 08/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import ReusableUI
import FirebaseDatabase
import FirebaseFirestoreSwift

class UserVM  {
    
    //properties
    let dataSource : DataSource = DataSource()
    var fireBaseStore: some FirebaseDataStore = FirebaseRealTimeDatabase()
    var users = [Users]()
    
    //configure data into ViewModel for custom Cell used in tableView
    func configureData() {
        dataSource.sections.removeAll()
        var rowItems : [TableViewCompatible] = []
        
        // navigating through each user and fetching its details
        for user in users   {
            //Getting user Details for the user
            //passing detail to UserDescription Struct
            let userInfoCell = UserDescription( name: user.name, phone: user.contact , address: user.address, email: user.email)
            
            //adding details of user to UserInfoTableViewCellModel
            let userInfoTableViewCell = UserInfoTableViewCellModel(referenceContent: userInfoCell)
            rowItems.append(userInfoTableViewCell)
        }
        
        //appending rowItems into section
        let section = BaseTableViewSection(sortOrder: 0, items: rowItems)
        dataSource.sections.append(section)
    }
}

// MARK: Database Setup
extension UserVM {
}


// MARK: Database Queries
extension UserVM {
    func getUsers(completionAction: @escaping (Bool)->()) {
        //Retrieve the users and listen for changes
        fireBaseStore.fetch(entity: Users.self) {[weak self] result in
            guard let data = try? result.get() else { return }
            self?.users = []
            self?.users = data
            completionAction(true)
        }
    }
    
    func deleteUsers(completionAction: @escaping (Bool)->()) {
        fireBaseStore.delete(entity: Users.self) { result in
            if let isSuccess = try? result.get() {
                completionAction(isSuccess)
            }
        }
    }
    
    func updateUser(completionAction: @escaping (Bool)->()) {
        fireBaseStore.update(data: Users(name: "suri", address: "jalandhar", contact: 45678987654, email: "raghav@yml.com"), key: "-Mj9L6tPIYvXyaBzIDP-") { result in
            if let isSuccess = try? result.get() {
                completionAction(isSuccess)
            }
        }
    }
    
    func getUsersFromFireStore(completionAction: @escaping (Bool)->()) {
        //        CloudFirestoreDatabase().collection("Users").getDocuments() { (querySnapshot, err) in
        //            if let err = err {
        //                print("Error getting documents: \(err)")
        //                completionAction(false)
        //            } else {
        //                for document in querySnapshot!.documents {
        //                    guard let user = try? document.data(as: Users.self) else { return }
        //                    self.users.append(user)
        //                }
        //                completionAction(true)
        //            }
        //        }
    }
}

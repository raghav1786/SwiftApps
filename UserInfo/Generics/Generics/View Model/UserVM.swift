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

class UserVM  {
    
    //properties
    let dataSource : DataSource = DataSource()
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
        FirebaseDBReferences().refUsers.observe(.value,with: { snapshot in
            for usersSnapshot in snapshot.children {
                let dataSnapshot = usersSnapshot as! DataSnapshot
                guard let usersObject = dataSnapshot.value else { return }
                if let data = try?  JSONSerialization.data(withJSONObject: usersObject, options: []) {
                    guard let user = try? JSONDecoder().decode(Users.self, from: data) else { return }
                    self.users.append(user)
                }
            }
            
            //fetching userDetails from firebase
            completionAction(true)
        })
    }
    
    func getUsersFromFireStore(completionAction: @escaping (Bool)->()) {
        FirebaseDBReferences().fireStoreRef.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionAction(false)
            } else {
                for document in querySnapshot!.documents {
                    if let data = try?  JSONSerialization.data(withJSONObject: document.data(), options: []) {
                        guard let user = try? JSONDecoder().decode(Users.self, from: data) else { return }
                        self.users.append(user)
                    }
                }
                completionAction(true)
            }
        }
    }
}

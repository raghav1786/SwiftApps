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
    var userDetails = [UserDetails]()
    var users = [Users]()
    var ref : DatabaseReference?
    var refUsers : DatabaseReference?
    var refUserDetails : DatabaseReference?
    
    //configure data into ViewModel for custom Cell used in tableView
    func configureData() {
        dataSource.sections.removeAll()
        var rowItems : [TableViewCompatible] = []
        
        // navigating through each user and fetching its details
        for user in users   {
            //Getting user Details for the user
            let userDetail = userDetails[user.key]
            //passing detail to UserDescription Struct
            let userInfoCell = UserDescription(id: user.key, name: user.name, phone: userDetail.contact, address: userDetail.address, email: userDetail.email)
            
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
    func setupFirebaseReferences() {
        //set the firebase Reference
        ref = Database.database().reference()
        refUsers =  ref?.child("users")
        refUserDetails = ref?.child("userDetails")
    }
}


// MARK: Database Queries
extension UserVM {
    func getUsers(completionAction: @escaping (Bool)->()) {
        //Retrieve the users and listen for changes
        refUsers?.observe(.value,with: { snapshot in
            var users = [Users]()
            for usersSnapshot in snapshot.children {
                let key = (usersSnapshot as AnyObject).key as String
                let dataSnapshot = usersSnapshot as! DataSnapshot
                let user = Users(snapshot: dataSnapshot,
                                 keyValue: Int(key) ?? 0)
                users.append(user)
            }
            self.users = users
            
            //fetching userDetails from firebase
            completionAction(true)
        })
    }
    
    func getUserDetails(completionAction: @escaping (Bool)->()) {
        //Retrieve the userDetails and listen for changes
        refUserDetails?.observe(.value,with: { snapshot in
            var userDetails = [UserDetails]()
            for userDetailsSnapshot in snapshot.children {
                let key = (userDetailsSnapshot as AnyObject).key as String
                let userDetail = UserDetails(snapshot: userDetailsSnapshot as! DataSnapshot,keyValue: Int(key) ?? 0)
                userDetails.append(userDetail)
            }
            self.userDetails = userDetails
            //reload table after getting data
            completionAction(true)
        })
    }
}

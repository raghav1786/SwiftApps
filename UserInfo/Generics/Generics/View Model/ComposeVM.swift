//
//  ComposeVM.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 15/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ComposeVM {
    var ref : DatabaseReference?
    var refUsers : DatabaseReference?
    var refUserDetails : DatabaseReference?
}


// MARK: Database Setup
extension ComposeVM {
    func setupFirebaseReferences() {
        //set the firebase Reference
        ref = Database.database().reference()
        refUsers =  ref?.child("users")
        refUserDetails = ref?.child("userDetails")
    }
}

// MARK: Writing to Database
extension ComposeVM {
    func addUserDetailsToDB(userID: String, email: String, contact: String, address: String) {
        refUserDetails?.child(userID).child("email").setValue(email)
        refUserDetails?.child(userID).child("contact").setValue(Int64(contact))
        refUserDetails?.child(userID).child("address").setValue(address)
    }
    
    func addUserToDB(userID: String, name: String) {
        refUsers?.child(userID).child("name").setValue(name)
    }
}

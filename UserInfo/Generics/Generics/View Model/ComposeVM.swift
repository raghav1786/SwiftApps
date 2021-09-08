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
}

// MARK: Writing to Database
extension ComposeVM {
    
    func addUserToDB(name: String,email: String, contact: String, address: String) {
        let id = FirebaseDBReferences().refUsers.childByAutoId()
        id.child("email").setValue(email)
        id.child("contact").setValue(Int64(contact))
        id.child("address").setValue(address)
        id.child("name").setValue(name)
    }
    
    func addUserToFireStoreDB(name: String,email: String, contact: String, address: String) {
        FirebaseDBReferences().fireStoreRef.collection("Users").addDocument(data: [
            "email": email,
            "name": name,
            "contact": Int64(contact) ?? 0,
            "address": address
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }
}

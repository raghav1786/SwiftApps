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
}

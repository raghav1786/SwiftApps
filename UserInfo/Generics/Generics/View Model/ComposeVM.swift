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
    var fireBaseStore: some FirebaseDataStore =  FirebaseRealTimeDatabase()
}

// MARK: Writing to Database
extension ComposeVM {
    
    func addUserToDB(name: String,email: String, contact: String, address: String) {
        fireBaseStore.add(data: Users(name: name, address: address, contact: Int64(contact) ?? 0, email: email)) { result in
            
        }
    }
    
    func addUserToFireStoreDB(name: String,email: String, contact: String, address: String) {
//        fireBaseStore?.fireStoreRef.collection("Users").addDocument(data: [
//            "email": email,
//            "name": name,
//            "contact": Int64(contact) ?? 0,
//            "address": address
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added")
//            }
//        }
    }
}

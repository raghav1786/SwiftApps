//
//  UserDetails.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 16/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//
//
import Foundation
import FirebaseDatabase

internal struct UserDetails {
    let address: String
    let email:String
    let contact: Int64
    let key : Int

    internal init(address: String,email:String,contact:Int64,key:Int) {
        self.address = address
        self.email = email
        self.contact = contact
        self.key = key
    }
    
    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot,keyValue:Int) {
          let snapshotValue = snapshot.value as! [String: AnyObject]
        address = snapshotValue["address"] as? String ?? "N/A"
        email = snapshotValue["email"] as? String ?? "N/A"
        contact = snapshotValue["contact"] as? Int64 ?? 0
        key = keyValue
      }

      // Func converting model for easier writing to database
      func toAnyObject() -> Any {
          return [
            "address": address,
            "email": email,
            "seenAt": contact,
            "key":key
          ]
      }
}

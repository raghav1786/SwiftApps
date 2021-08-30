//
//  UserDetails.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 16/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//
//

import FirebaseDatabase

struct UserDetails {
    let address: String
    let email:String
    let contact: Int64
    let key : Int
    
    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot,keyValue:Int) {
          let snapshotValue = snapshot.value as! [String: AnyObject]
        address = snapshotValue["address"] as? String ?? "N/A"
        email = snapshotValue["email"] as? String ?? "N/A"
        contact = snapshotValue["contact"] as? Int64 ?? 0
        key = keyValue
      }
}

//
//  Users.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 16/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import FirebaseDatabase

struct Users {
    let name: String
    let key : Int
    
    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot,keyValue:Int) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as? String ?? "N/A"
        key = keyValue
    }
}



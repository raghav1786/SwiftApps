//
//  Users.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 16/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import FirebaseDatabase

internal struct Users {
    let name: String
    let key : Int

    internal init(key: Int,name:String) {
        self.key = key
        self.name = name
    }
    
    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot,keyValue:Int) {
          let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as? String ?? "N/A"
        key = keyValue
      }

      // Func converting model for easier writing to database
      func toAnyObject() -> Any {
          return [
            "name": name,
            "key":key
          ]
      }
}



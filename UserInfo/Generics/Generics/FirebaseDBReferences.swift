//
//  FirebaseDBReferences.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 07/09/21.
//  Copyright © 2021 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestore

final class FirebaseDBReferences {
    var ref : DatabaseReference {
        let db = Database.database()
        let ref = db.reference()
        return ref
    }
    var refUsers : DatabaseReference {
        ref.child("users")
    }
    var fireStoreRef: Firestore {
        return Firestore.firestore()
    }
}

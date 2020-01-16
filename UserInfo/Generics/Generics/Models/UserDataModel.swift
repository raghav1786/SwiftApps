//
//  UserDataModel.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 16/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation


struct UserInfo  {
    var userID : String
    var name : String
    var email: String
    var contact: Int32
    var address: String
    
    public init(userID:String,name:String,email:String,contact:Int32,address:String) {
        self.userID = userID
        self.name = name
        self.contact = contact
        self.email = email
        self.address = address
    }
}

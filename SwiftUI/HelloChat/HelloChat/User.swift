//
//  User.swift
//  HelloChat
//
//  Created by RAGHAV SHARMA on 05/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit

class User {
    static let local = User()
    let id = UUID()
    var name : String { UIDevice.current.name }
    
    private init() { }
}

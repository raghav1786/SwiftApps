//
//  Breeds.swift
//  Dogify
//
//  Created by RAGHAV SHARMA on 23/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation

struct Breeds : Codable {
    let message : [String : [String]?]
    let status : String
}

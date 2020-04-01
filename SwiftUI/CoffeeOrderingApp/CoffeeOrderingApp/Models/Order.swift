//
//  Order.swift
//  COffeeOrderingApp
//
//  Created by RAGHAV SHARMA on 23/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation

struct Order : Codable {
    let name : String
    let size : String
    let coffeeName : String
    let total : Double
}

//
//  Coffee.swift
//  COffeeOrderingApp
//
//  Created by RAGHAV SHARMA on 23/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation

struct Coffee : Decodable {
    let name : String
    let imageURL : String
    let price : Double
}

extension Coffee {
    static func all() -> [Coffee] {
        return [
            Coffee(name: "Cappuccino", imageURL:"Cappuccino" , price: 2.5),
            Coffee(name: "Expresso", imageURL: "Expresso", price: 2.1),
            Coffee(name: "Regular", imageURL: "Regular", price: 1.0)
        ]
    }
}


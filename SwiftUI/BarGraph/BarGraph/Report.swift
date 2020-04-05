//
//  Report.swift
//  BarGraph
//
//  Created by RAGHAV SHARMA on 02/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation

struct Report : Hashable {
    let year : String
    let revenue : Double
}


extension Report {
    static func all() -> [Report] {
        return [
            Report(year: "2001", revenue: 2500),
            Report(year: "2002", revenue: 3400),
            Report(year: "2003", revenue: 4500)
        ]
    }
}

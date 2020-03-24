//
//  PostData.swift
//  HackerNews
//
//  Created by RAGHAV SHARMA on 15/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation

struct Results : Decodable {
    let hits : [Post]
}

public struct Post : Decodable, Identifiable {
    public var id : String {
        return objectID
    }
    let objectID : String
    let points : Int
    let title : String
    let url  : String?
}

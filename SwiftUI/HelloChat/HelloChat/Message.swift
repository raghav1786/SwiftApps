//
//  Message.swift
//  HelloChat
//
//  Created by RAGHAV SHARMA on 05/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation


struct Message : Codable,Identifiable {
    let id = UUID()
    let userName : String
    let value : String
    let timeStamp : String
//    let languageCode : String
//    let translationLanguageCode : String
//    let translatedValue : String
    
    var isFromLocalUser : Bool {userName == User.local.name}
    //var isTranslated: Bool {translatedValue.isEmpty == false}
}

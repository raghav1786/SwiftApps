//
//  ChatModels.swift
//  ChatBotApp
//
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import SwiftUI

enum Chat {
    
    // MARK: Use cases
    
    enum Model {
        struct Request {
            var inputString: String
        }
        struct Response {}
        
        struct ViewModel: Hashable {
            var text: String
            var isCurrentUser: Bool = false
        }
    }
}

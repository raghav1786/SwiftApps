//
//  ChatRouter.swift
//  ChatBotApp
//
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol ChatDataPassing {
    var dataStore: ChatDataStore? { get }
}

struct ChatRouter: ChatDataPassing {
    private var viewController: UIViewController
    private(set) var dataStore: ChatDataStore?
    
    init(viewController: UIViewController,
         dataStore: ChatDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension ChatRouter: RoutingLogic {
    enum Destination {
        case detailsScreen
    }
    
    func navigate(to destination: Destination) {
    }
    
}


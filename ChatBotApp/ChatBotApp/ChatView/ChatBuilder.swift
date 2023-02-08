//
//  ChatBuilder.swift
//  ChatBotApp
//
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import SwiftUI

protocol ChatSceneBuilder {
    func build() -> ChatView
}

struct ChatBuilder: ChatSceneBuilder {
    
    func build() -> ChatView {
        let service = ChatService()
        
        let interactor = ChatInteractor(service: service)
        
        let presenter = ChatPresenter(interactor: interactor)
        
        let view = ChatView(presenter: presenter)
                
        return view
    }
}

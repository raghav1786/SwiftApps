//
//  ChatInteractor.swift
//  ChatBotApp
//
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Combine

protocol ChatBusinessLogic {
    func send(request: Chat.Model.Request) -> AnyPublisher<String,Error>
}

struct ChatInteractor: ChatBusinessLogic {
    private let service: ChatService
    
    init(service: ChatService) {
        self.service = service
    }
    
    func send(request: Chat.Model.Request) -> AnyPublisher<String,Error> {
        service.send(inputString: request.inputString)
    }
    
}

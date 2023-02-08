//
//  ChatPresenter.swift
//  ChatBotApp
//
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Combine
import SwiftUI

final class ChatPresenter: ObservableObject {
    private var interactor: ChatBusinessLogic
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: ChatBusinessLogic) {
        self.interactor = interactor
    }
    
    // MARK: Injection
    
    enum State {
        case isLoading
        case failure(Error)
        case success
    }
    
    @Published var state = State.isLoading
    @Published var models = [Chat.Model.ViewModel]()
    @Published var showProgressIndicator = false
}

extension ChatPresenter {
    func send(request: Chat.Model.Request) {
        self.showProgressIndicator = true
        interactor.send(request: request)
            .receive(on: DispatchQueue.main)
            .sink { response in
                switch response {
                case .failure(let error):
                    self.state = .failure(error)
                default:
                    break
                }
            } receiveValue: { result in
                self.showProgressIndicator = false
                let responseText = result.trimmingCharacters(in: .newlines)
                let dataModel = Chat.Model.ViewModel(text: responseText)
                self.models.append(dataModel)
            }
            .store(in: &cancellables)
    }
}

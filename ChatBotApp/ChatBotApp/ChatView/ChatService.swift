//
//  ChatService.swift
//  ChatBotApp
//
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import OpenAISwift
import Combine

final class ChatService {
    private enum Constants {
        ///Set your API token from creating one from [here](https://beta.openai.com/account/api-keys)
        static let token = "Your Token here"
    }
    private let service = OpenAISwift(authToken: Constants.token)
    
    func send(inputString: String) -> AnyPublisher<String,Error> {
        return Future<String,Error> { [weak self] promise in
            guard let self else {
                return
            }
            
            self.service.sendCompletion(with: inputString, maxTokens: 500) { result in
                switch result {
                case .success(let model):
                    let output = model.choices.first?.text ?? ""
                    promise(.success(output))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
        
    }
}

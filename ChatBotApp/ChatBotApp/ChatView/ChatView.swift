//
//  ChatView.swift
//  ChatBotApp
//
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import SwiftUI

struct ChatView: View {
    
    @ObservedObject private var presenter: ChatPresenter
    @State private var text = ""
    
    // MARK: Injection
    
    init(presenter: ChatPresenter) {
        self.presenter = presenter
    }
    
    // MARK: View
    
    var body: some View {
        switch presenter.state {
        case .isLoading:
            ProgressView()
                .onAppear {
                    presenter.state = .success
                }
        case .failure:
            Color.red
        case .success:
            ZStack {
                VStack(alignment: .leading) {
                    ForEach(presenter.models, id: \.self) { value in
                        MessageView(currentMessage: value)
                    }
                    
                    Spacer()
                    
                    HStack {
                        TextField("Type Here...",
                                  text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                  .frame(minHeight: CGFloat(30))
                        Button("Send") {
                            guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                                return
                            }
                            let dataModel = Chat.Model.ViewModel(text: text,
                                                                 isCurrentUser: true)
                            presenter.models.append(dataModel)
                            let request = Chat.Model.Request(inputString: text)
                            presenter.send(request: request)
                            text = ""
                        }
                    }.frame(minHeight: CGFloat(50)).padding()
                }
                .padding([.leading,.trailing], 16.0)
                if presenter.showProgressIndicator {
                    ProgressView()
                }
                
            }
        }
    }
}

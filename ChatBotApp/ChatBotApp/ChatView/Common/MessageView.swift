//
//  MessageView.swift
//  ChatBotApp
//
//  Created by RAGHAV SHARMA on 08/02/23.
//

import SwiftUI

struct MessageView : View {
    var currentMessage: Chat.Model.ViewModel
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            if currentMessage.isCurrentUser {
                Spacer()
            }
            ContentMessageView(contentMessage: currentMessage.text,
                               isCurrentUser: currentMessage.isCurrentUser)
        }
    }
}


struct ContentMessageView: View {
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}

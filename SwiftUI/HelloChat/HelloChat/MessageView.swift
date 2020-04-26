//
//  MessageView.swift
//  HelloChat
//
//  Created by RAGHAV SHARMA on 05/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    let message : Message
    var body: some View {
        VStack {
            Text(self.caption(for: message))
                .font(.caption)
                .foregroundColor(.gray)
            HStack {
                if message.isFromLocalUser {
                    Spacer()
                }
                Text(message.value)
                    .foregroundColor(.white)
                    .font(.body)
                    .padding()
                    .background(message.isFromLocalUser ? Color.blue : Color.gray)
                    .cornerRadius(20)
                    .padding(.leading,message.isFromLocalUser ? 20 : 8)
                    .padding(.trailing,message.isFromLocalUser ? 8: 20)
                    .padding(.vertical, 5)
                if message.isFromLocalUser == false {
                    Spacer()
                }
            }
        }
    }
    
    private func caption(for message: Message) -> String {
        (message.isFromLocalUser ? "" : "\(message.userName)-") + "\(message.timeStamp)"
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView()
//    }
//}

//
//  ToolBarView.swift
//  HelloChat
//
//  Created by RAGHAV SHARMA on 05/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct ToolBarView: View {
    @EnvironmentObject private var viewModel : ChatViewModel
    @Binding var showActionSheet : Bool
    fileprivate func extractedFunc() -> Button<Image> {
        return Button(action:  {
            self.viewModel.clear()
        }) {
            Image(systemName: "xmark.circle")
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            TextField(viewModel.appState.nonConnected ? "Inactive" : "Add Message",
                      text:$viewModel.newMessageText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disabled(viewModel.appState.nonConnected)
            extractedFunc()
            .disabled(viewModel.newMessageTextIsEmpty)
            Button(action: {
                self.viewModel.send()
            }) {
                Image(systemName: "paperplane")
            }
            .disabled(viewModel.newMessageTextIsEmpty)
            .padding(.horizontal,8)
        }
    }
}

//struct ToolBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToolBarView()
//    }
//}

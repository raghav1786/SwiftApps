//
//  ContentView.swift
//  HelloChat
//
//  Created by RAGHAV SHARMA on 05/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI
import MultipeerConnectivity

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme : ColorScheme
    @EnvironmentObject private var viewModel : ChatViewModel
    @State private var showActionSheet = false
    
    private let formatter = DateFormatter(dateStyle: .short, timeStyle: .short)
    
    var body: some View {
        NavigationView {
            VStack {
              //  ReversibleChatScrollView(colorScheme: colorScheme, reversed: true, scrollToEnd: false)
                ChatScrollView()
                    .offset(y: viewModel.keyboardOffset + ChatViewModel.safeAreaInsetBottom)
                    .navigationBarTitle(Text(viewModel.appState.rawValue),displayMode: .inline)
                ToolBarView(showActionSheet: $showActionSheet)
                .padding()
                .padding(.bottom,ChatViewModel.safeAreaInsetBottom)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .offset(y: viewModel.keyboardOffset + ChatViewModel.safeAreaInsetBottom)
                .animation(.easeInOut(duration: viewModel.keyboardAnimationDuration))
            }
                .navigationBarItems(leading: Button(action: {
                    self.showActionSheet = true
                }){
                    Image(systemName: "square.and.arrow.up")
                }
                .padding(.horizontal,8))
            .animation(.easeInOut)
            .onTapGesture {
                UIApplication.shared.windows.first {
                    $0.isKeyWindow
                    }? .endEditing(true)
            }
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text(viewModel.actionSheetTitle), message: nil, buttons: actionSheetButtons())
        }
    }
    
    private func actionSheetButtons() -> [ActionSheet.Button] {
        var buttons = [ActionSheet.Button]()
        
        switch viewModel.appState {
        case .inactive:
            buttons += [
                .default(Text("Host Chat")) {
                    self.viewModel.startAdvertizing()
                },
                .default(Text("Join Chat")) {
                    self.viewModel.startBrowsing()
                }
            ]
        case .hostingAwaitingPeers,.hostingWithPeers:
            buttons += [
                .default(Text("Stop Hosting")) {
                    self.viewModel.disconnect()
                }
            ]
        case .searchingForChat,.connectedToHost:
            buttons += [
                .default(Text("Disconnect")) {
                    self.viewModel.disconnect()
                }
            ]
        }
        buttons.append(.cancel())
        return buttons
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11 Pro Max")
                .previewDisplayName("iPhone 11 Pro Max")
            ContentView()
                .previewDevice("iPhone SE")
                .previewDisplayName("iPhone SE")
                .environment(\.colorScheme, .dark)
        }
    }
}

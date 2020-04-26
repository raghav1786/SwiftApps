//
//  ChatViewModel.swift
//  HelloChat
//
//  Created by RAGHAV SHARMA on 05/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import Combine
import SwiftUI

final class ChatViewModel : NSObject,ObservableObject {
    enum AppState : String {
        case inactive = "Inactive"
        case searchingForChat = "Searching for Chat"
        case connectedToHost = "Connected to Host"
        case hostingAwaitingPeers = "Waiting for Peers"
        case hostingWithPeers = "Hosting Chat"

        var nonConnected : Bool {
            [AppState.hostingWithPeers,AppState.connectedToHost].contains(self) == false
        }
    }
    
    static let serviceType = "local-crosstalk"
    static var safeAreaInsetBottom : CGFloat { UIApplication.shared.windows
        .first(where: {$0.isKeyWindow})?
        .safeAreaInsets.bottom ?? 0
    }
    //Private Set
    // this variable will be only read only outside chatViewModel.
    // we want other view to acess this property but not change it.
    @Published private(set) var appState = AppState.inactive
    @Published var newMessageText = ""
    @Published private(set) var messages = [Message(userName: User.local.name, value: "HelloWorld!", timeStamp: "")]
    @Published private(set) var keyboardOffset : CGFloat = 0
    @Published private(set) var keyboardAnimationDuration : Double = 0
    
    var timeStamp : String { formatter.string(from: Date())}
    var newMessageTextIsEmpty : Bool {newMessageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty}
    var actionSheetTitle : String {
        switch appState {
        case .inactive:
            return "Do you want to host or join the chat"
        case .searchingForChat,.connectedToHost :
            return "Do you want to disconnect"
        case .hostingWithPeers,.hostingAwaitingPeers:
            return "Do you want to stop hosting"
        }
    }
    lazy var session : MCSession = {
        let session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        return session
    }()
    
    private lazy var peerID = MCPeerID(displayName: User.local.name)
    private var hostID : MCPeerID?
    private let formatter = DateFormatter(dateStyle : .short,timeStyle : .short)
    private lazy var advertizer = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: Self.serviceType)
    private lazy var browser = MCNearbyServiceBrowser(peer: peerID, serviceType: Self.serviceType)
    private var subscriptions = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .handleEvents(receiveOutput: {[weak self] _ in self?.keyboardOffset = 0 })
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification))
            .map(\.userInfo)
            .compactMap { ($0?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue}
            .assign(to:\.keyboardAnimationDuration,on: self)
        .store(in: &subscriptions)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map(\.userInfo)
            .compactMap{($0?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height }
            .map{ $0 * -1 + Self.safeAreaInsetBottom }
            .assign(to: \.keyboardOffset, on: self)
        .store(in: &subscriptions)
    }
    
    func clear() {
        newMessageText = ""
    }
    
    func send() {
        guard newMessageTextIsEmpty == false else { return }
        let message = Message(userName: User.local.name, value: newMessageText, timeStamp: timeStamp)
        insert(message: message)
        newMessageText = ""
        do {
            let data = try JSONEncoder().encode(message)
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            print(error)
        }
    }
    
    func startAdvertizing() {
        advertizer.delegate = self
        advertizer.startAdvertisingPeer()
        appState = .hostingAwaitingPeers
        hostID = peerID
    }
    
    func startBrowsing() {
        browser.delegate = self
        browser.startBrowsingForPeers()
        appState = .searchingForChat
    }
    
    func disconnect() {
        advertizer.stopAdvertisingPeer()
        browser.stopBrowsingForPeers()
        session.disconnect()
        hostID = nil
        DispatchQueue.main.async { [weak self] in
            self?.appState = .inactive
        }
    }
    
    private func insert(message: Message) {
        DispatchQueue.main.async { [weak self] in
            self?.messages.append(message)
        }
    }
}


extension ChatViewModel : MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        self.session = session
        guard state != .connecting,
            hostID == self.peerID,// i am host....
            peerID != self.peerID // and didChange is not for me...
            else { return }
        
        DispatchQueue.main.async {[weak self] in
            self?.appState = session.connectedPeers.isEmpty ? .hostingAwaitingPeers : .hostingWithPeers
        }
         
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            insert(message: try JSONDecoder().decode(Message.self,from: data))
        } catch {
            print(error)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
}

extension ChatViewModel : MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true,session)
        appState = .hostingWithPeers
    }
}

extension ChatViewModel : MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 30)
        appState = .connectedToHost
        hostID = peerID
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        if hostID == peerID {
            disconnect()
            self.hostID = nil
        }
    }
}

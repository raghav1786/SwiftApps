//
//  WebView.swift
//  HackerNews
//
//  Created by RAGHAV SHARMA on 15/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

// allow swift UiView that represent swiftUIView
struct WebView : UIViewRepresentable {
    
    let urlString : String?
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}

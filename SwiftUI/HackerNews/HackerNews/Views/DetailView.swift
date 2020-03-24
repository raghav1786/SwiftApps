//
//  DetailView.swift
//  HackerNews
//
//  Created by RAGHAV SHARMA on 15/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let url : String?
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url : "https://google.com")
    }
}

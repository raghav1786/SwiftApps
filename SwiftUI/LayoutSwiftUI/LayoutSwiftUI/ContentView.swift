//
//  ContentView.swift
//  LayoutSwiftUI
//
//  Created by RAGHAV SHARMA on 05/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack() {
            EventHeader()
            Spacer()
            EventInfoList()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

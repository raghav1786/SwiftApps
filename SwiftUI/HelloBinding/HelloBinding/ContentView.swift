//
//  ContentView.swift
//  HelloBinding
//
//  Created by RAGHAV SHARMA on 22/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State var name : String = ""
    private func printName() {
        print(self.name)
    }
    var body: some View {
        VStack {
            Text(name)
                .font(.headline)
                .fontWeight(.bold)
            TextField("Enter Text",text: $name)
            .padding(12)
            Button(action : printName) {
                Text("Show name Value")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

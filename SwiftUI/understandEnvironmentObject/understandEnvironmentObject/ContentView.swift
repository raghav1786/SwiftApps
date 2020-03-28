//
//  ContentView.swift
//  understandEnvironmentObject
//
//  Created by RAGHAV SHARMA on 23/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   // @ObservedObject var userSettings = UserSettings()
    @EnvironmentObject var userSettings : UserSettings
    var body: some View {
        VStack {
            Text("\(self.userSettings.score)")
                .font(.title)
            Button("Increment Score") {
                self.userSettings.score += 1
            }
            //FancyScoreView(score:self.$userSettings.score)
            FancyScoreView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserSettings())
    }
}

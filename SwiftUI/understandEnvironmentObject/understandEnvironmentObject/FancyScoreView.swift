//
//  FancyScoreView.swift
//  understandEnvironmentObject
//
//  Created by RAGHAV SHARMA on 23/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import SwiftUI

struct FancyScoreView : View {
  //  @Binding var score : Int
    @EnvironmentObject var userSettings : UserSettings
    var body : some View {
        VStack {
            Text("\(self.userSettings.score)")
            Button("Increement Score") {
                self.userSettings.score += 1
            }.padding().background(Color.green)
            }.padding().background(Color.orange)
    }
}


// environment Object - pass value from child and change parent view accordingly but even works for great great grand Child. no. of heirarchy are there
// used for authentication token or user logged in info etc.
// not used for segue
// used for shopping cart in one view and in another great grand child you are again using shopping cart in that view.
// Similar to Redux - global state.

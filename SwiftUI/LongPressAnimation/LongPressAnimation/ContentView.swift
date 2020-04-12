//
//  ContentView.swift
//  LongPressAnimation
//
//  Created by RAGHAV SHARMA on 12/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI
import ContactTracing

struct ContentView: View {
//   @GestureState var highlight = false
//
//    var body: some View {
//        var longPress: some Gesture {
//            LongPressGesture(minimumDuration: 3)
//                .updating($highlight) { currentstate, gestureState, transaction in
//                    gestureState = currentstate
//                    transaction.animation = Animation.easeInOut(duration: 2.0)
//                }
//        }
//        return  VStack {
//            Text("highlight!")
//            .gesture(longPress)
//        Button("Test") {  }
//            .accentColor(self.highlight ? .green : .none)
//        }
//    }
    @GestureState var highlight = false
       var body: some View {
           var longPress: some Gesture {
               LongPressGesture(minimumDuration: 3)
                   .updating($highlight) { currentstate, gestureState, transaction in
                       transaction.animation = Animation.easeInOut(duration: 2.0)
                       gestureState = currentstate
                   }
           }
           return VStack {
               Text("highlight!")
                   .gesture(longPress)
               Divider()
               Button("Button") { }
                   .font(Font.largeTitle.bold())
                   .foregroundColor(.white)
                   .colorMultiply(self.highlight ? .green : .blue)
            //color multiply should be used instead of accentColor for smooth transitions
            
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  GesturesUnderstanding
//
//  Created by RAGHAV SHARMA on 02/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tapped : Bool = false
    @State private var cradDragState = CGSize.zero
    @State private var cardRotationState: Double = 0
    var body: some View {
        Card(tapped : tapped).edgesIgnoringSafeArea(.all)
            //Drag Gesture
            .animation(.spring())
        .rotationEffect(Angle(degrees: self.cardRotationState))
            .offset(y:self.cradDragState.height)
            .gesture(DragGesture()
                .onChanged { value in
                    self.cradDragState = value.translation
            }
            .onEnded { value in
                self.cradDragState = CGSize.zero
                
                }
        )
            //Magnify Gesture
            //on image in card view
            
            
            //Rotation gesture
            .gesture(RotationGesture()
            .onChanged { value in
                self.cardRotationState = value.degrees
            }        
        )
            
            //Tap Gesture
            .gesture(TapGesture(count: 1)
                .onEnded {
                    () in
                    self.tapped.toggle() 
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

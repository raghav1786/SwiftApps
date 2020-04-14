//
//  Card.swift
//  GesturesUnderstanding
//
//  Created by RAGHAV SHARMA on 02/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct Card: View {
    let tapped : Bool
    @State private var scale = 1
    var body: some View {
        VStack {
            
            Image("cat")
                .resizable()
               // .scaleEffect(self.scale)
                .frame(width: 300, height: 300)
//                .gesture(MagnificationGesture()
//                    .onChanged {value in
//                        self.scale = value.magnitude
//                })
            
            
            
            Text("Cat")
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(.largeTitle)
        }.frame(minWidth : 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
            .background(self.tapped ? Color.purple : Color.pink)
            .cornerRadius(30)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(tapped: true)
    }
}

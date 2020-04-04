//
//  ContentView.swift
//  Postcast-Player
//
//  Created by RAGHAV SHARMA on 23/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let episode = Episode(name: "MacBook Weekly",
                          track : "WWDC 2019")
    @State private var isPlaying : Bool = false
    var body: some View {
        VStack {
            Text(self.episode.name)
                .font(.title)
                .foregroundColor(self.isPlaying ? .green : .black)
            Text(self.episode.track)
                .foregroundColor(.secondary)
            PlayButton(isPlaying: self.$isPlaying)
            
        }
    }
}

struct PlayButton : View {
    @Binding var isPlaying : Bool
    var body: some View {
        Button(action:{
            self.isPlaying.toggle()
        }) {
            Text("Play")
        }
        .padding(12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

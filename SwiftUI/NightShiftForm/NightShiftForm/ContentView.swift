//
//  ContentView.swift
//  NightShiftForm
//
//  Created by RAGHAV SHARMA on 07/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var scheduled : Bool = false
    @State private var manuallyEnable : Bool = false
    @State private var colorTemperature : Float = 0.2
    var body: some View {
        NavigationView {
            Form {
                Section(header:
                    Text("Night shift automatically shift colors Night shift automatically shift colors Night shift automatically shift colors Night shift automatically shift colors")
                        .padding(5)
                        .lineLimit(nil)
                ) {
                    Toggle(isOn: $scheduled) {
                        Text("Scheduled")
                    }
                    HStack {
                        VStack {
                            Text("From")
                            Text("To")
                        }
                        Spacer()
                        NavigationLink(destination: Text("whereitis")) {
                            VStack {
                                Text("Sunset").foregroundColor(.blue)
                                Text("Sunrise").foregroundColor(.blue)
                            }
                        }.fixedSize()
                    }
                }
                
                Section(header: Text("")
                ) {
                    Toggle(isOn: $manuallyEnable) {
                        Text("Manually Enable Until Tommrrow")
                    }
                }
                
                Section(header: Text("color temperature").offset()
                ) {
                    HStack {
                        Text("Less Warm")
                        Slider(value: $colorTemperature)
                        Text("More Warm").offset()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

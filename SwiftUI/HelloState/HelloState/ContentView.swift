//
//  ContentView.swift
//  HelloState
//
//  Created by RAGHAV SHARMA on 22/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
     @State var tasks : [Task] = [Task(name: "Bring Vegies",isImp: true),Task(name: "Buy Milk",isImp : false)]
    @State var isTaskImp : Bool = false
    
    private func addTask() {
       // self.tasks.append(Task(name: "WashTheCar"))
    }
    
    var body: some View {
        VStack {
            Toggle(isOn:$isTaskImp) {
                Text("Importance")
                    .font(.title)
            }
            
            List {
                Button(action: addTask) {
                    Text("Add Task")
                }
                ForEach(tasks.filter{$0.isImp == self.isTaskImp}) { task in
                    HStack {
                        Text(task.name)
                        Spacer()
                        if self.isTaskImp {
                            Image(systemName: "arrow.right")
                            .font(Font.title.weight(.ultraLight))
                        }
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

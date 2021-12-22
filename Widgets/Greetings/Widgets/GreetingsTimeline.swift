//
//  GreetingsTimeline.swift
//  Widgets
//
//  Created by RAGHAV SHARMA on 22/12/21.
//

import Foundation
import WidgetKit
import SwiftUI

struct GreetingsTimeline: TimelineProvider {
    func placeholder(in context: Context) -> GreetingEntryModel {
        Entry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (GreetingEntryModel) -> Void) {
        let entry = Entry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GreetingEntryModel>) -> Void) {
        var entries: [Entry] = []
                let currentDate = Date()
                
                /// widget will be refresh every minute
                
                let refreshTime = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
                
                for hoursOffset in 0..<24 {
                    
                    guard let entryDate = Calendar.current.date(byAdding: .hour, value: hoursOffset, to: currentDate) else {
                        return
                    }
                    let entry = Entry(date: entryDate)
                    entries.append(entry)
                }
                
                let timeLine = Timeline(entries: entries, policy: .after(refreshTime))
                completion(timeLine)
    }
    
    typealias Entry = GreetingEntryModel
    
    
}

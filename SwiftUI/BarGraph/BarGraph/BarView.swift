//
//  BarView.swift
//  BarGraph
//
//  Created by RAGHAV SHARMA on 02/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import SwiftUI

struct BarView : View {
    let report : Report
    @State private var showGraph : Bool = false
    var body: some View {
        let value = report.revenue / 500
        let yValue = Swift.min(value * 20, 500)
        
        return VStack {
            Text(String(format:"%.2f",report.revenue))
            Rectangle()
                .fill(Color.orange)
                .frame(width: 100 , height: self.showGraph ? CGFloat(yValue) : CGFloat (-yValue))
                .onAppear() {
                    withAnimation(.spring()) {
                         self.showGraph = true
                    }
            }
            Text(report.year)
             
        }
    }
}

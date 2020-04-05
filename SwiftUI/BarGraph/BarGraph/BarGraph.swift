//
//  BarGraph.swift
//  BarGraph
//
//  Created by RAGHAV SHARMA on 02/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import SwiftUI

struct BarGraph : View {
    var reports : [Report] = Report.all()
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
//                Rectangle()
//                    .fill(Color.orange)
//                    .frame(width : 100,height: 180)
//                    .padding()
//                Rectangle()
//                    .fill(Color.green)
//                    .frame(width : 100,height: 280)
//                    .padding()
//                Rectangle()
//                    .fill(Color.orange)
//                    .frame(width : 100,height: 380)
//                    .padding()
//                Spacer()
                
                ForEach(reports,id: \.year) { report in
                    BarView(report: report)
                }
            }
        }
    }
}


struct BarGraph_Previews : PreviewProvider {
    static var previews : some View {
        BarGraph()
    }
}



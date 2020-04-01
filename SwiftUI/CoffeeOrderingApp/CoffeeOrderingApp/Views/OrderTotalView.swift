//
//  OrderTotalView.swift
//  COffeeOrderingApp
//
//  Created by RAGHAV SHARMA on 24/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct OrderTotalView: View {
    let total : Double
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Text(String(format:"$%.2f",self.total))
                .font(.title)
                .foregroundColor(.green)
            Spacer()
        }.padding(10)
    }
}

struct OrderTotalView_Previews: PreviewProvider {
    static var previews: some View {
        OrderTotalView(total: 45.67)
    }
}

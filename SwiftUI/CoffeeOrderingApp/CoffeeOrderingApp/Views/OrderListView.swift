//
//  OrderListView.swift
//  COffeeOrderingApp
//
//  Created by RAGHAV SHARMA on 24/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct OrderListView: View {
    let orders : [OrderViewModel]
    
    init(orders : [OrderViewModel]) {
        self.orders = orders
    }
    var body: some View {
        List {
            ForEach(self.orders,id:\.id) { order in
                HStack {
                    Image(order.coffeeName)
                        .resizable()
                        .frame(width:100,height: 100)
                        .cornerRadius(16)
                    VStack {
                        Text(order.name)
                            .font(.title)
                            .padding([.leading,.bottom],10)
                        HStack {
                            Text(order.coffeeName)
                                .padding(10)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                            Text(order.size)
                                .padding(10)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                    }
                }
                
            }
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(orders: [OrderViewModel(order: Order(name: "Mary", size: "Medium", coffeeName: "Regular", total: 3.0))])
    }
}

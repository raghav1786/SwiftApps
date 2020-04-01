//
//  ContentView.swift
//  COffeeOrderingApp
//
//  Created by RAGHAV SHARMA on 23/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private  var orderListVM = OrderListViewModel()
    @State private var showModal : Bool = false
    var body: some View {
        NavigationView {
            OrderListView(orders: self.orderListVM.orders)
                .navigationBarTitle("CoffeeOrders")
                .navigationBarItems(leading: Button(action:reloadOrders){
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.white)
                    },trailing: Button(action:showAddCoffeeOrderView) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                })
                
                .sheet(isPresented:self.$showModal) {
                    AddCoffeeOrderView(isPresented:self.$showModal)
            }
        }
    }
    
    private func reloadOrders() {
        self.orderListVM.fetchOrders()
    }
    
    private func showAddCoffeeOrderView() {
        self.showModal = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

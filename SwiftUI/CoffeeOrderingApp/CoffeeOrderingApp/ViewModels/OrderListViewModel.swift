//
//  OrderListViewModel.swift
//  COffeeOrderingApp
//
//  Created by RAGHAV SHARMA on 23/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation

class OrderListViewModel : ObservableObject {
    @Published var orders = [OrderViewModel]()
    
    init() {
        fetchOrders()
    }
    
    func fetchOrders() {
        OrderManager().getOrders { orders in
            if let orders = orders {
                self.orders = orders.map(OrderViewModel.init)
            }
            
        }
    }
}

class OrderViewModel {
    
    let id = UUID()
    
    var order : Order
    
    init(order: Order) {
        self.order = order
    }
    
    var name : String {
        return self.order.name
    }
    
    var size : String {
        return self.order.size
    }
    
    var coffeeName : String {
        return self.order.coffeeName
    }
    
    var total : Double {
        return self.order.total
    }
}

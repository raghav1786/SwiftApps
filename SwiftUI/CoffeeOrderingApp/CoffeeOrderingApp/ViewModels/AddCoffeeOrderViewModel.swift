//
//  AddCoffeeOrderViewModel.swift
//  COffeeOrderingApp
//
//  Created by RAGHAV SHARMA on 24/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation

class AddCoffeeOrderViewModel : ObservableObject {
    @Published var orderManager : OrderManager
    
    var name : String = ""
    @Published var size : String = "Medium"
    @Published var coffeeName : String = ""
    
    var coffeeList : [CoffeeViewModel] {
        return Coffee.all().map(CoffeeViewModel.init)
    }
    
    var total : Double {
        return calculateTotalPrice()
    }
    
    init() {
        self.orderManager = OrderManager()
    }
    
    func placeOrder() {
        let order = Order(name: self.name, size: self.size, coffeeName: self.coffeeName, total: self.total)
        self.orderManager.createCoffeeOrders(order: order) { _ in
            
        }
    }
    
    private func prizeForSize() -> Double {
        let prices = ["small":2.0,"Medium":3.0,"Large":4.0]
        return prices[self.size] ?? 0.0
    }
    
    private func calculateTotalPrice() -> Double {
        let coffeeVM = coffeeList.first { $0.name == coffeeName }
        if let coffeeVM = coffeeVM {
            return coffeeVM.price * prizeForSize()
        } else {
            return 0.0
        }
    }
}

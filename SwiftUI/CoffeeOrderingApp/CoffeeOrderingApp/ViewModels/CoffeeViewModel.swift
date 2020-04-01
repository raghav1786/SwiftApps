//
//  CoffeeViewModel.swift
//  COffeeOrderingApp
//
//  Created by RAGHAV SHARMA on 24/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation

class CoffeeListViewModel {
    var coffeeList : [CoffeeViewModel] = [CoffeeViewModel]()
}

struct CoffeeViewModel {
    
    let id = UUID()
    
    var coffee : Coffee
    
    init(coffee: Coffee) {
        self.coffee = coffee
    }
    
    var name : String {
        return self.coffee.name
    }
    
    var imageURL : String {
        return self.coffee.imageURL
    }
    
    var price : Double {
        return self.coffee.price
    }
}

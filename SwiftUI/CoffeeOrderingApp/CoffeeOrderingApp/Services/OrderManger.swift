//
//  CoffeeOrderManger.swift
//  COffeeOrderingApp
//
//  Created by RAGHAV SHARMA on 23/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

public class OrderManager {
    let urlString = "https://island-bramble.glitch.me/orders"
    
    
    func createCoffeeOrders(order : Order,completion:@escaping(CreateOrderResponse?) -> ()) {
        guard let url = URL(string: urlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(order)
        
        URLSession.shared.dataTask(with: urlRequest) { data,response,error in
            guard let data = data,error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
             let createOrderResponse = try? JSONDecoder().decode(CreateOrderResponse.self, from: data)
            DispatchQueue.main.async {
                completion(createOrderResponse)
            }
            
        }.resume()
        
    }
    
    func getOrders(completion: @escaping ([Order]?) -> ()) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                } else {
                    if let safeData = data {
                        if let  coffeeOrders = self.parseJson(data: safeData) {
                            DispatchQueue.main.async {
                                completion(coffeeOrders)
                            }
                        }
                    }
                    
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
        
    }
    
    func parseJson(data : Data) -> [Order]? {
        var orders : [Order] = []
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode([Order].self, from: data)
            for coffeeOrder in decodedData {
                orders.append(Order(name: coffeeOrder.name, size: coffeeOrder.size, coffeeName: coffeeOrder.coffeeName, total: coffeeOrder.total))
            }
            return orders
            
        } catch {
            print("Unable to parse json :\(error)")
            return nil
        }
        
    }
}

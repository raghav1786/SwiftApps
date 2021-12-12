//
//  Network.swift
//  UserInfoGraphQL
//
//  Created by RAGHAV SHARMA on 12/12/21.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "http://0.0.0.0:8080/v1/graphql")!)
}


//
//  LoginViewModel.swift
//  UserInfoGraphQL
//
//  Created by RAGHAV SHARMA on 12/12/21.
//

import Foundation

class LoginViewModel: ObservableObject{
    
    func login(username: String, password: String){
        Network.shared.apollo.fetch(query: LogInQuery(username: username, password: password)){
            result in
            switch result {
            case .success(let graphQLResult):
                print("Success! Result: \(graphQLResult.data?.user[0].id)")
            case .failure(let error):
              print("Failure! Error: \(error)")
            }
        }
    }
    
}

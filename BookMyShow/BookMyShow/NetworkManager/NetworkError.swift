//
//  NetworkError.swift
//  BookMyShow
//
//  Created by RAGHAV SHARMA on 26/09/21.
//

import Foundation
enum NetworkError: Error {
    case invlaidURL
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invlaidURL:
            return "This URL is Invalid"
        }
    }
}

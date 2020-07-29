//
//  DogFetchManager.swift
//  Dogify
//
//  Created by RAGHAV SHARMA on 23/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

class DogBreedFetchManager {
    let listAllBreeds = "https://dog.ceo/api/breeds/list/all"
    func fetchAllBreeds(completion : @escaping([String]?,Error?) -> ()) {
        guard let url = URL(string: listAllBreeds) else {return}
        performRequest(url: url, isImageApi: false) { (dogData,error) in
            if error == nil,let dogData = dogData as? Breeds?,let message = dogData?.message {
                var breeds = [String]()
                for (_,value) in message.keys.enumerated() {
                    breeds.append(value)
                }
                completion(breeds,nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    func getBreedImages(breedName : String,completion : @escaping([String]?,Error?) -> ()) {
        let imagesForBreeds = "https://dog.ceo/api/breed/\(breedName)/images"
        guard let url = URL(string: imagesForBreeds) else {return}
        performRequest(url: url, isImageApi: true) { (dogData,error) in
            if error == nil,let dogData = dogData as? BreedImages?,let message = dogData?.message {
                completion(message,nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    func performRequest(url : URL,isImageApi : Bool,completion : @escaping(Any?,Error?) -> ()) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data,response,error) in
            if let error = error {
                completion(nil,error)
            }
            if let safeData = data {
                let items = self.parseJson(safeData, isImageApi)
                completion(items, nil)
            }
        }
        task.resume()
    }
    
    func parseJson(_ data: Data,_ isImageApi : Bool) -> Any? {
        let decoder = JSONDecoder()
        do {
            if isImageApi {
                let dogImageData = try decoder.decode(BreedImages.self, from: data)
                return BreedImages(message: dogImageData.message, status: dogImageData.status)
            } else {
                let dogData = try decoder.decode(Breeds.self, from: data)
                return Breeds(message: dogData.message, status: dogData.status)
            }
        } catch {
            print("Unable to parse json :\(error)")
            return nil
        }
    }
}

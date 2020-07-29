//
//  ListAllBreedsVM.swift
//  Dogify
//
//  Created by RAGHAV SHARMA on 23/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
class ListAllBreedsVM {
    var dogBreedFetchManager = DogBreedFetchManager()
    var listOfBreeds : [String]?
}

extension ListAllBreedsVM {
    func getDogData(compeletion : @escaping(Bool) -> ()) {
        self.dogBreedFetchManager.fetchAllBreeds { [weak self] (data,error) in
            DispatchQueue.main.async {
                self!.listOfBreeds = data
                compeletion(true)
            }
        }
    }
}

//
//  AllImagesForBreedVM.swift
//  Dogify
//
//  Created by RAGHAV SHARMA on 25/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import Foundation
class AllImagesForBreedVM {
    var dogBreedFetchManager = DogBreedFetchManager()
    var imagesOfBreed : [String]?
    var breedName : String?
}

extension AllImagesForBreedVM {
    func getBreedImageList(compeletion : @escaping(Bool) -> ()) {
        self.dogBreedFetchManager.getBreedImages(breedName : breedName ?? "") { [weak self] (data,error) in
            DispatchQueue.main.async {
                self!.imagesOfBreed = data
                compeletion(true)
            }
        }
    }
}

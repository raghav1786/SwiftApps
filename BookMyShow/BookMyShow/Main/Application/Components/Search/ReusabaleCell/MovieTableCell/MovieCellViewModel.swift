//
//  MovieCellViewModel.swift
//  BookMyShow
//
//  Created by Neeraj Solanki on 10/10/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit
class MovieCellViewModel: NSObject {
    
    private var movieModel:Movie?
    
    init(movie:Movie) {
        super.init()
        movieModel = movie
    }
    
    var movieID: Int64 {
        return movieModel?.id ?? 0
    }
    
    var movieTitle:String {
        return movieModel?.title ?? "Untitled"
    }
    
    var releaseDate:String{
        return movieModel?.release_date ?? "Updating Soon"
    }
    
    var movieImage: String {
        return movieModel?.movieImage ?? ""
    }
    
    var genre:String {
        var genreArray:[String] = []
        for genreId in movieModel?.genre ?? [] {
            
            if genreArray.count < 1 {
                genreArray.append(contentsOf: GenreModel.shared.genreTypes.filter { $0.id == genreId }.map { $0.name })
            }
            else if genreArray.count < 3
            {
             genreArray.append(contentsOf: GenreModel.shared.genreTypes.filter { $0.id == genreId }.map { " \(StaticData.bulletSymbol) " + $0.name })
            }
            else{
                return genreArray.joined()
            }
        }
        
        return genreArray.joined()
    }
    
}

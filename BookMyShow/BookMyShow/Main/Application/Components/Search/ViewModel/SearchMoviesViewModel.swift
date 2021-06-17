import Foundation
import UIKit

class SearchMoviesViewModel {
    var moviesRepository = MoviesRepository()
    var movieList : [Movie]?
    var movieListFromApi : [Movie]?
    var isSearchBarHighlited = false
    
    var items:[Movie] {
        // If searrchbar is highlighted return filtered movies ootherwise return recent search
        if !isSearchBarHighlited && RecentSearchDataManager.shared.getRecentSearch().count > 0 {
            return RecentSearchDataManager.shared.getRecentSearch()
        }
        else
        {
            return movieList ?? []
        }
        
    }
    
    private var searchValue:String = ""
    func updateSearch(text:String,compeletion : @escaping(Bool) -> ()) {
        searchValue = text
        searchAlgo(compeletion : compeletion)
    }
    
    var headerHeight: Int {
        if !isSearchBarHighlited  {
            return 60
        }
        return 0
    }
    
    func getMovieList(compeletion : @escaping(Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.moviesRepository.getMovieList() { movies,error in
                DispatchQueue.main.async {
                    if let movieList = movies {
                        strongSelf.movieListFromApi = movieList
                        strongSelf.movieList = movieList
                        compeletion(true)
                    } else {
                        compeletion(false)
                    }
                }
            }
        }
    }
    
    //Search Algorithm
    private func searchAlgo(compeletion : @escaping(Bool) -> ()) {
        let searchTextArray = searchValue.split(separator: " ")
        movieList = movieListFromApi?.filter({ (movie) -> Bool in
            let movieNameArr = (movie.title ?? "").split(separator: " ")
            for searchWord in searchTextArray
            {
                var isMatch = false
                for word in movieNameArr
                {
                    if word.prefix(searchWord.count).lowercased() == searchWord.lowercased() { isMatch = true; break}
                }
                if !isMatch {
                    return false
                }
            }
            return true
        })
        compeletion(true)
    }
}

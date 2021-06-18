class SearchMoviesViewModel {
    // MARK: Stored Properties
    private var searchValue:String = ""
    
    var movieList : [Movie]?
    var movieListFromApi : [Movie]?
    var isSearchBarHighlited = false
    
    // MARK: Computed Properties
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
    
    var headerHeight: Int {
        if !isSearchBarHighlited  {
            return 60
        }
        return 0
    }
    
    func updateSearch(text:String,compeletion : @escaping(Bool) -> ()) {
        searchValue = text
        searchAlgo(compeletion : compeletion)
    }
    
    // MARK: Search Algorithms
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

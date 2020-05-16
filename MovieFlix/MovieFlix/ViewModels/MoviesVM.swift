
import Foundation

class MoviesVM {
    var apiRequestManager = ApiRequestManager.shared
    var movieList : [Movie]?
    var topRatedMovies : [Movie]?
    
    func getMovieList(_ isNowPlaying: Bool,compeletion : @escaping(Bool) -> ()) {
        self.apiRequestManager.fetchMoviesList(isNowPlaying) { (movieList) in
            DispatchQueue.main.async {
                if let movieList = movieList {
                    if isNowPlaying {
                        self.movieList = movieList
                    } else {
                        self.topRatedMovies = movieList
                    }
                    compeletion(true)
                } else {
                    compeletion(false)
                }
                
            }
        }
    }
}

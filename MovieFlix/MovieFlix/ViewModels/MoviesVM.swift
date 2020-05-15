
import Foundation

class MoviesVM {
    var apiRequestManager = ApiRequestManager.shared
    var movieList : [Movie]?
    
    func getMovieList(_ isNowPlaying: Bool,compeletion : @escaping(Bool) -> ()) {
        self.apiRequestManager.fetchMoviesList(isNowPlaying) { (movieList) in
            DispatchQueue.main.async {
                if let movieList = movieList {
                    self.movieList = movieList
                    compeletion(true)
                } else {
                    compeletion(false)
                }
                
            }
        }
    }
}

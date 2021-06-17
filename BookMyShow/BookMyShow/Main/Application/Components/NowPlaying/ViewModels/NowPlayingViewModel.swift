
import Foundation

class NowPlayingViewModel {
    var moviesRepository = MoviesRepository()
    var movieList : [Movie]?
    
    func getMovieList(compeletion : @escaping(Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.moviesRepository.getMovieList() { movies,error in
                DispatchQueue.main.async {
                    if let movieList = movies {
                        strongSelf.movieList = movieList
                        compeletion(true)
                    } else {
                        compeletion(false)
                    }
                }
            }
        }
    }
}

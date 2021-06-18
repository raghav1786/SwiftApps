import Foundation
class SimilarMoviesViewModel {
    private var moviesRepository = MoviesRepository()
    var movieList : [Movie]?
    var selectedMovieID: Int64?
    
    func getSimilarMovieList(completion : @escaping(Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            guard let selectedMovieID = strongSelf.selectedMovieID
            else { return }
            strongSelf.moviesRepository.getSimilarMovieList(movieID: selectedMovieID) { movies,error in
                DispatchQueue.main.async {
                    if let movieList = movies {
                        strongSelf.movieList = movieList
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
}

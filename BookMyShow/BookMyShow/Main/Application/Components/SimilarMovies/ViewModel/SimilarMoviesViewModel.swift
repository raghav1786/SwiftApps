import Foundation
class SimilarMoviesViewModel {
    private var moviesRepository = MoviesRepository()
    var movieList : [Movie]?
    var selectedMovie: Movie?
    
    func getSimilarMovieList(completion : @escaping(Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            guard let selectedMovieID = strongSelf.selectedMovie?.id
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

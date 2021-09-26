import Foundation
import Combine

class SimilarMoviesViewModel {
    private var moviesRepository = MoviesRepository()
    var movieList : [Movie]?
    var selectedMovie: Movie?
    var token = [AnyCancellable]()
    
    func getSimilarMovieList() -> Future<Bool,Never> {
        return Future {[weak self] promise in
            guard let strongSelf = self else {
                promise(.success(false))
                return
            }
            guard let selectedMovieID = strongSelf.selectedMovie?.id else {
                promise(.success(false))
                return
            }
            strongSelf.moviesRepository.getSimilarMovieList(movieID: selectedMovieID).sink { completion in
                switch completion {
                case .finished: ()
                case .failure(_):
                    promise(.success(false))
                }
            } receiveValue: { movies in
                if let movieList = movies {
                    strongSelf.movieList = movieList
                    promise(.success(true))
                }
            }.store(in: &strongSelf.token)
        }
    }
}

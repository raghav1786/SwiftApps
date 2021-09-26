import Foundation
import Combine

class NowPlayingViewModel {
    
    private var moviesRepository = MoviesRepository()
    var movieList : [Movie]?
    var token = [AnyCancellable]()
    
    func getMovieList() -> Future<Bool,Never> {
        return Future {[weak self] promise in
            guard let strongSelf = self else {
                promise(.success(false))
                return
            }
            strongSelf.moviesRepository.getMovieList().sink { completion in
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

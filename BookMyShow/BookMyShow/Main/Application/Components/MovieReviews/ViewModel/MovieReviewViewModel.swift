import Foundation
import Combine

class MovieReviewViewModel {
    private var movieReviewsRepository = MovieReviewsRepository()
    var movie: Movie?
    var reviews : [MovieReview]?
    var token = [AnyCancellable]()
    
    func getMovieReviews() -> Future<Bool,Never> {
        return Future {[weak self] promise in
            guard let strongSelf = self else {
                promise(.success(false))
                return
            }
            guard let movieId = strongSelf.movie?.id else {
                promise(.success(false))
                return
            }
            strongSelf.movieReviewsRepository.getMovieReviewList(movieID: movieId).sink { completion in
                switch completion {
                case .finished: ()
                case .failure(_):
                    promise(.success(false))
                }
            } receiveValue: { reviews in
                if let movieListReviews = reviews {
                    strongSelf.reviews = movieListReviews
                    promise(.success(true))
                }
            }
            .store(in: &strongSelf.token)
            
        }
    }
}

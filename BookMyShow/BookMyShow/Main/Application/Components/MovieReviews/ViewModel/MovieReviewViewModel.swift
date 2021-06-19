import Foundation
class MovieReviewViewModel {
    private var movieReviewsRepository = MovieReviewsRepository()
    var movie: Movie?
    var reviews : [MovieReview]?
    
    func getMovieReviews(completion : @escaping(Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else {
                completion(false)
                return
            }
            guard let movieId = strongSelf.movie?.id else {
                completion(false)
                return
            }
            strongSelf.movieReviewsRepository.getMovieReviewList(movieID: movieId) { movies,error in
                DispatchQueue.main.async {
                    if let movieList = movies {
                        strongSelf.reviews = movieList
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
}

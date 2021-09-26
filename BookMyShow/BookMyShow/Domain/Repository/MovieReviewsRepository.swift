import Combine

class MovieReviewsRepository {
    let reviewsService = ReviewsService()
    
    func getMovieReviewList(movieID: Int64) -> Future<[MovieReview]?,Error> {
        reviewsService.getMovieReviewList(movieID: movieID)
    }
}

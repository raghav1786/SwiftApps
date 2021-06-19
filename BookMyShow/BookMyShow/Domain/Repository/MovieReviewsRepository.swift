class MovieReviewsRepository {
    let reviewsService = ReviewsService()
    
    func getMovieReviewList(movieID: Int64,
                             completion : @escaping([MovieReview]?,Error?) -> ()) {
        reviewsService.getMovieReviewList(movieID: movieID,
                                          completion: completion)
    }
}

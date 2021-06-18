class MoviesRepository {
    let movieListService = MovieListService()
    func getMovieList(completion : @escaping([Movie]?,Error?) -> ()) {
        movieListService.getMovieList(completion: completion)
    }
    
    func getSimilarMovieList(movieID: Int64,
                             completion : @escaping([Movie]?,Error?) -> ()) {
        movieListService.getSimilarMovieList(movieID: movieID,
                                             completion: completion)
    }
}

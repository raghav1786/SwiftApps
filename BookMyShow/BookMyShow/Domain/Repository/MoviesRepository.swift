class MoviesRepository {
    let movieListService = MovieListService()
    func getMovieList(completion : @escaping([Movie]?,Error?) -> ()) {
        movieListService.getMovieList(completion: completion)
    }
}

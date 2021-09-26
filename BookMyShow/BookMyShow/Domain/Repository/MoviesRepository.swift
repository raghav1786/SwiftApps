import Combine

class MoviesRepository {
    let movieListService = MovieListService()
    func getMovieList() -> Future<[Movie]?,Error> {
        movieListService.getMovieList()
    }
    
    func getSimilarMovieList(movieID: Int64) -> Future<[Movie]?,Error> {
        movieListService.getSimilarMovieList(movieID: movieID)
    }
}

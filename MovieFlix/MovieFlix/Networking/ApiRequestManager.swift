
import Foundation
import Alamofire

public class ApiRequestManager {
    static let shared = ApiRequestManager()
    let params = [
        ApiKey.parameterName:ApiKey.value,
    ]
    private init() {}
    func fetchMoviesList(_ isNowPlaying: Bool,
                         compeletion : @escaping([Movie]?) -> ()) {
        let movieListType = isNowPlaying ? MovieListApi.nowPlayingApi.rawValue : MovieListApi.topRatedApi.rawValue
        let finalURL = Constants.baseURL + movieListType
        fetchDataForApi(finalURL) { movieList in
            compeletion(movieList)
        }
    }
    
    func fetchDataForApi(_ finalURL: String,
                         compeletion : @escaping([Movie]?) -> ()) {
        AF.request(finalURL,parameters: params).responseDecodable(of: MovieList.self) { (response) in
            guard let movieList = response.value?.results else {
                compeletion(nil)
                return
            }
            compeletion(movieList)
        }
    }
}

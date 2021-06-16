import Foundation
protocol MovieListServicesProtocol {
    func getMovieList(completion : @escaping([Movie]?,Error?) -> ())
}

class MovieListService {
}
extension MovieListService: MovieListServicesProtocol {
    
    func getMovieList(completion : @escaping([Movie]?,Error?) -> ()) {
        let finalURL = Constants.baseURL + MovieListApi.nowPlayingApi.rawValue + ApiKey.queryParamter + ApiKey.value
        NetworkManager.shared.fetchDataForApi(finalURL) { data, error in
            if let error = error {
                completion(nil,error)
            }
            if let result = data as? Data{
                completion(self.parseMovieData(result),nil)
            }
        }
    }
    
    private func parseMovieData(_ data: Data) -> [Movie]? {
        let decoder = JSONDecoder()
        do {
            let movieList = try decoder.decode(MovieList.self, from: data)
            return movieList.results
        } catch {
            print("Unable to parse json :\(error)")
            return nil
        }
    }
}


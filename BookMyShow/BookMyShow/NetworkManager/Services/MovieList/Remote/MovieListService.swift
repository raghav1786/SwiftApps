import Foundation
import Combine

protocol MovieListServicesProtocol {
    func getMovieList() -> Future<[Movie]?,Error>
    func getSimilarMovieList(movieID: Int64) -> Future<[Movie]?,Error>
}

class MovieListService {
    var token = [AnyCancellable]()
}
extension MovieListService: MovieListServicesProtocol {
    
    func getMovieList() -> Future<[Movie]?,Error>  {
        return Future { promise in
            let finalURL = Constants.baseURL + MovieListApi.nowPlayingApi.rawValue + ApiKey.queryParamter + ApiKey.value
            NetworkManager.shared.fetchDataForApi(finalURL).sink { completion in
                switch completion {
                case .failure(let error):
                    promise(.failure(error))
                case .finished: ()
                }
            } receiveValue: { data in
                if let result = data as? Data{
                    promise(.success(self.parseMovieData(result)))
                }
            }.store(in: &self.token)
        }
    }
    
    func getSimilarMovieList(movieID: Int64) -> Future<[Movie]?,Error> {
        return Future { promise in
            let finalURL = Constants.baseURL + "/\(movieID)" + Constants.similarMoviesURL + ApiKey.queryParamter + ApiKey.value
            NetworkManager.shared.fetchDataForApi(finalURL).sink { completion in
                switch completion {
                case .failure(let error):
                    promise(.failure(error))
                case .finished: ()
                }
            } receiveValue: { data in
                if let result = data as? Data{
                    promise(.success(self.parseMovieData(result)))
                }
            }.store(in: &self.token)
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


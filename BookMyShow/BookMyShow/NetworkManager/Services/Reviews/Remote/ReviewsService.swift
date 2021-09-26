import Foundation
import Combine
protocol ReviewsServiceProtocol {
    func getMovieReviewList(movieID: Int64) -> Future<[MovieReview]?,Error>
}

class ReviewsService {
    var token = [AnyCancellable]()
}
extension ReviewsService: ReviewsServiceProtocol {
    
    func getMovieReviewList(movieID: Int64) -> Future<[MovieReview]?,Error> {
        return Future { promise in
            let finalURL = Constants.baseURL + "/\(movieID)" + Constants.moviesReviewsURL + ApiKey.queryParamter + ApiKey.value
            NetworkManager.shared.fetchDataForApi(finalURL).sink { completion in
                switch completion {
                case .failure(let error):
                    promise(.failure(error))
                case .finished: ()
                }
            } receiveValue: { data in
                if let result = data as? Data{
                    promise(.success(self.parseMovieReviews(result)))
                }
            }.store(in: &self.token)
        }
    }
    
    private func parseMovieReviews(_ data: Data) -> [MovieReview]? {
        let decoder = JSONDecoder()
        do {
            let reviews = try decoder.decode(MovieReviewResults.self, from: data)
            return reviews.results
        } catch {
            print("Unable to parse json :\(error)")
            return nil
        }
    }
}


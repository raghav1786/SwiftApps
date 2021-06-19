import Foundation
protocol ReviewsServiceProtocol {
    func getMovieReviewList(movieID: Int64, completion : @escaping([MovieReview]?,Error?) -> ())
}

class ReviewsService {
}
extension ReviewsService: ReviewsServiceProtocol {
    
    func getMovieReviewList(movieID: Int64, completion : @escaping([MovieReview]?,Error?) -> ()) {
        let finalURL = Constants.baseURL + "/\(movieID)" + Constants.moviesReviewsURL + ApiKey.queryParamter + ApiKey.value
        NetworkManager.shared.fetchDataForApi(finalURL) { data, error in
            if let error = error {
                completion(nil,error)
            }
            if let result = data as? Data{
                completion(self.parseMovieReviews(result),nil)
            }
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



import Foundation
struct Constants {
    static let baseURL = "https://api.themoviedb.org/3/movie"
    static let imageBaseURL = "http://image.tmdb.org/t/p/w500"
    static let movieCellIdentifier = "MovieCollectionViewCell"
    static let activityIndicatorString = "Loading Movies..."
}

struct ApiKey {
    static let value =  "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let parameterName = "api_key"
    static let queryParamter = "?api_key="
}

struct BounceEffect {
    static let key = "position"
    static let keyPath = "position.y"
}

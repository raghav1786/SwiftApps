
import Foundation
struct Constants {
    static let baseURL = "https://api.themoviedb.org/3/movie"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    static let movieCellIdentifier = "MovieCollectionViewCell"
    static let movieTableCellIdentifier = "MovieTableCell"
    static let movieSearchHeaderCellIdentifier = "SearchHeaderView"
    static let activityIndicatorString = "Loading Movies..."
}

struct ApiKey {
    static let value =  "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let parameterName = "api_key"
    static let queryParamter = "?api_key="
    static let apiErrorTitle = "Api Call Unsuccessful"
    static let apiErrorMessage = "A server with the specified hostname could not be found"
    static let okayBtnTitle = "Ok"
    static let retryBtn = "Retry"
}

struct BounceEffect {
    static let key = "position"
    static let keyPath = "position.y"
}

struct StaticData {
    static let recentSearchLimit = 5
    static let bulletSymbol = "•"
    static let genreString = """
    [
            {
                "id" : 28,
                "name": "Action"
              },
              {
                "id": 12,
                "name": "Adventure"
              },
              {
                "id": 16,
                "name": "Animation"
              },
              {
                "id": 35,
                "name": "Comedy"
              },
              {
                "id": 80,
                "name": "Crime"
              },
              {
                "id": 99,
                "name": "Documentary"
              },
              {
                "id": 18,
                "name": "Drama"
              },
              {
                "id": 10751,
                "name": "Family"
              },
              {
                "id": 14,
                "name": "Fantasy"
              },
              {
                "id": 36,
                "name": "History"
              },
              {
                "id": 27,
                "name": "Horror"
              },
              {
                "id": 10402,
                "name": "Music"
              },
              {
                "id": 9648,
                "name": "Mystery"
              },
              {
                "id": 10749,
                "name": "Romance"
              },
              {
                "id": 878,
                "name": "Science Fiction"
              },
              {
                "id": 10770,
                "name": "TV Movie"
              },
              {
                "id": 53,
                "name": "Thriller"
              },
              {
                "id": 10752,
                "name": "War"
              },
              {
                "id" : 37,
                "name": "Western"
              }
            ]
"""
}

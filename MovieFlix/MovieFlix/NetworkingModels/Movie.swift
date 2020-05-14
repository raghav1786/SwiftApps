
import Foundation

struct Movie: Decodable,Hashable {
    let popularity: Double?
    let vote_count: Double?
    let video: Bool?
    let movieImage: String?
    let id: Int64?
    let adult: Bool?
    let backDropImage: String?
    let language : String?
    let original_title : String?
    let genre : [Int]?
    let title : String?
    let vote_average : Double?
    let overview : String?
    let release_date : String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case vote_count
        case video
        case movieImage = "poster_path"
        case id
        case adult
        case backDropImage = "backdrop_path"
        case language = "original_language"
        case original_title
        case genre = "genre_ids"
        case title
        case vote_average
        case overview
        case release_date
    }
}

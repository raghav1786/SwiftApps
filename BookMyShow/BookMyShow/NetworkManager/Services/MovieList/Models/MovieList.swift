
import Foundation

struct MovieList : Decodable {
    let results : [Movie]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

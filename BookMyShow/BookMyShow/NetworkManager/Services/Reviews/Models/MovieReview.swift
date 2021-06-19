import Foundation
struct MovieReview: Decodable {
    let author: String?
    let content: String?
    let created_at: String?
    let author_details: AuthorDetails?
}

struct AuthorDetails: Decodable {
    let avatar_path: String?
}

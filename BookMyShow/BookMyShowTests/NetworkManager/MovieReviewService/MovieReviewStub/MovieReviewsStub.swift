import Foundation
import XCTest
@testable import BookMyShow

struct MovieReviewsStub {
    static func getMovieReviewsData() -> MovieReview {
        return MovieReview(author: "Raghav Sharma",
                           content: "It is realy nice movie",
                           created_at: "20/21/2021R",
                           author_details: AuthorDetails(avatar_path: "Path"))
    }
}

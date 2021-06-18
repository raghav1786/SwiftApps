import Foundation
import XCTest
@testable import BookMyShow

struct MovieStub {
    static func getMovieData() -> Movie {
        return Movie(popularity: 12,
                     vote_count: 12,
                     video: true,
                     movieImage: "https://fakeImage.com",
                     id: 1,
                     adult: true,
                     backDropImage: "https://fakeBackDropImage.com",
                     language: "english",
                     original_title: "MadMen",
                     genre: [1,2,3],
                     title: "MadMen",
                     vote_average: 12,
                     overview: "ManMen is good company",
                     release_date: "12/20/2021")
    }
}

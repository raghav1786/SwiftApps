import Foundation
import XCTest
@testable import BookMyShow

class MovieDetailsTestsTests: XCTestCase {
    var viewModel: MovieDetailsViewModel?
    override func setUpWithError() throws {
        viewModel = MovieDetailsViewModel(movie: MovieStub.getMovieData())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testAdult() throws {
        XCTAssertEqual(viewModel?.movie?.adult, true)
    }
    func testTitle() throws {
        XCTAssertEqual(viewModel?.movie?.title, "MadMen")
    }
    func testOrignalTitle() throws {
        XCTAssertEqual(viewModel?.movie?.original_title, "MadMen")
    }
    func testOverview() throws {
        XCTAssertEqual(viewModel?.movie?.overview, "ManMen is good company")
    }
    
    func testReleaseDate() throws {
        XCTAssertEqual(viewModel?.movie?.release_date, "12/20/2021")
    }
}

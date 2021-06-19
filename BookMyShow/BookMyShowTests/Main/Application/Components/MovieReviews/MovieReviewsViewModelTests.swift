import Foundation
import XCTest
@testable import BookMyShow

class MovieReviewsViewModelTests: XCTestCase {
    var viewModel: MovieReviewViewModel?
    override func setUpWithError() throws {
        viewModel = MovieReviewViewModel()
        viewModel?.reviews = [MovieReviewsStub.getMovieReviewsData()]
        viewModel?.movie = MovieStub.getMovieData()
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
    
    func testMoviesReviewsAlgorithm() throws {
        let moviesExpectation = expectation(description: "moviesreviews")
        var isSuccessResponse: Bool?
        viewModel?.getMovieReviews() { isSuccess in
            isSuccessResponse = isSuccess
            moviesExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(isSuccessResponse)
        }
    }
}

import Foundation
import XCTest
@testable import BookMyShow

class SimilarMoviesViewModelTests: XCTestCase {
    var viewModel: SimilarMoviesViewModel?
    override func setUpWithError() throws {
        viewModel = SimilarMoviesViewModel()
        viewModel?.selectedMovieID = 337404
        viewModel?.movieList = [MovieStub.getMovieData()]
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testMovieList() throws {(
        XCTAssertEqual(viewModel?.movieList, [MovieStub.getMovieData()]))
    }
    
    func testMovieListApi() throws {
        let moviesExpectation = expectation(description: "similar movies")
        var isSuccessResponse: Bool?
        viewModel?.getSimilarMovieList() { isSuccess in
            isSuccessResponse = isSuccess
            moviesExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(isSuccessResponse)
        }
    }
}

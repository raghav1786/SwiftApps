import Foundation
import XCTest
@testable import BookMyShow

class NowPlayingViewModelTests: XCTestCase {
    var viewModel: NowPlayingViewModel?
    override func setUpWithError() throws {
        viewModel = NowPlayingViewModel()
        viewModel?.movieList = [MovieStub.getMovieData()]
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testAdult() throws {(
        XCTAssertEqual(viewModel?.movieList, [MovieStub.getMovieData()]))
    }
    
    func testMovieListApi() throws {
        let moviesExpectation = expectation(description: "movies")
        var isSuccessResponse: Bool?
        viewModel?.getMovieList { isSuccess in
            isSuccessResponse = isSuccess
            moviesExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(isSuccessResponse)
        }
    }
}

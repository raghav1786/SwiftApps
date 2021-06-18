import Foundation
import XCTest
@testable import BookMyShow

class SearchMoviesViewModelTests: XCTestCase {
    var viewModel: SearchMoviesViewModel?
    override func setUpWithError() throws {
        viewModel = SearchMoviesViewModel()
        viewModel?.movieList = [MovieStub.getMovieData()]
        viewModel?.movieListFromApi = [MovieStub.getMovieData()]
        viewModel?.isSearchBarHighlited = false
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testAdult() throws {
        XCTAssertEqual(viewModel?.movieList?.first?.adult, true)
    }
    func testTitle() throws {
        XCTAssertEqual(viewModel?.movieList?.first?.title, "MadMen")
    }
    func testOrignalTitle() throws {
        XCTAssertEqual(viewModel?.movieList?.first?.original_title, "MadMen")
    }
    func testOverview() throws {
        XCTAssertEqual(viewModel?.movieList?.first?.overview, "ManMen is good company")
    }
    
    func testReleaseDate() throws {
        XCTAssertEqual(viewModel?.movieList?.first?.release_date, "12/20/2021")
    }
    func testHeaderHeight() throws {
        XCTAssertEqual(viewModel?.headerHeight, 60)
    }
    
    func testHeaderHeightWithSearchHeaderNotThere() throws {
        viewModel?.isSearchBarHighlited = true
        XCTAssertEqual(viewModel?.headerHeight, 0)
    }
    
    func testItems() throws {
        XCTAssertEqual(viewModel?.items, [MovieStub.getMovieData()])
    }
    
    func testSearchBarHighlighted() throws {
        XCTAssertEqual(viewModel?.isSearchBarHighlited, false)
    }
    
    func testSearchBarAlgorithm() throws {
        let moviesExpectation = expectation(description: "movies")
        var isSuccessResponse: Bool?
        viewModel?.updateSearch(text: "MadMen") { isSuccess in
            isSuccessResponse = isSuccess
            moviesExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(isSuccessResponse)
        }
    }

    
    func testRecentSearchManager() throws {
        viewModel?.isSearchBarHighlited = false
        RecentSearchDataManager.shared.updateRecentSearch(newSearch: MovieStub.getMovieData())
        XCTAssertEqual(viewModel?.items, [MovieStub.getMovieData()])
        XCTAssertEqual(RecentSearchDataManager.shared.getRecentSearch(), [MovieStub.getMovieData()])
        
    }
}

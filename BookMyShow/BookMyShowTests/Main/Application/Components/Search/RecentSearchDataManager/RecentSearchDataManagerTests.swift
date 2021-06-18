import Foundation
import XCTest
@testable import BookMyShow

class RecentSearchDataManagerTests: XCTestCase {
    var dataManager: RecentSearchDataManager?
    override func setUpWithError() throws {
        dataManager = RecentSearchDataManager.shared
        dataManager?.updateRecentSearch(newSearch: MovieStub.getMovieData())
    }

    override func tearDownWithError() throws {
        dataManager = nil
    }

    func testRecentSearchManager() throws {
        XCTAssertEqual(dataManager?.getRecentSearch(), [MovieStub.getMovieData()])
        testSameMovie()
        testMaxMovieInRecentSearch()
    }
    
    func testSameMovie() {
        dataManager?.updateRecentSearch(newSearch: MovieStub.getMovieData())
    }
    
    func testMaxMovieInRecentSearch() {
        dataManager?.updateRecentSearch(newSearch: MovieStub.getMovieData())
        dataManager?.updateRecentSearch(newSearch: MovieStub.getMovieData())
        dataManager?.updateRecentSearch(newSearch: MovieStub.getMovieData())
        dataManager?.updateRecentSearch(newSearch: MovieStub.getMovieData())
        dataManager?.updateRecentSearch(newSearch: MovieStub.getMovieData())
    }
}

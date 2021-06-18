import Foundation
import XCTest
@testable import BookMyShow

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager?
    override func setUpWithError() throws {
        networkManager = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }

    func testNetworkCall() throws {
        let moviesExpectation = expectation(description: "movies")
        var response: Any?
        let finalURL = Constants.baseURL + MovieListApi.nowPlayingApi.rawValue + ApiKey.queryParamter + ApiKey.value
        networkManager?.fetchDataForApi(finalURL) { (movies, error) in
            response = movies
            moviesExpectation.fulfill()
          }
          waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(response)
          }
    }
}

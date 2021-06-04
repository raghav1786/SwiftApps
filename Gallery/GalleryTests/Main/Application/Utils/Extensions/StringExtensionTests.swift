import Foundation
import XCTest
@testable import Gallery

class StringExtensionTests: XCTestCase {
    var testString: String?
    override func setUpWithError() throws {
        testString = "test data"
    }

    override func tearDownWithError() throws {
        testString = nil
    }

    func testTitleMessage() throws {
        guard let title = testString?.capitalizingFirstLetter()  else { return }
        XCTAssertEqual(title,"Test data")
        
    }
}


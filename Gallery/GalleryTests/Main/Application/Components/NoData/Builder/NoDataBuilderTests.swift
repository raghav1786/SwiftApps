import Foundation
import XCTest
@testable import Gallery

class NoDataBuilderTests: XCTestCase {
    var view: ComponentView?
    override func setUpWithError() throws {
        view = NoDataBuilder().buildNoDataModule(noDataModel: NoDataUIModel(titleMessage: "titleMessage"))
    }

    override func tearDownWithError() throws {
        view = nil
    }

    func testViewController() throws {
        XCTAssertNotNil(view?.view)
        
    }
}

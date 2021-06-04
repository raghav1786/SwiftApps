import Foundation
import XCTest
@testable import Gallery

class NoDataInteractorTests: XCTestCase {
    var interactor: NoDataInteractor?
    override func setUpWithError() throws {
        interactor = NoDataInteractor(noDataModel: NoDataUIModel(titleMessage: "titleMessage"))
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func testNoCityErrorMessage() throws {
        guard let dataModel = interactor?.getNoDataModule() else { return }
        XCTAssertEqual(dataModel.titleMessage,"titleMessage")
        
    }
}

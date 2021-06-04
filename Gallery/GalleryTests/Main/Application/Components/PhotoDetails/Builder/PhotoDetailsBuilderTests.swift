import Foundation
import XCTest
@testable import Gallery

class PhotoDetailsBuilderTests: XCTestCase {
    var view: ComponentView?
    override func setUpWithError() throws {
        view = PhotosDetailBuilder().buildPhotoDetailsModule(photoModel: MockPhotoEntityModel.getPhotoModel())
    }

    override func tearDownWithError() throws {
        view = nil
    }

    func testViewController() throws {
        XCTAssertNotNil(view?.view)
        
    }
}

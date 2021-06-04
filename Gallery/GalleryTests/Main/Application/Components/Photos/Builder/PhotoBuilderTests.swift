import Foundation
import XCTest
@testable import Gallery

class PhotoBuilderTests: XCTestCase {
    var view: ComponentView?
    override func setUpWithError() throws {
        view = PhotosBuilder().buildPhotosModule(albumModel: MockAlbumEntityModel.getAlbumModel())
    }

    override func tearDownWithError() throws {
        view = nil
    }

    func testViewController() throws {
        XCTAssertNotNil(view?.view)
        
    }
}

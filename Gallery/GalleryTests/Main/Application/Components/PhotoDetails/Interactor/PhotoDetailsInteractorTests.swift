import Foundation
import XCTest
@testable import Gallery

class PhotoDetailsInteractorTests: XCTestCase {
    var interactor: PhotosDetailInteractor?
    override func setUpWithError() throws {
        interactor = PhotosDetailInteractor(photoModel: MockPhotoEntityModel.getPhotoModel())
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func testTitleMessage() throws {
        guard let model = interactor?.getPhotoModel()  else { return }
        XCTAssertEqual(model.id,1)
        XCTAssertEqual(model.thumbnailUrlString,"https://testThumnailURL.com")
        XCTAssertEqual(model.urlString,"https://testURl.com")
        XCTAssertEqual(model.title,"title")
        XCTAssertEqual(model.albumId,1)
        
    }
}


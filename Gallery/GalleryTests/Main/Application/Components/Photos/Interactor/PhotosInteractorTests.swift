import Foundation
import XCTest
@testable import Gallery

class PhotosInteractorTests: XCTestCase {
    var interactor: PhotosInteractor?
    override func setUpWithError() throws {
        interactor = PhotosInteractor(albumModel: MockAlbumEntityModel.getAlbumModel())
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func testTitleMessage() throws {
        guard let title = interactor?.getAlbumTitle()  else { return }
        XCTAssertEqual(title,"test")
        
    }
}


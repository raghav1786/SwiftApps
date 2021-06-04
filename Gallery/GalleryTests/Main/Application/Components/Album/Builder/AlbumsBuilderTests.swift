import Foundation
import UIKit

import XCTest
@testable import Gallery

class AlbumsBuilderTests: XCTestCase {
    var view: ComponentView?
    override func setUpWithError() throws {
        view = AlbumsBuilder().buildAlbumsModule(albumsDataModel: AlbumsDataModel(albumsEmptyDelegate: MockDelegateViewController(), photosForAlbumDelegate: MockDelegateViewController()))
    }

    override func tearDownWithError() throws {
        view = nil
    }

    func testViewController() throws {
        XCTAssertNotNil(view?.view)
        
    }
}

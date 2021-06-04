import Foundation
import XCTest
@testable import Gallery
struct MockAlbumEntityModel  {
    static func getAlbumModel() -> AlbumEntityModel {
        return AlbumEntityModel(userId: 1, id: 1, title: "test")
    }
}

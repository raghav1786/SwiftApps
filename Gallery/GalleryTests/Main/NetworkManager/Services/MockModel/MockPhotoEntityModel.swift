import Foundation
import XCTest
@testable import Gallery
struct MockPhotoEntityModel  {
    static func getPhotoModel() -> PhotoEntityModel {
        return PhotoEntityModel(albumId: 1, id: 1, title: "title", urlString: "https://testURl.com", thumbnailUrlString: "https://testThumnailURL.com")
    }
}

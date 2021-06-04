import Foundation
import UIKit

import XCTest
@testable import Gallery
class MockDelegateViewController: UIViewController {
    
}

extension MockDelegateViewController: AlbumsEmptyDelegate {
    func onAlbumsEmpty() {
        
    }
}


extension MockDelegateViewController: PhotosForAlbumDelegate {
    func getPhotosForAlbum(albumModel: AlbumEntityModel) {
        
    }
}

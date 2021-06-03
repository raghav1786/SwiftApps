
import UIKit
class AlbumsRouter {
    let viewController: UIViewController
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension AlbumsRouter: AlbumsRouting {
    func openPhotosForThisAlbum(albumID: Int) {
        self.viewController.navigationController?.pushViewController(PhotosBuilder().buildPhotosModule(albumId: albumID).view,
                           animated: true)
    }
}

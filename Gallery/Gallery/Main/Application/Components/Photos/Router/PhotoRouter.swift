import UIKit
class PhotosRouter {
    let viewController: UIViewController
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension PhotosRouter: PhotosRouting {
    func openPhotosDetails(photoModel: PhotoEntityModel) {
        self.viewController.navigationController?.pushViewController(PhotosDetailBuilder().buildPhotoDetailsModule(photoModel: photoModel).view,
                           animated: true)
    }
}

import Foundation
class PhotosPresenter {
    private var interactor: PhotosInteracting?
    private var router: PhotosRouting?
    private weak var view: PhotosViewable?
    var photosModel = [PhotoEntityModel]()
    init(view: PhotosViewable,interactor: PhotosInteracting, router: PhotosRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension PhotosPresenter: PhotosPresentable {
    func onViewDidLoad() {
        getPhotoForAlbum()
        self.view?.setData()
    }
    
    private func getPhotoForAlbum() {
        _ = self.interactor?.getPhotosForAlbum(completion: { [weak self] (result, error) in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                ActivityIndicator.shared.stopAnimation()
                ActivityIndicator.shared.removeActivityIndicator()
                if let result = result {
                    strongSelf.photosModel.append(contentsOf: result)
                    strongSelf.view?.reloadData()
                }
            }
        })
    }
    
    func openPhotosDetails(photoModel: PhotoEntityModel) {
        self.router?.openPhotosDetails(photoModel: photoModel)
    }
    
    func getAlbumTitle() -> String {
        self.interactor?.getAlbumTitle() ?? ""
    }
}

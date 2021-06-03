import Foundation
class AlbumsPresenter {
    private var interactor: AlbumsInteracting?
    private var router: AlbumsRouting?
    private weak var view: AlbumsViewable?
    var albums = [AlbumEntityModel]()
    init(view: AlbumsViewable,interactor: AlbumsInteracting, router: AlbumsRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension AlbumsPresenter: AlbumsPresentable {
    func onViewDidLoad() {
        getAlbums()
        self.view?.setData()
    }
    
    private func getAlbums() {
        _ = self.interactor?.getAlbums(completion: { [weak self] (result, error) in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                ActivityIndicator.shared.stopAnimation()
                ActivityIndicator.shared.removeActivityIndicator()
                if let result = result {
                    strongSelf.albums.append(contentsOf: result)
                    strongSelf.view?.reloadData()
                }
                
                if error != nil {
                    strongSelf.interactor?.albumsDataModel.albumsEmptyDelegate.onAlbumsEmpty()
                }
                
            }
        })
    }
    
    func getPhotoForAlbum(albumID: Int) {
        router?.openPhotosForThisAlbum(albumID: albumID)
    }
}

import CoreLocation
class HomePresenter {
    private weak var view: HomeViewable?
    private var router: HomeRouting?
    private var interactor: HomeInteracting?
    private var components: [ComponentView] = []
    init(view: HomeViewable, router: HomeRouting, interactor: HomeInteracting) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresentable {
    func onViewDidLoad() {
        let albumsDataModel = AlbumsDataModel(albumsEmptyDelegate: self, photosForAlbumDelegate: self)
        components.append(AlbumsBuilder().buildAlbumsModule(albumsDataModel: albumsDataModel))
        self.view?.display(components.compactMap { $0.view })
    }
}


extension HomePresenter: AlbumsEmptyDelegate {
    func onAlbumsEmpty() {
        components.removeAll()
        components.append(NoDataBuilder()
                            .buildNoDataModule(noDataModel:
                                                NoDataUIModel(titleMessage:
                                                                NoData.albumsErrorMessage)))
        self.view?.display(components.compactMap { $0.view })
    }
}

extension HomePresenter: PhotosForAlbumDelegate {
    func getPhotosForAlbum(albumID: Int32) {
        
    }
}

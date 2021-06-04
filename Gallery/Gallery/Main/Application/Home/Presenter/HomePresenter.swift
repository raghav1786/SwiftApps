import CoreLocation
class HomePresenter {
    private weak var view: HomeViewable?
    private var components: [ComponentView] = []
    var isAlbumsVisible: Bool = false
    var isUserDetailsVisible: Bool = false
    init(view: HomeViewable) {
        self.view = view
    }
}

extension HomePresenter: HomePresentable {
    func onViewDidLoad() {
        components.removeAll()
        components.append(UserDetailsBuilder().buildUserDetailsModule())
        isAlbumsVisible = true
        isUserDetailsVisible = false
        self.view?.display(components.compactMap { $0.view })
    }
    
    func getAlbumsForUser() {
        components.removeAll()
        let albumsDataModel = AlbumsDataModel(albumsEmptyDelegate: self, photosForAlbumDelegate: self)
        components.append(AlbumsBuilder().buildAlbumsModule(albumsDataModel: albumsDataModel))
        isAlbumsVisible = false
        isUserDetailsVisible = true
        self.view?.display(components.compactMap { $0.view })
    }
    
    func getUserDetails() {
        components.removeAll()
        components.append(UserDetailsBuilder().buildUserDetailsModule())
        isAlbumsVisible = true
        isUserDetailsVisible = false
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
        isAlbumsVisible = true
        isUserDetailsVisible = true
        self.view?.display(components.compactMap { $0.view })
    }
}

extension HomePresenter: PhotosForAlbumDelegate {
    func getPhotosForAlbum(albumModel: AlbumEntityModel) {
        components.removeAll()
        components.append(PhotosBuilder()
                            .buildPhotosModule(albumModel: albumModel))
        isAlbumsVisible = true
        isUserDetailsVisible = true
        self.view?.display(components.compactMap { $0.view })
    }
}

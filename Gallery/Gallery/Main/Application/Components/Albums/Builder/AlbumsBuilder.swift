class AlbumsBuilder {
    func buildAlbumsModule(albumsDataModel: AlbumsDataModel) -> ComponentView {
        let viewController = AlbumsViewController()
        let interactor = AlbumsInteractor(albumsDataModel: albumsDataModel)
        let presenter = AlbumsPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
        return ComponentView(view: viewController)
    }
}

class AlbumsBuilder {
    func buildAlbumsModule(albumsDataModel: AlbumsDataModel) -> ComponentView {
        let viewController = AlbumsViewController()
        let interactor = AlbumsInteractor(albumsDataModel: albumsDataModel)
        let router = AlbumsRouter(viewController: viewController)
        let presenter = AlbumsPresenter(view: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        return ComponentView(view: viewController)
    }
}

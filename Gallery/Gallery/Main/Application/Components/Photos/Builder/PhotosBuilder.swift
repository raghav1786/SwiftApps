class PhotosBuilder {
    func buildPhotosModule(albumModel: AlbumEntityModel) -> ComponentView {
        let viewController = PhotosViewController()
        let interactor = PhotosInteractor(albumModel: albumModel)
        let router = PhotosRouter(viewController: viewController)
        let presenter = PhotosPresenter(view: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        return ComponentView(view: viewController)
    }
}

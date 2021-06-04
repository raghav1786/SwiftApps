class PhotosDetailBuilder {
    func buildPhotoDetailsModule(photoModel: PhotoEntityModel) -> ComponentView {
        let viewController = PhotosDetailController()
        let interactor = PhotosDetailInteractor(photoModel: photoModel)
        let presenter = PhotosDetailPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
        return ComponentView(view: viewController)
    }
}

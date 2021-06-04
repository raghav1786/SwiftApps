class PhotosDetailPresenter {
    private var interactor: PhotosDetailInteracting?
    private weak var view: PhotosDetailViewable?
    init(view: PhotosDetailViewable,interactor: PhotosDetailInteracting) {
        self.view = view
        self.interactor = interactor
    }
}

extension PhotosDetailPresenter: PhotosDetailPresentable {
    func onViewDidLoad() {
        getPhotoDetails()
    }
    private func getPhotoDetails() {
        guard let photoModel = self.interactor?.getPhotoModel() else { return }
        self.view?.setData(photoModel: photoModel)
    }
}

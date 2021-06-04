class NoDataPresenter {
    weak private var view: NoDataViewable?
    private var interactor: NoDataInteracting?
    init(view: NoDataViewable, interactor: NoDataInteracting) {
        self.view = view
        self.interactor = interactor
    }
}

extension NoDataPresenter: NoDataPresentable {
    func onViewDidLoad() {
        guard let model = self.interactor?.getNoDataModule() else { return }
        self.view?.initializeView(model: model)
    }
}

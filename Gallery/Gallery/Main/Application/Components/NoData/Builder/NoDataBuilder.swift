class NoDataBuilder {
    func buildNoDataModule(noDataModel: NoDataUIModel) -> ComponentView {
        let viewController = NoDataViewController()
        let interactor = NoCityInteractor(noDataModel: noDataModel)
        let presenter = NoDataPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
        return ComponentView(view: viewController)
    }
}

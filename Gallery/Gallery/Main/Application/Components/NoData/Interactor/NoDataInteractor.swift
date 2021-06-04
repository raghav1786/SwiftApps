class NoDataInteractor {
    private var noDataModel: NoDataUIModel
    init(noDataModel: NoDataUIModel) {
        self.noDataModel = noDataModel
    }
}

extension NoDataInteractor: NoDataInteracting {
    func getNoDataModule() -> NoDataUIModel {
        return noDataModel
    }
}

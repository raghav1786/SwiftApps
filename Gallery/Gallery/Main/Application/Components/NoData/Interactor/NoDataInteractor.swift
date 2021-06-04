class NoCityInteractor {
    private var noDataModel: NoDataUIModel
    init(noDataModel: NoDataUIModel) {
        self.noDataModel = noDataModel
    }
}

extension NoCityInteractor: NoDataInteracting {
    func getNoDataModule() -> NoDataUIModel {
        return noDataModel
    }
}

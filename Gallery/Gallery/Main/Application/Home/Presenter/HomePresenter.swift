import CoreLocation
class HomePresenter {
    private weak var view: HomeViewable?
    private var router: HomeRouting?
    private var interactor: HomeInteracting?
    private var components: [ComponentView] = []
    init(view: HomeViewable, router: HomeRouting, interactor: HomeInteracting) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresentable {
    func onViewDidLoad() {
        self.view?.display(components.compactMap { $0.view })
    }
}

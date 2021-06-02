import UIKit
public class HomeBuilder {
    public func buildHomeModule() -> UIViewController {
        let viewController = HomeViewController()
        let router = HomeRouter(viewController: viewController)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: viewController, router: router,interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}

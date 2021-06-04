import UIKit
public class HomeBuilder {
    public func buildHomeModule() -> UIViewController {
        let viewController = HomeViewController()
        let presenter = HomePresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}

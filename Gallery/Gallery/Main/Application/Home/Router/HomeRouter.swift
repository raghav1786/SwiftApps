import UIKit
class HomeRouter {
    private var viewController: UIViewController
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension HomeRouter: HomeRouting {
}

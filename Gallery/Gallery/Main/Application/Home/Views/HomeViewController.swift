import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    @IBOutlet private weak var stackView: UIStackView!
    
    var presenter: HomePresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .backgroundColor
        presenter?.onViewDidLoad()
    }
}

extension HomeViewController: HomeViewable {
    func display(_ controllers: [UIViewController]) {
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        controllers.forEach { controller in
            stackView.addArrangedSubview(controller.view)
            controller.willMove(toParent: self)
            addChild(controller)
            controller.didMove(toParent: self)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

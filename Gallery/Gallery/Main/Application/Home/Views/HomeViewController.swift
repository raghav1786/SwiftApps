import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    @IBOutlet private weak var stackView: UIStackView!
    
    var presenter: HomePresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtonItems()
        presenter?.onViewDidLoad()
    }
    
    
    private func addBarButtonItems() {
        let userBarButtonItem = UIBarButtonItem(title: "Details usor", style: .done, target: self, action: #selector(userDetailsClicked))
        let albumsBarButtonItem = UIBarButtonItem(title: "Albums", style: .done, target: self, action: #selector(albumsClicked))
        if presenter?.isAlbumsVisible ?? false {
            self.navigationItem.rightBarButtonItem = albumsBarButtonItem
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
        if presenter?.isUserDetailsVisible ?? false {
            self.navigationItem.leftBarButtonItem = userBarButtonItem
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc private func userDetailsClicked(sender: Any) {
        presenter?.getUserDetails()
    }
    
    @objc private func albumsClicked(sender: Any) {
        presenter?.getAlbumsForUser()
    }
}

extension HomeViewController: HomeViewable {
    func display(_ controllers: [UIViewController]) {
        addBarButtonItems()
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

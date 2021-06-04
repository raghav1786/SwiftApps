import UIKit
import Foundation
class PhotosDetailController: UIViewController {
    @IBOutlet private var photoTitle: MarqueeLabel!
    @IBOutlet private var photoImageView: UIImageView!
    var presenter: PhotosDetailPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtonItems()
        view.backgroundColor = .backgroundColor
        presenter?.onViewDidLoad()
    }
    
    private func addBarButtonItems() {
        let backButtonItem = UIBarButtonItem(title: "prope", style: .done, target: self, action: #selector(backButtonClicked))
        backButtonItem.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .none
        self.navigationItem.leftBarButtonItem = backButtonItem
    }
    
    @objc private func backButtonClicked(sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PhotosDetailController: PhotosDetailViewable {
    func setData(photoModel: PhotoEntityModel) {
        if let title = photoModel.title {
            photoTitle.innerText = title.capitalizingFirstLetter()
            photoTitle.innerSize = 20
            photoTitle.innerColor = .black
        }
        photoImageView.loadImage(urlString: photoModel.urlString ?? "")
    }
}

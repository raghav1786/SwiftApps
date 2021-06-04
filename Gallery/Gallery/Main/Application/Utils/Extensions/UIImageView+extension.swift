import UIKit
extension UIImageView {
    func loadImage(urlString: String) {
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else {
                self.image = UIImage(named: "empty_image")
                return
            }
            guard let data = try? Data.init(contentsOf: url) else {
                self.image = UIImage(named: "empty_image")
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }
    }
}

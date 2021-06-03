import UIKit
extension UIImageView {
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.image = UIImage(named: "empty_image")
            return
        }
        guard let data = try? Data.init(contentsOf: url) else {
            self.image = UIImage(named: "empty_image")
            return
        }
        DispatchQueue.global().async {
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

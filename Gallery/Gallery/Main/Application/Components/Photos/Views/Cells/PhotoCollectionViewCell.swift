import UIKit
class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    override func prepareForReuse() {
        imageView.image = UIImage(named: "empty_image")
    }
    
    func bind(photoModel: PhotoEntityModel) {
        imageView.loadImage(urlString: photoModel.thumbnailUrlString ?? "")
    }
}

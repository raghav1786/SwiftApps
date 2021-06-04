import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var imageView: UIImageView!
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func bind(photo: PhotoEntityModel) {
        if let imagePath = photo.thumbnailUrlString {
            imageView.loadImage(urlString: imagePath)
        }
        
        imageView.layer.cornerRadius = 5
    }
}

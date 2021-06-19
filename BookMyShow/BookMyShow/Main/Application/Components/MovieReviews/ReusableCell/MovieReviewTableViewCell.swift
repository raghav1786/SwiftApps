import UIKit
class MovieReviewTableViewCell: UITableViewCell {
//MARK: Outlets
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var createdOn: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        authorImage.layer.cornerRadius = 6
        self.selectionStyle = .none
    }
    
    //MARK: adding Data
    func configureCell(movieReviewModel:MovieReviewCellModel){
        layoutIfNeeded()
        authorName.text = movieReviewModel.author
        content.text = movieReviewModel.content
        createdOn.text = movieReviewModel.createdDate
        rating.text = movieReviewModel.rating
        authorImage.loadImage(urlString: movieReviewModel.authorIcon)
        authorImage.contentMode = .scaleAspectFill
    }
}

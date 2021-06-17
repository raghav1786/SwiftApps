
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var deleteBtn : UIButton!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var bookNowButton : UIButton!
    
    var movieID : Int64?
    var deleteButtonAction : ((Int64?) -> ())?
    var bookNowButtonAction : ((Int64?) -> ())?
    
    @IBAction func deleteClicked(sender : Any ) {
        deleteButtonAction?(movieID)
    }
    
    @IBAction func bookNowClicked(sender : Any ) {
        bookNowButtonAction?(movieID)
    }
    
    func configureCell(viewModel:MovieListModel){
        layoutIfNeeded()
        movieTitle.text = viewModel.movieTitle
        releaseDate.text = viewModel.releaseDate
        movieDesc.text = viewModel.movieDesc
        movieID = viewModel.movieID
        movieImageView.layer.cornerRadius = 10.0
        bookNowButton.layer.cornerRadius = 10.0
        deleteBtn.tintColor = .systemRed
        
        if !viewModel.movieImageUrlString.isEmpty {
            let urlString = "\(Constants.imageBaseURL)\(viewModel.movieImageUrlString)\(ApiKey.queryParamter)\(ApiKey.value)"
            movieImageView?.loadImage(urlString: urlString)
            movieImageView?.contentMode = .scaleAspectFill
        }
    }
}

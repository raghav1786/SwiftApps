import UIKit
class MovieCollectionViewCell: UICollectionViewCell {
    //MARK:- Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var deleteBtn : UIButton!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var bookNowButton : UIButton!
    
    //MARK:- Objects
    var movieID : Int64?
    var deleteButtonAction : ((Int64?) -> ())?
    var bookNowButtonAction : ((Int64?) -> ())?
    
    //MARK:- Action Methods
    @IBAction func deleteClicked(sender : Any ) {
        deleteButtonAction?(movieID)
    }
    
    @IBAction func bookNowClicked(sender : Any ) {
        bookNowButtonAction?(movieID)
    }
    
    //MARK:- Custom Methods
    func configureCell(viewModel:MovieListModel){
        layoutIfNeeded()
        movieTitle.text = viewModel.movieTitle
        releaseDate.text = viewModel.releaseDate
        movieDesc.text = viewModel.movieDesc
        movieID = viewModel.movieID
        movieImageView.layer.cornerRadius = NowPlayingConstants.cornerRadius
        bookNowButton.layer.cornerRadius = NowPlayingConstants.cornerRadius
        deleteBtn.tintColor = .systemRed
        
        if !viewModel.movieImageUrlString.isEmpty {
            let urlString = "\(Constants.imageBaseURL)\(viewModel.movieImageUrlString)\(ApiKey.queryParamter)\(ApiKey.value)"
            movieImageView?.loadImage(urlString: urlString)
            movieImageView?.contentMode = .scaleAspectFill
        }
    }
}

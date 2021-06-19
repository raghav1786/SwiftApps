import UIKit
class MovieDetailsCardCell: UIView {
    //MARK:- Outlets
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var dateRelease: UILabel!
    @IBOutlet weak private var votes: UILabel!
    @IBOutlet weak private var duration: UILabel!
    @IBOutlet weak private var descOverview: UILabel!
    @IBOutlet weak private var similarMovieButton: UIButton!
    @IBOutlet weak private var movieReviewsButton: UIButton!
    
    var similarMoviesClicked : (() -> ())?
    var movieReviewsClicked : (() -> ())?
    
    //MARK:- Custom Method
    func configureCell(model:MovieDetailsCardUIModel) {
        titleLbl.text = model.movieTitle
        descOverview.text = model.movieDesc
        dateRelease.text = model.releaseDate
        votes.text = "\(String(describing: model.votes ?? 0.0))"
        similarMovieButton.layer.cornerRadius = 10.0
        movieReviewsButton.layer.cornerRadius = 10.0
        similarMovieButton.setTitle(SimilarMoviesConstant.similarMoviesButtonTitle, for: .normal)
        movieReviewsButton.setTitle(MovieReviewConstants.reviewsTitle, for: .normal)
    }
    
    @IBAction private func similarMoviesButtonClicked() {
        similarMoviesClicked?()
    }
    
    @IBAction private func moviesReviewsButtonClicked() {
        movieReviewsClicked?()
    }
}

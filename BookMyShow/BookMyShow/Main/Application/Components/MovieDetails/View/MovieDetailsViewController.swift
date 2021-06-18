import UIKit
class MovieDetailsViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak private var movieDetailImageView : UIImageView?
    @IBOutlet weak private var movieDetailsCard: MovieDetailsCardCell?
    @IBOutlet weak private var movieCardBottomConstraint : NSLayoutConstraint!
    
    //MARK:- Objects
    var viewModel : MovieDetailsViewModel?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarTitle()
        setupUI()
        setUpSwipeGesture()
        setUpMoviesDataModel()
    }
    
    //MARK:- Custom Methods
    private func setUpMoviesDataModel() {
        movieCardBottomConstraint.constant =  MovieDetailsConstant.movieCardBottomConstraint
        guard let movie = viewModel?.movie else { return }
        movieDetailsCard?.configureCell(model: MovieDetailsCardUIModel(votes: movie.popularity, movieTitle: movie.title, movieDesc: movie.overview, releaseDate: movie.release_date))
    }
    
    private func setupUI() {
        if let movieImage =  viewModel?.movie?.movieImage {
            let urlString = "\(Constants.imageBaseURL)\(movieImage)\(ApiKey.queryParamter)\(ApiKey.value)"
            movieDetailImageView?.loadImage(urlString: urlString)
            movieDetailImageView?.contentMode = .scaleAspectFill
        }
    }
    
    private func setupNavBarTitle() {
        title = MovieDetailsConstant.movieDetailsTitle
    }
    
    private func setUpSwipeGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self,
                                               action: #selector(handleSwipeUp(sender:)))
        swipeUp.direction = .up
        movieDetailsCard?.addGestureRecognizer(swipeUp)
    }
    
    @objc private func handleSwipeUp(sender: UITapGestureRecognizer) {
        movieDetailsCard?.bounceView()
        movieCardBottomConstraint.constant = MovieDetailsConstant.movieCardBottomConstraintSwipe
    }
}

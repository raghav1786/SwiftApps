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
        movieDetailsCard?.similarMoviesClicked = { [weak self] in
            self?.similarMoviesClicked()
        }
        
        movieDetailsCard?.movieReviewsClicked = { [weak self] in
            self?.moviesReviewsClicked()
        }
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
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
    
    private func similarMoviesClicked() {
        guard let similarMoviesViewController = SimilarMoviesViewController.createInstance(storyboard: .main) as? SimilarMoviesViewController else{return}
        let similarMoviesViewModel = SimilarMoviesViewModel()
        similarMoviesViewModel.selectedMovie = viewModel?.movie
        similarMoviesViewController.viewModel = similarMoviesViewModel
        navigationController?.pushViewController(similarMoviesViewController,
                                                 animated: true)
    }
    
    private func moviesReviewsClicked() {
        guard let movieReviewViewController = MovieReviewViewController.createInstance(storyboard: .main) as? MovieReviewViewController else{return}
        let movieReviewViewModel = MovieReviewViewModel()
        movieReviewViewModel.movie = viewModel?.movie
        movieReviewViewController.viewModel = movieReviewViewModel
        navigationController?.pushViewController(movieReviewViewController,
                                                 animated: true)
    }
}

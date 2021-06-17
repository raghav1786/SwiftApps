
import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var movieDetailImageView : UIImageView?
    @IBOutlet weak var movieDetailsCard: MovieDetailsCardCell?
    @IBOutlet weak var movieCardBottomConstraint : NSLayoutConstraint!
    
    var viewModel : MovieDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Details"
        setupNavBar()
        overrideUserInterfaceStyle = .light
        movieDetailsCard?.titleLbl.text = viewModel?.movie?.title
        movieDetailsCard?.descOverview.text = viewModel?.movie?.overview
        movieDetailsCard?.dateRelease.text = viewModel?.movie?.release_date
        movieDetailsCard?.votes.text = "\(String(describing: viewModel?.movie?.popularity ?? 0.0))"
        movieCardBottomConstraint.constant = 20.0
        let swipeUp = UISwipeGestureRecognizer(target: self,
                                               action: #selector(handleSwipeUp(sender:)))
        swipeUp.direction = .up
        movieDetailsCard?.addGestureRecognizer(swipeUp)
        setupUI()
    }
    
    @objc func handleSwipeUp(sender: UITapGestureRecognizer) {
        movieDetailsCard?.bounceView()
        movieCardBottomConstraint.constant = 50.0
    }
    
    private func setupUI() {
        if let movieImage =  viewModel?.movie?.movieImage {
            let urlString = "\(Constants.imageBaseURL)\(movieImage)\(ApiKey.queryParamter)\(ApiKey.value)"
            self.movieDetailImageView?.loadImage(urlString: urlString)
            self.movieDetailImageView?.contentMode = .scaleAspectFill
        }
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "close", style: .done, target: self, action: #selector(closeClicked))
    }
    
    @objc private func closeClicked(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

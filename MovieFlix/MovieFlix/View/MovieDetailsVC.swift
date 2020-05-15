
import UIKit

class MovieDetailsVC: UIViewController {
    @IBOutlet weak var movieDetailImageView : UIImageView?
    @IBOutlet weak var movieDetailsCard: MovieDetailsCardCell?
    @IBOutlet weak var tabbar : UITabBar?
    @IBOutlet weak var topRatedTabBar: UITabBarItem!
    @IBOutlet weak var nowPlayingTabBar: UITabBarItem!
    @IBOutlet weak var movieCardBottomConstraint : NSLayoutConstraint!
    
    var viewModel : MovieDetailsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tabbar?.selectedItem = viewModel?.selectedTabBarIndex == 0 ? nowPlayingTabBar : topRatedTabBar
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
        if let movieImage =  viewModel?.movie?.movieImage,
            let url = URL(string: "\(Constants.imageBaseURL)\(movieImage)\(ApiKey.queryParamter)\(ApiKey.value)") {
            self.movieDetailImageView?.load(url: url)
            self.movieDetailImageView?.contentMode = .scaleAspectFill
        }
    }
}

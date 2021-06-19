import Foundation
import UIKit
class MovieReviewViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var movieReviewListTableView: UITableView!
    
    //MARK:- Objects
    var viewModel:MovieReviewViewModel?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVariables()
        registerCells()
        callMovieReviewApi()
    }
    
    //MARK:- Custom Methods
    func initializeVariables() {
        title = MovieReviewConstants.reviewsTitle
        navigationItem.hidesSearchBarWhenScrolling = false
        movieReviewListTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    private func registerCells() {
        movieReviewListTableView.register(UINib(nibName: Constants.movieTableCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: Constants.movieTableCellIdentifier)
        movieReviewListTableView.register(UINib(nibName: Constants.movieReviewTableViewCell, bundle: Bundle.main), forCellReuseIdentifier: Constants.movieReviewTableViewCell)
    }
    
    //MARK:- Movie Reviews Api
    private func callMovieReviewApi() {
        ActivityIndicator.shared.addActivityIndicator(self.view)
        self.viewModel?.getMovieReviews() { [weak self] (success) in
            guard let strongSelf = self else { return }
            if success {
                strongSelf.movieReviewListTableView.reloadData()
            } else {
                let alert = UIAlertController(title: ApiKey.apiErrorTitle, message: ApiKey.apiErrorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: ApiKey.retryBtn, style: UIAlertAction.Style.default, handler: { _ in
                    strongSelf.callMovieReviewApi()
                }))
                alert.addAction(UIAlertAction(title: ApiKey.okayBtnTitle, style: UIAlertAction.Style.default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            }
            ActivityIndicator.shared.stopAnimation()
            ActivityIndicator.shared.removeActivityIndicator()
        }
    }
    
    private func bookNowMovie() {
        guard let movieDetailsVC = MovieDetailsViewController.createInstance(storyboard: .main) as? MovieDetailsViewController else{return}
        let movieDetailVM = MovieDetailsViewModel(movie: viewModel?.movie)
        movieDetailsVC.viewModel = movieDetailVM
        navigationController?.pushViewController(movieDetailsVC,
                                                 animated: true)
        
    }
}


//MARK:- UITableViewDelegate,UITableViewDataSource
extension MovieReviewViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = viewModel?.reviews?.count {
            return count + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let movieCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTableCellIdentifier) as? MovieTableCell else { return UITableViewCell() }
            movieCell.tag = indexPath.row
            guard let movie = viewModel?.movie else { return UITableViewCell() }
            movieCell.configureCell(viewModel: MovieCellViewModel(movie: movie))
            movieCell.bookNowButtonAction = {[weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.bookNowMovie()
            }
            return movieCell
        } else {
            guard let movieReviewCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieReviewTableViewCell) as? MovieReviewTableViewCell else { return UITableViewCell() }
            movieReviewCell.tag = indexPath.row
            guard let review = viewModel?.reviews?[indexPath.row-1] else { return UITableViewCell() }
            movieReviewCell.configureCell(movieReviewModel: MovieReviewCellModel(movieReviewModel: review))
            return movieReviewCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            bookNowMovie()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 218
        } else {
            return UITableView.automaticDimension
        }
    }
}

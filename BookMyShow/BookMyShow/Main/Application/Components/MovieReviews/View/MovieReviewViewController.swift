import Foundation
import UIKit
import Combine

class MovieReviewViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var movieReviewListTableView: UITableView!
    
    //MARK:- Objects
    var viewModel:MovieReviewViewModel?
    var token =  [AnyCancellable]()
    
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
        viewModel?.getMovieReviews().sink {[weak self] isSuccess in
            DispatchQueue.main.async {[weak self] in
                guard let strongSelf = self else { return }
                if isSuccess {
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
        }.store(in: &token)
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
        if let count = viewModel?.reviews?.count,count != 0 {
            return count + 1
        }
        return 0
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewModel?.reviews?.count == 0 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 70))
            let label = UILabel()
            label.frame = CGRect.init(x: headerView.frame.midX - 50, y: 5, width: headerView.frame.width, height: headerView.frame.height)
            label.text = "No Reviews Yet"
            label.font = .systemFont(ofSize: 16.0, weight: .bold)
            label.textColor = .black
            
            headerView.addSubview(label)
            
            return headerView
        }
        return UIView()
    }
}

import Foundation
import UIKit
class SimilarMoviesViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var movieListTableView: UITableView!
    
    //MARK:- Objects
    var viewModel:SimilarMoviesViewModel?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVariables()
        registerCells()
        callSimilarMovieListApi()
    }
    
    //MARK:- Custom Methods
    func initializeVariables() {
        title = SimilarMoviesConstant.similarMoviesTitle
    }
    
    private func registerCells() {
        movieListTableView.register(UINib(nibName: Constants.movieTableCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: Constants.movieTableCellIdentifier)
    }
    
    private func bookNowMovie(_ id : Int64) {
        guard let movie = viewModel?.movieList?.filter({$0.id == id}).first else {return}
        guard let movieDetailsVC = MovieDetailsViewController.createInstance(storyboard: .main) as? MovieDetailsViewController else{return}
        let movieDetailVM = MovieDetailsViewModel(movie: movie)
        movieDetailsVC.viewModel = movieDetailVM
        navigationController?.pushViewController(movieDetailsVC,
                                                 animated: true)
        
    }
    
    //MARK:- Similar Movie List Api
    private func callSimilarMovieListApi() {
        ActivityIndicator.shared.addActivityIndicator(self.view)
        self.viewModel?.getSimilarMovieList() { [weak self] (success) in
            guard let strongSelf = self else { return }
            if success {
                strongSelf.movieListTableView.reloadData()
            } else {
                let alert = UIAlertController(title: ApiKey.apiErrorTitle, message: ApiKey.apiErrorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: ApiKey.retryBtn, style: UIAlertAction.Style.default, handler: { _ in
                    strongSelf.callSimilarMovieListApi()
                }))
                alert.addAction(UIAlertAction(title: ApiKey.okayBtnTitle, style: UIAlertAction.Style.default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            }
            ActivityIndicator.shared.stopAnimation()
            ActivityIndicator.shared.removeActivityIndicator()
        }
    }
}

//MARK:- UITableViewDelegate,UITableViewDataSource
extension SimilarMoviesViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movieList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTableCellIdentifier) as? MovieTableCell else { return UITableViewCell() }
        movieCell.tag = indexPath.row
        guard let movie = viewModel?.movieList?[indexPath.row] else { return UITableViewCell() }
        movieCell.configureCell(viewModel: MovieCellViewModel(movie: movie))
        movieCell.bookNowButtonAction = {[weak self] id in
            guard let strongSelf = self,let id = id else { return }
            strongSelf.bookNowMovie(id)
        }
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel?.movieList?[indexPath.row],let id = movie.id  else {
            return
        }
        bookNowMovie(id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 218
    }
}

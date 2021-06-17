
import UIKit

class SearchViewController: UIViewController, UINavigationControllerDelegate{

    //MARK:- Outlets
    @IBOutlet weak var movieListTableView: UITableView!
    
    //MARK:- Objects
    let search = UISearchController(searchResultsController: nil)
    var viewModel:SearchMoviesViewModel?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVariables()
        
    }

    //MARK:- Custom Methods
    func initializeVariables() {
        title = "Search Movies"
        initializeSearchController()
        navigationController?.delegate = self
        movieListTableView.register(UINib(nibName: Constants.movieTableCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: Constants.movieTableCellIdentifier)
        movieListTableView.register(UINib(nibName: Constants.movieSearchHeaderCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: Constants.movieSearchHeaderCellIdentifier)
        callMovieListApi()
       }
    
    func initializeSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
          search.searchResultsUpdater = self
          search.obscuresBackgroundDuringPresentation = false
          search.automaticallyShowsCancelButton = true
          search.hidesNavigationBarDuringPresentation = false
          search.searchBar.placeholder = "Type something here to search"
          search.searchBar.delegate = self
        search.searchBar.searchTextField.backgroundColor = .white
        search.searchBar.searchTextField.textColor = .white
          navigationItem.searchController = search
      }
    
    func callMovieListApi() {
        viewModel?.getMovieList { [weak self] (isSuccess) in
            if isSuccess, let strongSelf = self {
                strongSelf.movieListTableView.reloadData()
            }
        }
    }
    
    private func bookNowMovie(_ id : Int64) {
        guard let movie = viewModel?.movieList?.filter({$0.id == id}).first else {return}
        if (search.searchBar.text ?? "").count > 0 {
            RecentSearchDataManager.shared.updateRecentSearch(newSearch: movie)
        }
        guard let movieDetailsVC = MovieDetailsViewController.createInstance(storyboard: .main) as? MovieDetailsViewController else{return}
        let movieDetailVM = MovieDetailsViewModel(movie: movie)
        movieDetailsVC.viewModel = movieDetailVM
        navigationController?.pushViewController(movieDetailsVC,
                                                      animated: true)
        
    }
}


//MARK:- UISearchBarDelegate
extension SearchViewController : UISearchResultsUpdating,UISearchBarDelegate
{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        movieListTableView.endUpdates()
        viewModel?.updateSearch(text: text) { [weak self] isSuccess in
            if isSuccess, let strongSelf = self {
                strongSelf.movieListTableView.reloadData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel?.isSearchBarHighlited = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.isSearchBarHighlited = false
    }
    
}


extension SearchViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTableCellIdentifier) as? MovieTableCell else { return UITableViewCell() }
        movieCell.tag = indexPath.row
        guard let movie = viewModel?.items[indexPath.row] else { return UITableViewCell() }
        movieCell.configureCell(viewModel: MovieCellViewModel(movie: movie))
        movieCell.bookNowButtonAction = {[weak self] id in
            guard let strongSelf = self,let id = id else { return }
            strongSelf.bookNowMovie(id)
        }
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Add in Recent Search Data only and only when user is searched annything.
        guard let movie = viewModel?.items[indexPath.row],let id = movie.id  else {
            return
        }
        bookNowMovie(id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 218
    }
    
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     return SearchHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(viewModel?.headerHeight ?? 0)
    }
}

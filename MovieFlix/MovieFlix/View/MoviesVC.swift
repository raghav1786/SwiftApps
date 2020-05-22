
import UIKit
fileprivate typealias UserDataSource     = UICollectionViewDiffableDataSource<MoviesVC.Section, Movie>
fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<MoviesVC.Section, Movie>

class MoviesVC: UIViewController {
    @IBOutlet weak var tabBar : UITabBar?
    @IBOutlet weak var topRatedTabBar: UITabBarItem!
    @IBOutlet weak var nowPlayingTabBar: UITabBarItem!
    @IBOutlet weak var collectionView : UICollectionView!
    
    var viewModel : MoviesVM?
    fileprivate lazy var dataSource = makeDataSource()
    var refreshControl = UIRefreshControl()
    var selectedTabBarItem : UITabBarItem? {
        didSet {
            let isNowPlaying = selectedTabBarItem == self.nowPlayingTabBar ? true : false
            if viewModel?.topRatedMovies == nil ,!isNowPlaying {
                apiCallHandling(isNowPlaying)
            } else if viewModel?.movieList == nil, isNowPlaying {
                apiCallHandling(isNowPlaying)
            }
            applySnapshot()
        }
    }
    
    fileprivate enum Section {
        case main
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies: [Movie] = []
    var isSearchOver : Bool = false
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        viewModel = MoviesVM()
        self.apiCallHandling(true)
        self.extendedLayoutIncludesOpaqueBars = true
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.collectionView.refreshControl = self.refreshControl
        self.collectionView.delegate = self
        self.collectionView.dataSource = dataSource
        self.collectionView.register(UINib(nibName: Constants.movieCellIdentifier,
                                           bundle: Bundle.main), forCellWithReuseIdentifier: Constants.movieCellIdentifier)
        applySnapshot(animatingDifferences: false)
        
        selectedTabBarItem = nowPlayingTabBar
        self.tabBar?.selectedItem = nowPlayingTabBar
        self.tabBar?.delegate = self
        setupSearchBar()
        setupCollectionView()
        setupTheme()
    }
    
    func apiCallHandling(_ isNowPlaying: Bool) {
        ActivityIndicator.shared.addActivityIndicator(self.view)
        self.viewModel?.getMovieList(isNowPlaying) { (success) in
            if success {
                self.applySnapshot()
            } else {
                let alert = UIAlertController(title: ApiKey.apiErrorTitle, message: ApiKey.apiErrorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: ApiKey.retryBtn, style: UIAlertAction.Style.default, handler: { _ in
                    self.apiCallHandling(isNowPlaying)
                }))
                alert.addAction(UIAlertAction(title: ApiKey.okayBtnTitle, style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            ActivityIndicator.shared.stopAnimation()
            ActivityIndicator.shared.removeActivityIndicator()
        }
    }
    
    func setupTheme() {
        self.refreshControl.tintColor = .systemRed
        self.searchController.searchBar.tintColor = .darkGrayColor()
        self.searchController.searchBar.searchTextField.backgroundColor = .white
        self.searchController.searchBar.searchTextField.textColor = .black
    }
}

// collection view diffable dataSource and applySnapshot

extension MoviesVC {
    fileprivate func makeDataSource() -> UserDataSource {
        let dataSource = UserDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath,movie) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Constants.movieCellIdentifier,
                    for: indexPath) as? MovieCollectionViewCell
                cell?.movieTitle.text = movie.title
                cell?.movieDesc.text = movie.overview
                cell?.backgroundColor = .backgroundColor()
                cell?.movieID = movie.id
                if let movieImage = movie.movieImage,
                    let url = URL(string: "\(Constants.imageBaseURL)\(movieImage)\(ApiKey.queryParamter)\(ApiKey.value)") {
                    cell?.movieImageView.load(url: url)
                    cell?.movieImageView?.contentMode = .scaleAspectFill
                }
                cell?.deleteBtn.tintColor = .systemRed
                cell?.deleteButtonAction = { [unowned self] (id) in
                    if let movieId = id {
                        self.deleteMovie(movieId)
                    }
                }
                return cell
        })
        return dataSource
    }
    
    func deleteMovie(_ id : Int64) {
        let isNowPlaying = selectedTabBarItem == self.nowPlayingTabBar ? true : false
        guard let movie = isNowPlaying ? viewModel?.movieList?.filter({$0.id == id}).first : viewModel?.topRatedMovies?.filter({$0.id == id}).first else {return}
        guard let indexPath = self.dataSource.indexPath(for: movie) else { return }
        DispatchQueue.main.async {
            self.collectionView.deselectItem(at: indexPath, animated: true)
            let _ = isNowPlaying ? self.viewModel?.movieList?.remove(at: indexPath.row) :
                           self.viewModel?.topRatedMovies?.remove(at: indexPath.row)
            var snapshort = self.dataSource.snapshot()
            snapshort.deleteItems([movie])
            self.dataSource.apply(snapshort, animatingDifferences: true)
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.alwaysBounceVertical = true;
        layout.collectionView?.backgroundColor = .backgroundColor()
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        if isFiltering {
            snapshot.appendItems(filteredMovies, toSection: .main)
        } else {
            self.selectedTabBarItem == self.nowPlayingTabBar ? snapshot.appendItems(viewModel?.movieList ?? [],toSection: .main) : snapshot.appendItems(viewModel?.topRatedMovies ?? [],toSection: .main)
        }
        dataSource.apply(snapshot,
                         animatingDifferences: animatingDifferences)
    }
}

extension MoviesVC : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        guard let movieDetailsVC = MovieDetailsVC.createInstance(storyboard: .main) as? MovieDetailsVC else{return}
        let selectedTabBarIndex = self.selectedTabBarItem == nowPlayingTabBar ? 0 : 1
        let movieDetailVM = MovieDetailsVM(movie: movie,
                                           selectedTabBarIndex: selectedTabBarIndex)
        movieDetailsVC.viewModel = movieDetailVM
        self.navigationController?.pushViewController(movieDetailsVC,
                                                      animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width,
                      height: self.collectionView.frame.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("sad,mnascvdg")
    }
}

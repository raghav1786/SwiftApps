
import UIKit
fileprivate typealias UserDataSource     = UICollectionViewDiffableDataSource<NowPlayingViewController.Section, Movie>
fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<NowPlayingViewController.Section, Movie>

class NowPlayingViewController: UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    
    var viewModel : NowPlayingViewModel?
    fileprivate lazy var dataSource = makeDataSource()
    var refreshControl = UIRefreshControl()
    
    fileprivate enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        overrideUserInterfaceStyle = .light
        title = "Now Playing"
        viewModel = NowPlayingViewModel()
        callMovieListApi()
        extendedLayoutIncludesOpaqueBars = true
        setUpRefreshControl()
        setupCollectionView()
        setupCollectionViewLayout()
        setupTheme()
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchClicked))
    }
    
    @objc private func searchClicked(_ sender: AnyObject) {
        guard let searchViewController = SearchViewController.createInstance(storyboard: .main) as? SearchViewController else{return}
        let searchMoviesViewModel = SearchMoviesViewModel()
        searchViewController.viewModel = searchMoviesViewModel
        navigationController?.pushViewController(searchViewController,
                                                      animated: true)
    }
    
    private func setUpRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    private func callMovieListApi() {
        ActivityIndicator.shared.addActivityIndicator(self.view)
        self.viewModel?.getMovieList() { [weak self] (success) in
            guard let strongSelf = self else { return }
            if success {
                strongSelf.applySnapshot()
            } else {
                let alert = UIAlertController(title: ApiKey.apiErrorTitle, message: ApiKey.apiErrorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: ApiKey.retryBtn, style: UIAlertAction.Style.default, handler: { _ in
                    strongSelf.callMovieListApi()
                }))
                alert.addAction(UIAlertAction(title: ApiKey.okayBtnTitle, style: UIAlertAction.Style.default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            }
            ActivityIndicator.shared.stopAnimation()
            ActivityIndicator.shared.removeActivityIndicator()
        }
    }
    
    private func setupTheme() {
        refreshControl.tintColor = .systemRed
    }
}

// collection view diffable dataSource and applySnapshot

extension NowPlayingViewController {
    fileprivate func makeDataSource() -> UserDataSource {
        let dataSource = UserDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath,movie) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Constants.movieCellIdentifier,
                    for: indexPath) as? MovieCollectionViewCell
                cell?.layer.shouldRasterize = true;
                cell?.layer.rasterizationScale = UIScreen.main.scale;
                cell?.configureCell(viewModel: MovieListModel(movieListModel: MovieCollectionViewCellModel(movieImageUrlString: movie.movieImage, movieTitle: movie.title, movieDesc: movie.overview, releaseDate: movie.release_date, movieID: movie.id)))
                cell?.deleteButtonAction = { [unowned self] (id) in
                    if let movieId = id {
                        self.deleteMovie(movieId)
                    }
                }
                cell?.bookNowButtonAction = { [unowned self] (id) in
                    if let movieId = id {
                        self.bookNowMovie(movieId)
                    }
                }
                return cell
            })
        return dataSource
    }
    
    private func deleteMovie(_ id : Int64) {
        guard let movie = viewModel?.movieList?.filter({$0.id == id}).first else {return}
        guard let indexPath = self.dataSource.indexPath(for: movie) else { return }
        DispatchQueue.main.async {
            self.collectionView.deselectItem(at: indexPath, animated: true)
            let _ = self.viewModel?.movieList?.remove(at: indexPath.row)
            var snapshort = self.dataSource.snapshot()
            snapshort.deleteItems([movie])
            self.dataSource.apply(snapshort, animatingDifferences: true)
        }
    }
    
    private func bookNowMovie(_ id : Int64) {
        guard let movieName = viewModel?.movieList?.filter({$0.id == id}).first else {return}
        guard let indexPath = self.dataSource.indexPath(for: movieName) else { return }
        guard let movie = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        guard let movieDetailsVC = MovieDetailsViewController.createInstance(storyboard: .main) as? MovieDetailsViewController else{return}
        let movieDetailVM = MovieDetailsViewModel(movie: movie)
        movieDetailsVC.viewModel = movieDetailVM
        navigationController?.pushViewController(movieDetailsVC,
                                                      animated: true)
        
    }
    
    private func setupCollectionView() {
        self.collectionView.refreshControl = refreshControl
        self.collectionView.delegate = self
        self.collectionView.dataSource = dataSource
        self.collectionView.register(UINib(nibName: Constants.movieCellIdentifier,
                                           bundle: Bundle.main), forCellWithReuseIdentifier: Constants.movieCellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        applySnapshot(animatingDifferences: false)
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.alwaysBounceVertical = true;
        layout.collectionView?.backgroundColor = .white
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel?.movieList ?? [],toSection: .main)
        dataSource.apply(snapshot,
                         animatingDifferences: animatingDifferences)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        self.refreshControl.endRefreshing()
        callMovieListApi()
    }
}

extension NowPlayingViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width,
                      height: self.collectionView.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.3,
            delay: 0.05,
            animations: {
                cell.alpha = 1
        })
    }
}

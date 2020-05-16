
import Foundation
import UIKit

// Tab Bar Handling
extension MoviesVC : UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        selectedTabBarItem = item
    }
    
    @objc func refresh(_ sender: AnyObject) {
        let isNowPlaying = selectedTabBarItem == self.nowPlayingTabBar ? true : false
           apiCallHandling(isNowPlaying)
    }
}

//Search Bar Handling
extension MoviesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func setupSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = true
        self.searchController.searchBar.placeholder = "Search"
        self.searchController.searchBar.clipsToBounds = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.searchBarStyle = .minimal
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if let movieList = viewModel?.movieList {
            filteredMovies = movieList.filter { (movie: Movie) -> Bool in
                return (movie.title?.lowercased().contains(searchText.lowercased()) ?? false)
            }
            applySnapshot()
        }
        
    }
}

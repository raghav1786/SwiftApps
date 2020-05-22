
import Foundation
import UIKit

// Tab Bar Handling
extension MoviesVC : UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        selectedTabBarItem = item
    }
    
    @objc func refresh(_ sender: AnyObject) {
        let isNowPlaying = selectedTabBarItem == self.nowPlayingTabBar ? true : false
        self.refreshControl.endRefreshing()
        apiCallHandling(isNowPlaying)
    }
}

//Search Bar Handling
extension MoviesVC: UISearchResultsUpdating, UISearchBarDelegate,UITextFieldDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if !isSearchOver || isSearchBarEmpty {
            isSearchOver = false
            filterContentForSearchText(searchBar.text!)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearchOver = true
        self.searchController.searchBar.searchTextField.resignFirstResponder()
        self.searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearchOver = true
        self.searchController.searchBar.searchTextField.resignFirstResponder()
        self.searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.isSearchOver = true
        self.searchController.dismiss(animated: true, completion: nil)
        self.searchController.searchBar.searchTextField.resignFirstResponder()
    }
    
    func setupSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.searchTextField.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = true
        self.searchController.searchBar.placeholder = "Search"
        self.searchController.searchBar.clipsToBounds = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.searchBarStyle = .prominent
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        let isNowPlaying = selectedTabBarItem == self.nowPlayingTabBar ? true : false
        if let movieList = viewModel?.movieList,isNowPlaying {
            filteredMovies = movieList.filter { (movie: Movie) -> Bool in
                return (movie.title?.lowercased().contains(searchText.lowercased()) ?? false)
            }
        }
        if let topRatedmovieList = viewModel?.topRatedMovies,!isNowPlaying {
            filteredMovies = topRatedmovieList.filter { (movie: Movie) -> Bool in
                return (movie.title?.lowercased().contains(searchText.lowercased()) ?? false)
            }
        }
        applySnapshot()
    }
}

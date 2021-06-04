import UIKit
import Foundation
class AlbumsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var albumName: UILabel!
    
    var presenter: AlbumsPresentable?
    private var cellIdentifier = "AlbumTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        ActivityIndicator.shared.addActivityIndicator(self.view)
        presenter?.onViewDidLoad()
    }
    
    private func setup() {
        title = "Albums"
        albumName.text = "ad eligere sua photos album velit videre"
        albumName.textColor = .black
        self.navigationController?.navigationBar.backgroundColor = .navBarColor
        tableView.backgroundColor = .backgroundColor
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

// MARK: - Extension AlbumViewabl

extension AlbumsViewController: AlbumsViewable {
    func setData() {
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - Extension TableView

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.albums.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? AlbumTableViewCell else {
            let cell = UITableViewCell()
            cell.backgroundColor = UIColor.backgroundColor
            return cell
        }
        guard let album = presenter?.albums[indexPath.row],let title = album.title else { let cell = UITableViewCell()
            cell.backgroundColor = UIColor.backgroundColor
            return cell}
        cell.bind(title: title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.05,
            animations: {
                cell.alpha = 1
            })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let albumModel = presenter?.albums[indexPath.row] else {return}
        presenter?.getPhotoForAlbum(albumModel: albumModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

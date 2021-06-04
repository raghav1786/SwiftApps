import UIKit
import Foundation
class PhotosViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var albumTitleLabel: UILabel!
    var presenter: PhotosPresenter?
    private var cellIdentifier = "PhotoCollectionViewCell"
    let operationQueue: OperationQueue = OperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
        presenter?.onViewDidLoad()
    }
    
    // MARK: - Private
    
    private func setup() {
        title = "photos"
        navigationController?.navigationBar.backgroundColor = .purple
        albumTitleLabel.text = presenter?.getAlbumTitle().capitalizingFirstLetter()
        ActivityIndicator.shared.addActivityIndicator(self.view)
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 23, right: 16)
        collectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - Extension AlbumViewabl

extension PhotosViewController: PhotosViewable {
    func setData() {
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - Extension UICollectionViewDelegate, UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.photosModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let photoModel = presenter?.photosModel[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.bind(photoModel: photoModel)
        return cell
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

// MARK: - Extension CollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 50
        let collectionCellWidth: CGFloat = (collectionView.bounds.width - padding) / 2
        let collectionCellHeight = collectionCellWidth

        return CGSize(width: collectionCellWidth, height: collectionCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photoPresenter = presenter else {
            fatalError("Photo presenter can't be nil")
        }
        let photoModel = photoPresenter.photosModel[indexPath.row]
        presenter?.openPhotosDetails(photoModel: photoModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

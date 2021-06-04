import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    
    override func prepareForReuse() {
        titleLabel.text = ""
    }
    
    func bind(title: String) {
        separatorInset = .zero
        titleLabel.text = title
        titleLabel.textColor = .textColor
    }
}

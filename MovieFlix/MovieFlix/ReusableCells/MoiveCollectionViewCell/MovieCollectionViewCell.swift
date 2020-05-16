
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var deleteBtn : UIButton!
    
    var movieID : Int64?
    var deleteButtonAction : ((Int64?) -> ())?
    
    @IBAction func deleteClicked(sender : Any ) {
        deleteButtonAction?(movieID)
    }
}

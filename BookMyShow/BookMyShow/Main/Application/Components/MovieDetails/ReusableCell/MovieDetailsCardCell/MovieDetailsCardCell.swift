import UIKit
class MovieDetailsCardCell: UIView {
    //MARK:- Outlets
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var dateRelease: UILabel!
    @IBOutlet weak private var votes: UILabel!
    @IBOutlet weak private var duration: UILabel!
    @IBOutlet weak private var descOverview: UILabel!
    
    //MARK:- Custom Method
    func configureCell(model:MovieDetailsCardUIModel) {
        titleLbl.text = model.movieTitle
        descOverview.text = model.movieDesc
        dateRelease.text = model.releaseDate
        votes.text = "\(String(describing: model.votes ?? 0.0))"
    }
}

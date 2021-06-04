import UIKit
class NoDataViewController: UIViewController {
    @IBOutlet private weak var titleMessage: UILabel!
    
    var presenter: NoDataPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
    
    private func setFonts() {
        titleMessage.font = .subTitle()
    }
}

extension NoDataViewController: NoDataViewable {
    func initializeView(model: NoDataUIModel) {
        setFonts()
        titleMessage.text = model.titleMessage
    }
}

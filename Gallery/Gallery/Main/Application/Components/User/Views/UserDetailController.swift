import UIKit
import Foundation
class UserDetailController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var websiteAddressLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var phoneNumberTextLabel: UILabel!
    @IBOutlet weak var websiteAddressTextLabel: UILabel!
    @IBOutlet weak var emailAddressTextLabel: UILabel!
    
    var presenter: UserDetailPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setFont()
        setColor()
        view.backgroundColor = .backgroundColor
        presenter?.onViewDidLoad()
    }
}

extension UserDetailController: UserDetailViewable {
    func setData(userEntityModel: UserEntityModel) {
        nameLabel.text = userEntityModel.name ?? ""
        websiteAddressLabel.text = userEntityModel.website ?? ""
        phoneNumberLabel.text = userEntityModel.phone ?? ""
        emailAddressLabel.text = userEntityModel.email ?? ""
        websiteAddressTextLabel.text = "website:"
        phoneNumberTextLabel.text = "phone:"
        emailAddressTextLabel.text = "inscriptio:"
    }
    
    func setColor() {
        nameLabel.textColor = .textColor
        websiteAddressLabel.textColor = .textColor
        phoneNumberLabel.textColor = .textColor
        emailAddressLabel.textColor = .textColor
        websiteAddressTextLabel.textColor = .black
        phoneNumberTextLabel.textColor = .black
        emailAddressTextLabel.textColor = .black
    }
    
    func setFont() {
        nameLabel.font = .heading()
        websiteAddressLabel.font = .smallDesc()
        phoneNumberLabel.font = .smallDesc()
        emailAddressLabel.font = .smallDesc()
        websiteAddressTextLabel.font = .smallDesc()
        phoneNumberTextLabel.font = .smallDesc()
        emailAddressTextLabel.font = .smallDesc()
    }
}

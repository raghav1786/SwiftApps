//
//  UserInfoTableViewCell.swift
//  ReusableUI
//
//  Created by RAGHAV SHARMA on 22/12/19.
//  Copyright © 2019 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

//added structure for adding Details of user
public struct UserDescription {
    let name : String?
    let phone : Int64?
    let address : String?
    let email : String?
    
    public init(name: String?,phone: Int64?,address: String?,email:String?) {
        self.name = name
        self.phone = phone
        self.address = address
        self.email = email
    }
}
//appending data using data model
public  class UserInfoTableViewCellModel : CellModel {
    public var referenceContent : UserDescription?
    public init(referenceContent : UserDescription) {
        self.referenceContent = referenceContent
        super.init(reuseIdentifier: CellIdentifiers.UserInfoTableViewCell.rawValue)
    }
}
//custom cell to show user info
public  class UserInfoTableViewCell : BaseCell {
    @IBOutlet weak  var nameLabel: UILabel?
    @IBOutlet weak var emailLabel : UILabel?
    @IBOutlet weak var addressLabel : UILabel?
    @IBOutlet weak var contactLabel : UILabel?
    
    override public func configureWithModel(_ cellModel: CellModel) {
        super.configureWithModel(cellModel)
        guard  let cellModel = cellModel as? UserInfoTableViewCellModel else {
            return
        }
        let model = cellModel.referenceContent
        nameLabel?.text = model?.name
        emailLabel?.text = model?.email
        addressLabel?.text = model?.address
        contactLabel?.text = "\(model?.phone ?? 0)"
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

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
public struct UserInfo {
    let name : String?
    let phone : Int64?
    let address : String?
    
    public init(name: String?,phone: Int64?,address: String?) {
        self.name = name
        self.phone = phone
        self.address = address
    }
}
//appending data using data model
public  class UserInfoTableViewCellModel : CellModel {
    public var referenceContent : UserInfo?
    public init(referenceContent : UserInfo) {
        self.referenceContent = referenceContent
        super.init(reuseIdentifier: CellIdentifiers.UserInfoTableViewCell.rawValue)
    }
}
//custom cell to show user info
public  class UserInfoTableViewCell : BaseCell {
    @IBOutlet weak  var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel : UILabel?
    
    override public func configureWithModel(_ cellModel: CellModel) {
        super.configureWithModel(cellModel)
        guard  let cellModel = cellModel as? UserInfoTableViewCellModel else {
            return
        }
        let model = cellModel.referenceContent
        titleLabel?.text = model?.name
        descriptionLabel?.text = model?.address
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

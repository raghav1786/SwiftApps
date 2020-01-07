//
//  UserInfoTableViewCell.swift
//  ReusableUI
//
//  Created by RAGHAV SHARMA on 22/12/19.
//  Copyright © 2019 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

public struct UserInfo {
    let name : String?
    let phone : Int32?
    let address : String?
    
    public init(name: String?,phone: Int32?,address: String?) {
        self.name = name
        self.phone = phone
        self.address = address
    }
}

public  class UserInfoTableViewCellModel : CellModel {
    public var referenceContent : UserInfo?
    public init(referenceContent : UserInfo) {
        self.referenceContent = referenceContent
        super.init(reuseIdentifier: CellIdentifiers.UserInfoTableViewCell.rawValue)
    }
}

public  class UserInfoTableViewCell : BaseCell {
    @IBOutlet weak  var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel : UILabel?
    
    override public func configureWithModel(_ cellModel: CellModel) {
        guard  let cellModel = cellModel as? UserInfoTableViewCellModel else {
            return
        }
        let model = cellModel.referenceContent
        titleLabel?.text = model?.name
        descriptionLabel?.text = model?.address
    }
}

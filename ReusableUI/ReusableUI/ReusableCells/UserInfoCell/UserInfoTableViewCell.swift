//
//  UserInfoTableViewCell.swift
//  ReusableUI
//
//  Created by RAGHAV SHARMA on 22/12/19.
//  Copyright © 2019 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

public  class UserInfoTableViewCell : UITableViewCell {
    @IBOutlet weak  var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel : UILabel?
    override public func awakeFromNib() {
        
        titleLabel?.text = "Title"
        descriptionLabel?.text = "description"
    }
    override public func setNeedsDisplay() {
        
    }
}

//
//  CategoryCell.swift
//  CategoryDetails
//
//  Created by RAGHAV SHARMA on 18/04/21.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var subcategoryLabel: UILabel!
    @IBOutlet weak var subcategoryTitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var subcategoryStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addSubcategory(_ sender: Any) {
    }
}

//
//  DogBreedImageTableViewCell.swift
//  Dogify
//
//  Created by RAGHAV SHARMA on 25/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit

class DogBreedImageTableViewCell: UITableViewCell {
@IBOutlet weak var imageViewBreed: UIImageView?
    @IBOutlet weak var borderView : UIView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        borderView?.layer.cornerRadius = 100
    }
    
}

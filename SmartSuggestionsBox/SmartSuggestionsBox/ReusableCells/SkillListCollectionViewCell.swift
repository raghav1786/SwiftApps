//
//  SkillListCollectionViewCell.swift
//  SmartSuggestionsBox
//
//  Created by RAGHAV SHARMA on 02/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit
class SkillListCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "SkillListCollectionViewCell"
    
    var skill: Skill? {
        didSet{
            guard let sender = self.skill else { return }
            self.titleLabel.text = sender.title
        }
    }
    
    var titleLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.lineBreakMode = .byTruncatingMiddle
        lbl.textColor = .black
        return lbl
    }()
    
    override func setupViews() {
        
        self.titleLabel.text = nil
        self.layer.cornerRadius = 14.0
        self.contentView.addSubview(titleLabel)
        
        self.addConstraints([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}

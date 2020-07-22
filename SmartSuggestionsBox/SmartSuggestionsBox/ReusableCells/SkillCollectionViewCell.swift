//
//  SkillCollectionViewCell.swift
//  SmartSuggestionsBox
//
//  Created by RAGHAV SHARMA on 02/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

class SkillCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "SkillCollectionViewCell"
    
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
        lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return lbl
    }()
    
    var customImageView: UIImageView = {
        let image = UIImage(systemName: "xmark.circle")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    
    var cancelButton: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.setContentHuggingPriority(.init(900), for: .horizontal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    override func setupViews() {
        
        self.titleLabel.text = nil
        self.backgroundColor = #colorLiteral(red: 0, green: 0.1645387113, blue: 0.3128089607, alpha: 1)
        self.layer.cornerRadius = 14.0
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(cancelButton)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(customImageView)
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.spacing = 1
        addSubview(stack)
        
        self.addConstraints([
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 20),
            customImageView.widthAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            titleLabel.trailingAnchor.constraint(equalTo: customImageView.leadingAnchor),
            customImageView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),

            stack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
        ])
    }
}

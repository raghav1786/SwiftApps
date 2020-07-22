//
//  ViewController.swift
//  SmartSuggestionsBox
//
//  Created by RAGHAV SHARMA on 01/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       let barButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openSkillsTab))
        barButtonItem.tintColor = .black
         self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    
    @objc private func openSkillsTab() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let skillsAndInterestsVC = storyboard.instantiateViewController(withIdentifier: "SkillsInterestsVC") as? SkillsInterestsVC else {return}
        self.navigationController?.pushViewController(skillsAndInterestsVC, animated: true)
    }

}


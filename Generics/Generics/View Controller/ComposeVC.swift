//
//  ComposeVC.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 15/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit
import ReusableUI
import Firebase

class ComposeVC: UIViewController {
    @IBOutlet weak var nametxtFeild: UITextField!
    @IBOutlet weak var emailtxtFeild: UITextField!
    @IBOutlet weak var contacttxtFeild: UITextField!
    @IBOutlet weak var addresstxtFeild : UITextField!
    //properties
    var viewModel : LoginVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginVM()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addUser(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancelRequest(_ sender: Any) {
       navigationController?.popViewController(animated: true)
       
    }
    
}

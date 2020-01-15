//
//  LoginVC.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 15/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit
import ReusableUI
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailtxtFeild: UITextField!
    @IBOutlet weak var passwordtxtFeild: UITextField!
    @IBOutlet weak var signInButton : UIButton!
    //properties
    var viewModel : LoginVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginVM()
        // Do any additional setup after loading the view.
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
    }

}

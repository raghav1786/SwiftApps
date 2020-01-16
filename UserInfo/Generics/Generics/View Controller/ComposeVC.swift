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
import FirebaseDatabase

class ComposeVC: UIViewController {
    @IBOutlet weak var nametxtFeild: UITextField!
    @IBOutlet weak var emailtxtFeild: UITextField!
    @IBOutlet weak var contacttxtFeild: UITextField!
    @IBOutlet weak var addresstxtFeild : UITextField!
    //properties
    var viewModel : LoginVM?
    var ref : DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginVM()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addUser(_ sender: Any) {
        ref?.child("users").childByAutoId().setValue(nametxtFeild.text)
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancelRequest(_ sender: Any) {
       navigationController?.popViewController(animated: true)
       
    }
    
}

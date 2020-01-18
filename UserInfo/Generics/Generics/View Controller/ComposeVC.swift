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
    var ref : DatabaseReference?
    var refUsers : DatabaseReference?
    var refUserDetails : DatabaseReference?
    var viewModel : LoginVM?
    var count = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginVM()
        ref = Database.database().reference()
        refUsers =  ref?.child("users")
        refUserDetails = ref?.child("userDetails")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addUser(_ sender: Any) {
        // Create the user and record it
        writeUserToDatabase()
        // Create the userDetail and record it
        writeUserDetailToDatabase()
        count += 1
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelRequest(_ sender: Any) {
       navigationController?.popViewController(animated: true)
       
    }
    
    private func writeUserDetailToDatabase() {
        refUserDetails?.child(String(count)).child("email").setValue(emailtxtFeild.text)
        refUserDetails?.child(String(count)).child("contact").setValue(Int64(contacttxtFeild?.text ?? ""))
        refUserDetails?.child(String(count)).child("address").setValue(addresstxtFeild.text)
    }
    
    private func writeUserToDatabase() {
        refUsers?.child(String(count)).child("name").setValue(nametxtFeild.text)
    }
}

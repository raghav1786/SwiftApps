//
//  ComposeVC.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 15/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit
import ReusableUI

class ComposeVC: UIViewController {
    @IBOutlet weak var nametxtFeild: UITextField!
    @IBOutlet weak var emailtxtFeild: UITextField!
    @IBOutlet weak var contacttxtFeild: UITextField!
    @IBOutlet weak var addresstxtFeild : UITextField!
    //properties
    typealias DependencyType = ComposeVM
    fileprivate var viewModel : ComposeVM?
    var uuid = UUID()
    
    private func assertDependencies() {
        assert(viewModel != nil)
    }
    
    internal func inject(dependency : DependencyType) {
        viewModel = dependency
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.setupFirebaseReferences()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addUser(_ sender: Any) {
        // Create the user and record it
        addUserToDB()
        // Create the userDetail and record it
        addUserDetailsToDB()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelRequest(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
}

//MARK: Writing to Database
extension ComposeVC {
    private func addUserToDB() {
        viewModel?.addUserToDB(userID: uuid.uuidString, name: nametxtFeild.text ?? "")
    }
    
    private func addUserDetailsToDB() {
        viewModel?.addUserDetailsToDB(userID: uuid.uuidString,
                                      email: emailtxtFeild.text ?? "",
                                      contact: contacttxtFeild.text ?? "",
                                      address: addresstxtFeild.text ?? "")
    }
}

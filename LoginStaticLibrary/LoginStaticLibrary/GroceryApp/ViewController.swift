//
//  ViewController.swift
//  GroceryApp
//
//  Created by RAGHAV SHARMA on 12/02/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit
import LoginStaticLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignInTapped(_ sender: Any) {
        // call Static Lib login from here!
        let loginViewController = getLoginScreen(onLogin: {self.dismiss(animated: true, completion: nil)})
        self.present(loginViewController, animated: true, completion: nil)
    }


}


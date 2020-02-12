//
//  LoginViewController.swift
//  LoginStaticLibrary
//
//  Created by RAGHAV SHARMA on 12/02/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var onLogin: (() -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func onLoginTapped(_ sender: Any) {
        self.onLogin?()
    }
}

public func getLoginScreen(onLogin: @escaping()->()) -> UIViewController {
    let bundlePath = Bundle.main.path(forResource: "LoginResourceBundle", ofType: "bundle")!
    let bundle = Bundle(path: bundlePath)!
    let loginViewController = LoginViewController(nibName: "LoginScreen", bundle: bundle)
    loginViewController.onLogin = onLogin
    return loginViewController
}

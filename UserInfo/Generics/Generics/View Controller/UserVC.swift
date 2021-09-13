//
//  ViewController.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 21/12/19.
//  Copyright © 2019 RAGHAV SHARMA. All rights reserved.
//

import UIKit
import ReusableUI

class UserVC: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //properties
    var viewModel : UserVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserVM()
        registerCustomCells()
        reloadTableViews()
        showIndicator(in: self.view)
        
        //fetchingData from realtime Database
        viewModel?.getUsers() { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.reloadTableViews()
                    self.hideIndicator(from: self.view)
                }
            }
        }
        
        //MARK: Some unused CRUD operation methods.
        //        viewModel?.getUsersFromFireStore { isSuccess in
        //            if isSuccess {
        //                self.reloadTableViews()
        //                self.hideIndicator(from: self.view)
        //            }
        //        }
        
        
        //        viewModel?.deleteUsers() { isSuccess in
        //            if isSuccess {
        //                self.hideIndicator(from: self.view)
        //            }
        //        }
        
        //        viewModel?.updateUser() { isSuccess in
        //            if isSuccess {
        //                self.hideIndicator(from: self.view)
        //            }
        //        }
        
    }
    
    @IBAction func addUsers(_ sender: Any) {
        guard let composeVC = ComposeVC.createInstance(storyboard: .main) as? ComposeVC else {return}
        let composeVM = ComposeVM()
        composeVC.inject(dependency: composeVM)
        navigationController?.pushViewController(composeVC, animated: true)
    }
    
    
    //reload tableViews data
    private func reloadTableViews() {
        viewModel?.configureData()
        tableView.dataSource = viewModel?.dataSource
        tableView.reloadData()
    }
    
    //register custom cells for tableView
    private func registerCustomCells() {
        tableView.delegate = self
        tableView.registerCustomFrameWorkCells(identifiers: [CellIdentifiers.UserInfoTableViewCell.rawValue])
    }
}

extension UserVC: ProgressIndicator {
}

//
//  ViewController.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 21/12/19.
//  Copyright © 2019 RAGHAV SHARMA. All rights reserved.
//

import UIKit
import ReusableUI
import FirebaseDatabase

class ViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //properties
    var ref : DatabaseReference?
    var viewModel : ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        viewModel?.configureData()
        tableView.delegate = self
        tableView.registerCustomFrameWorkCells(identifiers: [CellIdentifiers.UserInfoTableViewCell.rawValue])
        tableView.dataSource = viewModel?.dataSource
        tableView.reloadData()
        // Do any additional setup after loading the view.
        
        //set the firebase Reference
        ref = Database.database().reference()

        //Retrieve the users and listen for changes
        ref?.child("users").observe(.value, with: {
            (snapshot) in
            //code to execute when child is added under "users"
            //take a value from the snapshot and added it to the array of users
            if  let user = snapshot.value as? String {
                 self.viewModel?.users.append(user)
            }
            self.viewModel?.configureData()
            self.tableView.reloadData()
        })
        ref?.child("userDetails").observe(.value, with: {
            (snapshot) in
            //code to execute when child is added under "users"
            //take a value from the snapshot and added it to the array of users
            if  let user = snapshot.value as? [String:[[String:Any]]] {
            }
            self.viewModel?.configureData()
            self.tableView.reloadData()
        })

           
    }

}

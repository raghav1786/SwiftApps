//
//  ViewController.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 21/12/19.
//  Copyright © 2019 RAGHAV SHARMA. All rights reserved.
//

import UIKit
import ReusableUI
import Firebase

class ViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //properties
    var viewModel : ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        viewModel?.configureData()
        // Do any additional setup after loading the view.
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        tableView.delegate = self
        tableView.registerCustomFrameWorkCells(identifiers: [CellIdentifiers.UserInfoTableViewCell.rawValue])
        tableView.dataSource = viewModel?.dataSource
        tableView.reloadData()
    }

}

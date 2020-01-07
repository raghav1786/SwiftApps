//
//  ViewController.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 21/12/19.
//  Copyright © 2019 RAGHAV SHARMA. All rights reserved.
//

import UIKit
import ReusableUI

class ViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var items : [String] = ["Item1","Item2","Item3","Item4","Item5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.registerCustomCells(identifiers: [CellIdentifiers.UserInfoTableViewCell.rawValue])
    }

}

//
//  ViewController.swift
//  Swift-SwiftUI_InterOperation
//
//  Created by RAGHAV SHARMA on 31/03/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    var items = ["Test1","Test2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBSegueAction func segueDetails(_ coder: NSCoder) -> UIViewController? {
//        guard let indexPath = self.tableView.indexPathForSelectedRow else {
//            fatalError("Not Found");
//        }
        let detailsView = DetailsView()
        return UIHostingController(coder: coder, rootView: detailsView)
    }
}

extension ViewController : UITableViewDelegate {
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {return UITableViewCell()}
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
}

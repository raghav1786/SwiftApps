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

class UserVC: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //properties
    var ref : DatabaseReference?
    var refUsers : DatabaseReference?
    var refUserDetails : DatabaseReference?
    var viewModel : UserVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserVM()
        
        // Do any additional setup after loading the view.
        registerCustomCells()
        reloadTableViews()
        
        //set the firebase Reference
        ref = Database.database().reference()
        refUsers =  ref?.child("users")
        refUserDetails = ref?.child("userDetails")
        
        //fetchingData from realtime Database
        getUsers()
        
    }
    
    private func getUsers() {
        //Retrieve the users and listen for changes
        refUsers?.observe(.value,with: { snapshot in
            var users = [Users]()
            for usersSnapshot in snapshot.children {
                let key = (usersSnapshot as AnyObject).key as String
                let user = Users(snapshot: usersSnapshot as! DataSnapshot,keyValue: Int(key) ?? 0)
                users.append(user)
            }
            self.viewModel?.users = users
            
            //fetching userDetails from firebase
            self.getUserDetails()
        })
    }
    
    private func getUserDetails() {
        //Retrieve the userDetails and listen for changes
        refUserDetails?.observe(.value,with: { snapshot in
            var userDetails = [UserDetails]()
            for userDetailsSnapshot in snapshot.children {
                let key = (userDetailsSnapshot as AnyObject).key as String
                let userDetail = UserDetails(snapshot: userDetailsSnapshot as! DataSnapshot,keyValue: Int(key) ?? 0)
                userDetails.append(userDetail)
            }
            self.viewModel?.userDetails = userDetails
            //reload table after getting data
            self.reloadTableViews()
        })
    }
    
    
    //reloadtableViews data
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

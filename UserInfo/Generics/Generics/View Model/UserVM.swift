//
//  ViewModel.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 08/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import ReusableUI
import FirebaseDatabase

struct UserVM  {
    
    //properties
    let dataSource : DataSource = DataSource()
    var userDetails = [UserDetails]()
    var users = [Users]()
    
    //configure data into ViewModel for custom Cell used in tableView
    func configureData() {
        dataSource.sections.removeAll()
        var rowItems : [TableViewCompatible] = []
            
            // navigating through each user and fetching its details
            for user in users   {
                //Getting user Details for the user
                let userDetail = userDetails[user.key - 1]
                //passing detail to UserDescription Struct
                let userInfoCell = UserDescription(id: user.key, name: user.name, phone: userDetail.contact, address: userDetail.address, email: userDetail.email)
                
                //adding details of user to UserInfoTableViewCellModel
                let userInfoTableViewCell = UserInfoTableViewCellModel(referenceContent: userInfoCell)
                rowItems.append(userInfoTableViewCell)
            }
        
        //appending rowItems into section
        let section = BaseTableViewSection(sortOrder: 0, items: rowItems)
        dataSource.sections.append(section)
    }
}

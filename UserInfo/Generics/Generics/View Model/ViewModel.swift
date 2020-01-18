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

struct ViewModel  {
    let dataSource : DataSource = DataSource()
    var userDetails = [UserDetails]()
    var users = [Users]()
    //configure data into ViewModel for custom Cell used in tableView
    func configureData() {
        
        
        dataSource.sections.removeAll()
        var rowItems : [TableViewCompatible] = []
            for items in userDetails   {
                let userInfoCell = UserDescription(id: items.key, name: users[items.key-1].name, phone: items.contact, address: items.address, email: items.email)
                let userInfoTableViewCell = UserInfoTableViewCellModel(referenceContent: userInfoCell)
                rowItems.append(userInfoTableViewCell)
            }
        let section = BaseTableViewSection(sortOrder: 0, items: rowItems)
        
        dataSource.sections.append(section)
    }
}

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
    var users = [String]()
    //configure data into ViewModel for custom Cell used in tableView
    func configureData() {
        dataSource.sections.removeAll()
        var rowItems : [TableViewCompatible] = []
        print(users.count)
        for items in users {
//            let userInfoCell = UserInfo(name: items, phone: 787, address: "as")
//            let userInfoTableViewCell = UserInfoTableViewCellModel(referenceContent: userInfoCell)
//            rowItems.append(userInfoTableViewCell)
        }
        let section = BaseTableViewSection(sortOrder: 0, items: rowItems)
        
        dataSource.sections.append(section)
    }
}

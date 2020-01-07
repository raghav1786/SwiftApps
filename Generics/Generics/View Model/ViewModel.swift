//
//  ViewModel.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 08/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import ReusableUI

struct ViewModel  {
    let dataSource : DataSource = DataSource()
    
    func configureData() {
        var rowItems : [TableViewCompatible] = []
        let userInformation = UserInfo(name: "Raghav", phone: 7589244460, address: "Megapolis Mystic")
        let userInformationTableViewCellModel = UserInfoTableViewCellModel(referenceContent: userInformation)
        rowItems.append(userInformationTableViewCellModel)
        
        let section = BaseTableViewSection(sortOrder: 0, items: rowItems)
        dataSource.sections.append(section)
    }
}

//TableViewManager

import Foundation
import UIKit

//protocol for row items for Table , will be used as Custom Cells
public protocol TableViewCompatible {
    var reuseIdentifier : String {get}
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
}

//model for custom cell used to apend data
open class CellModel : TableViewCompatible {
    public var reuseIdentifier: String
    
    public init(reuseIdentifier : String) {
        self.reuseIdentifier = reuseIdentifier
    }
    
    public func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier,for: indexPath) as? BaseCell {
            cell.configureWithModel(self)
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
    }
}

//Generic UITableViewCell used to apend customized cells into tableView
public class BaseCell : UITableViewCell {
    public var cellModel : CellModel?
    open func configureWithModel(_ cellModel : CellModel) {
        selectionStyle = .none
        self.cellModel = cellModel
    }
}

//protocol for custom sections in tableView
public protocol TableViewSection {
    var sortOrder : Int {get set}
    var items : [TableViewCompatible] {get set}
    var headerTitle : String? {get set}
    var footerTitle  : String? {get set}
}

//class used to apend custom sections into Tableview
// can include headerTitle,FooterTitle,items:-customCells
public class BaseTableViewSection : TableViewSection {
    public var sortOrder: Int
    
    public var items: [TableViewCompatible]
    
    public var headerTitle: String?
    
    public var footerTitle: String?
    
    required public init(sortOrder : Int , items : [TableViewCompatible] ,headerTitle : String? = nil,footerTitle : String? = nil) {
        self.sortOrder = sortOrder
        self.footerTitle = footerTitle
        self.headerTitle = headerTitle
        self.items = items
    }
}

//custom datasource object used to add data into tableView
public class DataSource : NSObject , UITableViewDataSource {
    public var sections = [TableViewSection]() {
        didSet {
            sections.sort {$0.sortOrder > $1.sortOrder}
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < sections[indexPath.section].items.count {
            let model = sections[indexPath.section].items[indexPath.row]
            if let model = model as? CellModel {
                let cell = model.cellForTableView(tableView: tableView, atIndexPath: indexPath)
                return cell
            } else {
                return UITableViewCell(style: .default, reuseIdentifier: "Cell")
            }
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
    }
    
    
}

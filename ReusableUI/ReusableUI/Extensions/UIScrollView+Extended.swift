// Extending ScrollView

import Foundation
import UIKit

public protocol CustomCellRegistrable {}

extension UIScrollView : CustomCellRegistrable {
    //register custome cell from ReusableUI framework
    // Parameter identitfiers cell reusable identifier same as cell nib name
    public func registerCustomFrameWorkCells(identifiers :[String]) {
        for identifier in identifiers {
            let bundle = Bundle(identifier: "com.ReusableUI")
            (self as? UITableView)?.register(UINib(nibName: identifier,bundle : bundle), forCellReuseIdentifier : identifier)
        }
    }
    //register custome cell from main framework
    public func registerCustomCells(identifiers : [String]) {
        for identifier in identifiers {
             (self as? UITableView)?.register(UINib(nibName: identifier,bundle : nil), forCellReuseIdentifier : identifier)
        }
    }
}


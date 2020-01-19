//
//  UIViewController+Extended.swift
//  ReusableUI
//
//  Created by RAGHAV SHARMA on 19/01/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    public class func createInstance<T:UIViewController>(storyboard: StoryBoards = .main) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        return storyboard.instantiateViewController(withIdentifier: className) as! T
    }
}

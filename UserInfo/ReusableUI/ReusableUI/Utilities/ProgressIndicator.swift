//
//  ProgressIndicator.swift
//  ReusableUI
//
//  Created by RAGHAV SHARMA on 30/08/21.
//  Copyright © 2021 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

public protocol ProgressIndicator {
    func showIndicator(in view: UIView)
    func hideIndicator(from view: UIView, removeFromSuperView: Bool)
}

extension ProgressIndicator {
    /// show the Progress Indicator on top of our UIView
    /// /// - Parameter view: takes in the view where we need to show progress indicator.
    /// /// - Description: if there is instance of activity indicator already existing on this view, start animation. if not create a new instance and add the subview of activity indicator on top of this view.
    public func showIndicator(in view: UIView) {
        if let activityIndicator = view.viewWithTag(101)
            as? UIActivityIndicatorView {
            activityIndicator.startAnimating()
        } else {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = 101
            activityIndicator.center = view.center
            activityIndicator.accessibilityIdentifier = "ActivityIndicator"
            view.addSubview(activityIndicator)
        }
        
    }
    /// hides the Progress Indicator
    /// - Parameter view: takes in the view from where we need to hide progress indicator.
    public func hideIndicator(from view: UIView, removeFromSuperView: Bool = false) {
        guard let activityIndicator = view.viewWithTag(101) as? UIActivityIndicatorView else { return }
        activityIndicator.stopAnimating()
        if removeFromSuperView {
            activityIndicator.removeFromSuperview()
        }
    }
}

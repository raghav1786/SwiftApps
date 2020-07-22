//
//  Spinner.swift
//  SmartSuggestionsBox
//
//  Created by RAGHAV SHARMA on 02/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

struct Spinner {
    
    private var containerView = UIView()
    private var progressView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    
    init() {
        
    }
    
    /**
     it displays an activity indicator view on center of the window
     */
    func show() {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor.init(white: 0.75, alpha: 0.75)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = window.center
        progressView.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.4666666667, blue: 0.7215686275, alpha: 1)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        activityIndicator.hidesWhenStopped = true
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        activityIndicator.startAnimating()
        
        window.addSubview(containerView)
    }
    
    /**
     it displays the Activity Indicator view in the passed view, with passed bounds
     - Parameter inView: The view need to show the activity
     - Parameter bounds: Bounds to show the activity
     */
    func showInView(_ inView: UIView, inBounds bounds: CGRect) {
        
        containerView.frame = bounds
        containerView.center = inView.center
        containerView.backgroundColor = UIColor.init(white: 0.75, alpha: 0.75)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = inView.center
        progressView.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.4666666667, blue: 0.7215686275, alpha: 1)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        activityIndicator.startAnimating()
        
        inView.addSubview(containerView)
    }
    
    /** it removes the presented activity indicator from the window */
    func hide(_ completion: (() -> (Void))? = nil) {
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
        containerView.removeFromSuperview()
        completion?()
    }
    
}

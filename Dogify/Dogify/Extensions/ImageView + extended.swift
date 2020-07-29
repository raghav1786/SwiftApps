//
//  ImageView + extended.swift
//  Dogify
//
//  Created by RAGHAV SHARMA on 25/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

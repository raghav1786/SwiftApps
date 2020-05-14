
import Foundation
import UIKit

extension UIView {
    /// bounce view
    func bounceView() {
        let origin:CGPoint = center
        let target:CGPoint = CGPoint(x: center.x, y: center.y - 120)
        let bounce = CABasicAnimation(keyPath: BounceEffect.keyPath)
        bounce.duration = 0.29
        bounce.fromValue = origin.y
        bounce.toValue = target.y
        bounce.repeatCount = 1
        bounce.autoreverses = true
        self.layer.add(bounce, forKey: BounceEffect.key)
    }
}

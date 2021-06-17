
import Foundation
import UIKit

extension UIViewController {
    public class func createInstance<T:UIViewController>(storyboard: StoryBoards = .main) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        return storyboard.instantiateViewController(withIdentifier: className) as! T
    }
}

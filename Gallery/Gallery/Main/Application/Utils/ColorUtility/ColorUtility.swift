import UIKit
extension UIColor {
    public class var backgroundColor: UIColor {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    public class var appRed: UIColor {
            return #colorLiteral(red: 1, green: 0.0915768519, blue: 0.1535034478, alpha: 1)
    }
    public class var navBarColor: UIColor {
        return #colorLiteral(red: 0, green: 0.6997660995, blue: 0.468921423, alpha: 1)
    }
    
    public class var textColor: UIColor {
        return .darkGray
    }
}


extension CGColor {
    public class var suggestionBackground: CGColor {
        return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
    }
}

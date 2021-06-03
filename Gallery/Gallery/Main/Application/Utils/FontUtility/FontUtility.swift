import UIKit
enum AppFontName: String {
    case regular = "HelveticaNeue-Light"
    case bold = "HelveticaNeue-Bold"
    case medium = "HelveticaNeue-Medium"
}

enum AppFontWeight: Double {
    case light = 14.0
    case regular = 20.0
    case lowerMedium = 21.0
    case medium = 30.0
    case upperMedium = 50.0
    case high = 80.0
}

extension UIFont {
    static func smallDesc() -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: CGFloat(AppFontWeight.light.rawValue))!
    }

    static func desc() -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: CGFloat(AppFontWeight.regular.rawValue))!
    }
    
    static func title() -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: CGFloat(AppFontWeight.medium.rawValue))!
    }
    
    static func subTitle() -> UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: CGFloat(AppFontWeight.lowerMedium.rawValue))!
    }

    static func heading() -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: CGFloat(AppFontWeight.upperMedium.rawValue))!
    }

    static func bigHeading() -> UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: CGFloat(AppFontWeight.high.rawValue))!
    }
}

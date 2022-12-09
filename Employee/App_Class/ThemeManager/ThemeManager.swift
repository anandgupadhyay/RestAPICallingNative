//
//  ThemeManager.swift


import UIKit

class ThemeManager {
    //Font
    class Font {        
        class func regular(size:CGFloat) -> UIFont {
            return UIFont().VerdanaRegular(size: size)
        }
        class func bold(size:CGFloat) -> UIFont {
            return UIFont().VerdanaBold(size: size)
        }
    }
}

import UIKit

struct FontName {
    
    enum SFProDisplay: String, CaseIterable {
        case regular = "SF-Pro-Display-Regular"
        case black = "SF-Pro-Display-Black"
        case medium = "SF-Pro-Display-Medium"
        case bold = "SF-Pro-Display-Bold"
        case light = "SF-Pro-Display-Light"
        case heavy = "SF-Pro-Display-Heavy"
        
        public func font(size: CGFloat) -> UIFont {
            let descriptor = UIFontDescriptor(fontAttributes: [.name: rawValue])
            return UIFont(descriptor: descriptor, size: size)
        }
    }
    
    enum Roboto: String, CaseIterable {
        case regular = "Roboto-Regular"
        case medium = "Roboto-Medium"
        case bold = "Roboto-Bold"
        
        public func font(size: CGFloat) -> UIFont {
            let descriptor = UIFontDescriptor(fontAttributes: [.name: rawValue])
            return UIFont(descriptor: descriptor, size: size)
        }
    }
}

public enum RobotoFont {
    
    public static func regular(size: CGFloat) -> UIFont {
        return FontName.Roboto.regular.font(size: size)
    }
    
    public static func medium(size: CGFloat) -> UIFont {
        return FontName.Roboto.medium.font(size: size)
    }
    
    public static func bold(size: CGFloat) -> UIFont {
        return FontName.Roboto.bold.font(size: size)
    }
}

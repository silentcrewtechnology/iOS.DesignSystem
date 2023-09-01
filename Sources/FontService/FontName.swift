import UIKit

struct FontName {
    
    enum SFProDisplay: String, CaseIterable {
        case regular = "SFProDisplay-Regular"
        case black = "SFProDisplay-Black"
        case medium = "SFProDisplay-Medium"
        case bold = "SFProDisplay-Bold"
        case light = "SFProDisplay-Light"
        case heavy = "SFProDisplay-Heavy"
        
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

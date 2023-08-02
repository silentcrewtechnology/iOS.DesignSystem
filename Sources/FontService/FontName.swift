
import UIKit

public struct FontName {
    
    public enum SFProDisplay: String, CaseIterable {
        
        case regular = "SFProDisplay-Regular"
        case black   = "SFProDisplay-Black"
        case medium  = "SFProDisplay-Medium"
        case bold    = "SFProDisplay-Bold"
        case light   = "SFProDisplay-Light"
        case heavy   = "SFProDisplay-Heavy"
        
        public func font(size: CGFloat) -> UIFont {
            let descriptor = UIFontDescriptor(fontAttributes: [.name: self.rawValue])
            return UIFont(descriptor: descriptor, size: size)
        }
    }
    
    public enum Roboto: String, CaseIterable {
        
        case medium       = "Roboto-Medium"
        case bold         = "Roboto-Bold"
        case light        = "Roboto-Light"
        case regular      = "Roboto-Regular"
        case italic       = "Roboto-Italic"
        
        case thin         = "Roboto-Thin"
        case thinItalic   = "Roboto-ThinItalic"
        case lightItalic  = "Roboto-LightItalic"
        case mediumItalic = "Roboto-MediumItalic"
        case black        = "Roboto-Black"
        case blackItalic  = "Roboto-BlackItalic"
        
        public func font(size: CGFloat) -> UIFont {
            let descriptor = UIFontDescriptor(fontAttributes: [.name: self.rawValue])
            return UIFont(descriptor: descriptor, size: size)
        }
    }
}

import UIKit

public struct ColorService {
    
    // MARK: content
    
    public static var contentAction: UIColor {
        let color = UIColor(named: "contentAction", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    public static var contentError: UIColor {
        let color = UIColor(named: "contentError", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    public static var contentInfo: UIColor {
        let color = UIColor(named: "contentInfo", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    public static var contentPrimary: UIColor {
        let color = UIColor(named: "contentPrimary", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    public static var contentSuccess: UIColor {
        let color = UIColor(named: "contentSuccess", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    public static var contentWarning: UIColor {
        let color = UIColor(named: "contentWarning", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    // MARK: background
    
    public static var backgroundErrorLight: UIColor {
        let color = UIColor(named: "backgroundErrorLight", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    public static var backgroundInfoLight: UIColor {
        let color = UIColor(named: "backgroundInfoLight", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    public static var backgroundSecondary: UIColor {
        let color = UIColor(named: "backgroundSecondary", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    public static var backgroundSuccessLight: UIColor {
        let color = UIColor(named: "backgroundSuccessLight", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
    
    public static var backgroundWarningLight: UIColor {
        let color = UIColor(named: "backgroundWarningLight", in: Bundle.module, compatibleWith: nil)
        return color ?? .white
    }
}

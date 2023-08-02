
import UIKit

public struct ImagesService {
    
    public static var checkCircleOutline: UIImage {
        let image = UIImage(named: "checkCircleOutline", in: Bundle.module, compatibleWith: nil)
        return image ?? UIImage()
    }
    
    public static var warningCircleOutline: UIImage {
        let image = UIImage(named: "warningCircleOutline", in: Bundle.module, compatibleWith: nil)
        return image ?? UIImage()
    }
    
    public static var warningTriangleOutline: UIImage {
        let image = UIImage(named: "warningTriangleOutline", in: Bundle.module, compatibleWith: nil)
        return image ?? UIImage()
    }
    
    public static var infoCircleOutline: UIImage {
        let image = UIImage(named: "infoCircleOutline", in: Bundle.module, compatibleWith: nil)
        return image ?? UIImage()
    }
    
    public static var security: UIImage {
        let image = UIImage(named: "security", in: Bundle.module, compatibleWith: nil)
        return image ?? UIImage()
    }
}


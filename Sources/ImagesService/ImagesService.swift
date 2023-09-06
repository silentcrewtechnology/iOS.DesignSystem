
import UIKit

public struct ImagesService {
    
    /// Возвращает пустую иконку, если отсутствует imageset
    public static func image(named name: String) -> UIImage {
        let image = UIImage(named: name, in: Bundle.module, compatibleWith: nil)
        return image ?? UIImage()
    }
}

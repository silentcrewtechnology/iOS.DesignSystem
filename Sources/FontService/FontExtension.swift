
import UIKit

public enum FontExtension: String {
    case ttf
}

@objc
extension UIFont {
    public static let heading4XL = RobotoFont.medium(size: 48)
    public static let heading3XL = RobotoFont.bold(size: 40)
    public static let heading2XL = RobotoFont.bold(size: 32)
    public static let headingXL = RobotoFont.bold(size: 24)
    
    public static let text4XL = RobotoFont.regular(size: 40)
    public static let text4XL_1 = RobotoFont.medium(size: 40)
    public static let text3XL = RobotoFont.regular(size: 32)
    public static let text3XL_1 = RobotoFont.medium(size: 32)
    public static let text2XL = RobotoFont.regular(size: 28)
    public static let text2XL_1 = RobotoFont.medium(size: 28)
    public static let textXL = RobotoFont.regular(size: 24)
    public static let textXL_1 = RobotoFont.medium(size: 24)
    public static let textL = RobotoFont.regular(size: 18)
    public static let textL_1 = RobotoFont.medium(size: 18)
    public static let textM = RobotoFont.regular(size: 16)
    public static let textM_1 = RobotoFont.medium(size: 16)
    public static let textS = RobotoFont.regular(size: 14)
    public static let textS_1 = RobotoFont.medium(size: 14)
    public static let textXS = RobotoFont.regular(size: 13)
    public static let textXS_1 = RobotoFont.medium(size: 13)
    public static let text2XS = RobotoFont.regular(size: 12)
    public static let text2XS_1 = RobotoFont.medium(size: 12)
    public static let text3XS = RobotoFont.regular(size: 10)
    public static let text3XS_1 = RobotoFont.medium(size: 10)
    
    public static let caption3XS = RobotoFont.regular(size: 10)
    public static let caption3XS_1 = RobotoFont.medium(size: 10)
}

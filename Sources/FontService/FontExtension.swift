
import UIKit

public enum FontExtension: String {
    case ttf
}

@objc
extension UIFont {
    public static let heading4XL = FontName.Roboto.medium.font(size: 48)
    public static let heading3XL = FontName.Roboto.bold.font(size: 40)
    public static let heading2XL = FontName.Roboto.bold.font(size: 32)
    public static let headingXL  = FontName.Roboto.bold.font(size: 24)
    
    public static let text4XL   = FontName.Roboto.regular.font(size: 40)
    public static let text4XL_1 = FontName.Roboto.medium.font(size: 40)
    public static let text3XL   = FontName.Roboto.regular.font(size: 32)
    public static let text3XL_1 = FontName.Roboto.medium.font(size: 32)
    public static let text2XL   = FontName.Roboto.regular.font(size: 28)
    public static let text2XL_1 = FontName.Roboto.medium.font(size: 28)
    public static let textXL    = FontName.Roboto.regular.font(size: 24)
    public static let textXL_1  = FontName.Roboto.medium.font(size: 24)
    public static let textL     = FontName.Roboto.regular.font(size: 18)
    public static let textL_1   = FontName.Roboto.medium.font(size: 18)
    public static let textM     = FontName.Roboto.regular.font(size: 16)
    public static let textM_1   = FontName.Roboto.medium.font(size: 16)
    public static let textS     = FontName.Roboto.regular.font(size: 14)
    public static let textS_1   = FontName.Roboto.medium.font(size: 14)
    public static let textXS    = FontName.Roboto.regular.font(size: 13)
    public static let textXS_1  = FontName.Roboto.medium.font(size: 13)
    public static let text2XS   = FontName.Roboto.regular.font(size: 12)
    public static let text2XS_1 = FontName.Roboto.medium.font(size: 12)
    public static let text3XS   = FontName.Roboto.regular.font(size: 10)
    public static let text3XS_1 = FontName.Roboto.medium.font(size: 10)
    
    public static let caption3XS   = FontName.Roboto.regular.font(size: 10)
    public static let caption3XS_1 = FontName.Roboto.medium.font(size: 10)
}

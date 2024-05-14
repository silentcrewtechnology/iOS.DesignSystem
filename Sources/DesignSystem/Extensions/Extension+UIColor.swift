import UIKit

public extension UIColor {
    
    convenience init(hexString: String) {
        let trimmedHexString = hexString.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted)
        let hex = UInt(trimmedHexString, radix: 16) ?? 0xFF000000
        let r, g, b, a: UInt
        switch trimmedHexString.count {
        case 6: // #RRGGBB
            (r, g, b, a) = (hex >> 16 & 0xFF, hex >> 8 & 0xFF, hex & 0xFF, 0xFF)
        case 8: // #AARRGGBB
            (r, g, b, a) = (hex >> 16 & 0xFF, hex >> 8 & 0xFF, hex & 0xFF, hex >> 24 & 0xFF)
        default:
            (r, g, b, a) = (0, 0, 0, 0xFF)
        }
        self.init(
            red: CGFloat(r) / 0xFF,
            green: CGFloat(g) / 0xFF,
            blue: CGFloat(b) / 0xFF,
            alpha: CGFloat(a) / 0xFF)
    }
}

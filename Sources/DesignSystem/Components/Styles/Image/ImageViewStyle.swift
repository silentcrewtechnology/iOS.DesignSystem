import UIKit
import Components

public final class ImageViewStyle {
    
    // MARK - Properties
    
    public enum Types {
        case icon(UIImage)
        case letter(NSMutableAttributedString)
        case fillImage(UIImage)
        case custom(UIImage, CGSize)
    }
    
    public enum Color {
        case primary
        case main
        case mainInverse
        case additional1
        case additional2
        case additional3
        case additional4
        case additional5
        case additional6
        case additional7
        case additional8
    }
    
    public enum Size {
        case small
        case medium
        case large
        case extraLarge
    }
    
    // MARK: - Private properties
    
    private var type: Types
    private var color: Color
    private var size: Size
    
    // MARK: - Init
    
    public init(
        type: Types,
        color: Color,
        size: Size = .small
    ) {
        self.type = type
        self.color = color
        self.size = size
    }
    
    // MARK: - Methods
    
    public func update(
        type: Types? = nil,
        color: Color? = nil,
        size: Size? = nil,
        viewProperties: inout ImageView.ViewProperties
    ) {
        if let type {
            self.type = type
        }
        
        if let color {
            self.color = color
        }
        
        if let size {
            self.size = size
        }
        
        viewProperties.size = self.imageSize()
        viewProperties.imageSize = imageSize()
        viewProperties.cornerRadius = cornerRadius()
        viewProperties.backgroundColor = backgroundColor()
        viewProperties.image = self.type.image(tintColor: self.color.tintIconColor())
        viewProperties.text = self.type.text()?
            .fontStyle(self.size.fontStyle())
            .foregroundColor(self.color.textColor())
            .alignment(.center)
    }
    
    private func backgroundColor() -> UIColor {
        switch type {
        case .icon: return color.backgroundIconColor()
        case .letter: return color.backgroundLetterColor()
        case .fillImage: return .clear
        case .custom: return color.backgroundIconColor()
        }
    }
    
    private func cornerRadius() -> CGFloat {
        return size.size().height / 2
    }
    
    private func imageSize() -> CGSize {
        switch type {
        case .icon: .init(width: 24, height: 24)
        case .letter: .init(width: 40, height: 40)
        case .fillImage: size.size()
        case .custom( _, let size): size
        }
    }
}

// MARK: - ImageViewStyle.Types Extension

public extension ImageViewStyle.Types {
    
    func image(tintColor: UIColor) -> UIImage? {
        switch self {
        case .icon(let image): image.withTintColor(tintColor)
        case .letter: nil
        case .fillImage(let image): image
        case .custom(let image, _): image
        }
    }
    
    func text() -> NSMutableAttributedString? {
        switch self {
        case .icon: nil
        case .letter(let text): text
        case .fillImage: nil
        case .custom: nil
        }
    }
}

// MARK: - ImageViewStyle.Color Extension

public extension ImageViewStyle.Color {
    
    func backgroundIconColor() -> UIColor {
        switch self {
        case .primary: .Components.Image.Primary.Background.Color.value
        case .main: .Components.Image.Main.Background.Color.value
        case .mainInverse: .Components.Image.MainInverse.Background.Color.value
        case .additional1: .Components.Image.Add1.Background.Color.value
        case .additional2: .Components.Image.Add2.Background.Color.value
        case .additional3: .Components.Image.Add3.Background.Color.value
        case .additional4: .Components.Image.Add4.Background.Color.value
        case .additional5: .Components.Image.Add5.Background.Color.value
        case .additional6: .Components.Image.Add6.Background.Color.value
        case .additional7: .Components.Image.Add7.Background.Color.value
        case .additional8: .Components.Image.Add8.Background.Color.value
        }
    }
    
    func backgroundLetterColor() -> UIColor {
        switch self {
        case .primary: .Components.Image.Primary.Background.Color.value
        case .main: .Components.Image.Main.Background.Color.value
        case .mainInverse: .Components.Image.MainInverse.Background.Color.value
        default: .Components.Image.Primary.Background.Color.value
        }
    }
    
    func tintIconColor() -> UIColor {
        switch self {
        case .primary: .Components.Image.Primary.Icon.Color.value
        case .main: .Components.Image.Main.Icon.Color.value
        case .mainInverse: .Components.Image.MainInverse.Icon.Color.value
        case .additional1: .Components.Image.Add1.Icon.Color.value
        case .additional2: .Components.Image.Add2.Icon.Color.value
        case .additional3: .Components.Image.Add3.Icon.Color.value
        case .additional4: .Components.Image.Add4.Icon.Color.value
        case .additional5: .Components.Image.Add5.Icon.Color.value
        case .additional6: .Components.Image.Add6.Icon.Color.value
        case .additional7: .Components.Image.Add7.Icon.Color.value
        case .additional8: .Components.Image.Add8.Icon.Color.value
        }
    }
    
    func textColor() -> UIColor {
        switch self {
        case .primary: .Components.Image.Primary.Label.Color.value
        case .main: .Components.Image.Main.Label.Color.value
        case .mainInverse: .Components.Image.MainInverse.Label.Color.value
        default: .Components.Image.Primary.Label.Color.value
        }
    }
}

// MARK: - ImageViewStyle.Size

public extension ImageViewStyle.Size {
    
    func size() -> CGSize {
        switch self {
        case .small: .init(width: 32, height: 32)
        case .medium: .init(width: 40, height: 40)
        case .large: .init(width: 56, height: 56)
        case .extraLarge: .init(width: 64, height: 64)
        }
    }
    
    func fontStyle() -> FontStyle {
        switch self {
        case .small, .medium: .textM
        case .large, .extraLarge: .text2XL
        }
    }
}

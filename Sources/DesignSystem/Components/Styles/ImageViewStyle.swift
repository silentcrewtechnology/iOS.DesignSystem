import UIKit
import Components

public final class ImageViewStyle {
    public enum Types {
        case icon(UIImage)
        case letter(NSMutableAttributedString)
        case fillImage(UIImage)
        // TODO: Обсудить с Соней добавление всех атомов картинок
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
    
    private var type: Types
    private var color: Color
    
    public init(
        type: Types,
        color: Color
    ) {
        self.type = type
        self.color = color
    }
    
    public func update(
        type: Types? = nil,
        color: Color? = nil,
        viewProperties: inout ImageView.ViewProperties
    ) {
        if let type {
            self.type = type
        }
        viewProperties.size = self.type.size()
        viewProperties.cornerRadius = self.type.cornerRadius()
        viewProperties.margins = getMargins()
        
        if let color {
            self.color = color
        }
        viewProperties.backgroundColor = backgroundColor()
        
        viewProperties.text = self.type.text()?
            .fontStyle(.textM)
            .foregroundColor(self.color.textColor())
        
        viewProperties.image = self.type.image(tintColor: self.color.tintIconColor())
    }
    
    private func getMargins() -> ImageView.ViewProperties.Margins {
        return .init(
            imageTop: type.imageTop(),
            imageBottom: type.imageBottom(),
            imageLeading: type.imageLeading(),
            imageTrailing: type.imageTrailing(),
            size: type.imageSize()
        )
    }
    
    private func backgroundColor() -> UIColor {
        switch type {
        case .icon: return color.backgroundIconColor()
        case .letter: return color.backgroundLetterColor()
        case .fillImage: return .clear
        case .custom: return color.backgroundIconColor()
        }
    }
}

public extension ImageViewStyle.Types {
    func size() -> CGSize {
        switch self {
        case .custom(_ , let size): size
        default: .init(width: 40, height: 40)
        }
    }
    
    func cornerRadius() -> CGFloat {
        return self.size().height / 2
    }
    
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
    
    func imageSize() -> CGSize {
        switch self {
        case .icon: .init(width: 24, height: 24)
        case .letter: .init(width: 40, height: 40)
        case .fillImage: .init(width: 40, height: 40)
        case .custom( _, let size): size
        }
    }
    
    func imageTop() -> CGFloat {
        switch self {
        case .icon: 8
        case .letter: 0
        case .fillImage: 0
        case .custom: 0
        }
    }
    
    func imageLeading() -> CGFloat {
        switch self {
        case .icon: 8
        case .letter: 0
        case .fillImage: 0
        case .custom: 0
        }
    }
    
    func imageTrailing() -> CGFloat {
        switch self {
        case .icon: 8
        case .letter: 0
        case .fillImage: 0
        case .custom: 0
        }
    }
    
    func imageBottom() -> CGFloat {
        switch self {
        case .icon: 8
        case .letter: 0
        case .fillImage: 0
        case .custom: 0
        }
    }
}

public extension ImageViewStyle.Color {
    func backgroundIconColor() -> UIColor {
        switch self {
        case .primary:
                .Components.Image.Primary.Background.Color.value
        case .main:
                .Components.Image.Main.Background.Color.value
        case .mainInverse:
                .Components.Image.MainInverse.Background.Color.value
        case .additional1:
                .Components.Image.Add1.Background.Color.value
        case .additional2:
                .Components.Image.Add2.Background.Color.value
        case .additional3:
                .Components.Image.Add3.Background.Color.value
        case .additional4:
                .Components.Image.Add4.Background.Color.value
        case .additional5:
                .Components.Image.Add5.Background.Color.value
        case .additional6:
                .Components.Image.Add6.Background.Color.value
        case .additional7:
                .Components.Image.Add7.Background.Color.value
        case .additional8:
                .Components.Image.Add8.Background.Color.value
        }
    }
    
    func backgroundLetterColor() -> UIColor {
        switch self {
        case .primary:
                .Components.Image.Primary.Background.Color.value
        case .main:
                .Components.Image.Main.Background.Color.value
        case .mainInverse:
                .Components.Image.MainInverse.Background.Color.value
        default: .Components.Image.Primary.Background.Color.value
        }
    }
    
    func tintIconColor() -> UIColor {
        switch self {
        case .primary:
                .Components.Image.Primary.Icon.Color.value
        case .main:
                .Components.Image.Main.Icon.Color.value
        case .mainInverse:
                .Components.Image.MainInverse.Icon.Color.value
        case .additional1:
                .Components.Image.Add1.Icon.Color.value
        case .additional2:
                .Components.Image.Add2.Icon.Color.value
        case .additional3:
                .Components.Image.Add3.Icon.Color.value
        case .additional4:
                .Components.Image.Add4.Icon.Color.value
        case .additional5:
                .Components.Image.Add5.Icon.Color.value
        case .additional6:
                .Components.Image.Add6.Icon.Color.value
        case .additional7:
                .Components.Image.Add7.Icon.Color.value
        case .additional8:
                .Components.Image.Add8.Icon.Color.value
        }
    }
    
    func textColor() -> UIColor {
        switch self {
        case .primary:
                .Components.Image.Primary.Label.Color.value
        case .main:
                .Components.Image.Main.Label.Color.value
        case .mainInverse:
                .Components.Image.MainInverse.Label.Color.value
        default: .Components.Image.Primary.Label.Color.value
        }
    }
}

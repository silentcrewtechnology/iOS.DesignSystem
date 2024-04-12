import UIKit
import Components
import Colors

public struct TileViewStyle {
    
    public enum Style {
        case action
        case primary
        case main
    }
    
    public enum Size {
        case sizeS
        case sizeL
    }
    
    private let size: Size
    private let style: Style
    
    public init(
        size: Size,
        style: Style
    ) {
        self.size = size
        self.style = style
    }
    
    public func update(
        viewProperties: inout TileView.ViewProperties
    ) {
        viewProperties.backgroundColor = style.backgroundColor()
        viewProperties.width = size.width()
        viewProperties.cornerRadius = 12
        viewProperties.text = viewProperties.text
            .fontStyle(size.fontStyle())
            .foregroundColor(style.textColor())
            .alignment(.center)
        viewProperties.textWidth = size.textWidth()
    }
    
    public func styledCenteredIcon(_ image: UIImage) -> UIImage {
        image.tinted(with: .contentPrimary)
            .centered(in: .circle(
                backgroundColor: style.iconBackgroundColor(),
                diameter: size.iconDiameter()))
    }
    
    public func centeredIcon(_ image: UIImage) -> UIImage {
        image.centered(in: .circle(
            backgroundColor: .clear,
            diameter: size.iconDiameter()))
    }
}

public extension TileViewStyle.Style {
    
    func backgroundColor() -> UIColor {
        switch self {
        case .action: .backgroundAction
        case .primary: .backgroundPrimary
        case .main: .backgroundMain
        }
    }
    
    func iconBackgroundColor() -> UIColor {
        switch self {
        case .action: .backgroundMain
        case .primary: .backgroundMain
        case .main: .backgroundPrimary
        }
    }
    
    func textColor() -> UIColor {
        switch self {
        case .action: .contentActionOn
        case .primary: .contentPrimary
        case .main: .contentPrimary
        }
    }
}

public extension TileViewStyle.Size {
    
    func width() -> CGFloat {
        switch self {
        case .sizeS: 80
        case .sizeL: 96
        }
    }
    
    func textWidth() -> CGFloat {
        switch self {
        case .sizeS: 72
        case .sizeL: 80
        }
    }
    
    func iconDiameter() -> CGFloat { 48 }
    
    func fontStyle() -> FontStyle {
        switch self {
        case .sizeS: .text2XS
        case .sizeL: .textXS
        }
    }
}

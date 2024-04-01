import UIKit
import Components
import Colors

public struct TagViewStyle {
    
    public enum Variant {
        case info
        case success
        case warning
        case danger
        case `default`
    }
    
    public enum Size {
        case sizeS
        case sizeXS
        case size2XS
    }
    
    private let variant: Variant
    private let size: Size
    
    public init(
        variant: Variant,
        size: Size
    ) {
        self.variant = variant
        self.size = size
    }
    
    public func update(
        with viewProperties: inout TagView.ViewProperties
    ) {
        viewProperties.backgroundColor = variant.backgroundColor()
        viewProperties.text = viewProperties.text
            .fontStyle(size.fontStyle())
            .foregroundColor(variant.tintColor())
        viewProperties.cornerRadius = size.cornerRadius()
        viewProperties.insets = size.insets()
    }
}

public extension TagViewStyle.Size {
    
    func fontStyle() -> FontStyle {
        switch self {
        case .sizeS: .textS
        case .sizeXS: .textXS
        case .size2XS: .text3XS
        }
    }
    
    func insets() -> UIEdgeInsets {
        switch self {
        case .sizeS: .init(top: 6, left: 12, bottom: 6, right: 12)
        case .sizeXS: .init(top: 4, left: 8, bottom: 4, right: 8)
        case .size2XS: .init(top: 0, left: 4, bottom: 0, right: 4)
        }
    }
    
    func cornerRadius() -> CGFloat {
        switch self {
        case .sizeS: 4
        case .sizeXS: 4
        case .size2XS: 2
        }
    }
}

public extension TagViewStyle.Variant {
    
    func backgroundColor() -> UIColor {
        switch self {
        case .info: .backgroundInfoLight
        case .success: .backgroundSuccessLight
        case .warning: .backgroundWarningLight
        case .danger: .backgroundErrorLight
        case .default: .backgroundSecondary
        }
    }
    
    func tintColor() -> UIColor {
        switch self {
        case .info: .contentInfoDark
        case .success: .contentSuccessDark
        case .warning: .contentWarningDark
        case .danger: .contentErrorDark
        case .default: .contentPrimary
        }
    }
}

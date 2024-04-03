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
        viewProperties.height = size.height()
        viewProperties.backgroundColor = variant.backgroundColor()
        viewProperties.text = viewProperties.text
            .fontStyle(size.fontStyle())
            .foregroundColor(variant.tintColor())
        viewProperties.cornerRadius = size.cornerRadius()
        updateSideViews(with: &viewProperties)
        updateInsets(with: &viewProperties)
    }
    
    private func updateSideViews(
        with viewProperties: inout TagView.ViewProperties
    ) {
        viewProperties.leftProperties?.inner.size = size.iconSize()
        viewProperties.leftProperties?.insets = size.tapInsets()
        viewProperties.rightProperties?.inner.size = size.iconSize()
        viewProperties.rightProperties?.insets = size.tapInsets()
    }
    
    private func updateInsets(
        with viewProperties: inout TagView.ViewProperties
    ) {
        viewProperties.insets = size.contentInsets(
            hasLeftView: viewProperties.leftProperties != nil,
            hasRightView: viewProperties.rightProperties != nil)
    }
    
    public func tintColor() -> UIColor {
        variant.tintColor()
    }
}

public extension TagViewStyle.Size {
    
    func height() -> CGFloat {
        switch self {
        case .sizeS: 32
        case .sizeXS: 24
        case .size2XS: 16
        }
    }
    
    func fontStyle() -> FontStyle {
        switch self {
        case .sizeS: .textS
        case .sizeXS: .textXS
        case .size2XS: .text3XS
        }
    }
    
    func iconSize() -> CGSize {
        switch self {
        case .sizeS: .init(width: 16, height: 16)
        case .sizeXS: .init(width: 16, height: 16)
        case .size2XS: .init(width: 8, height: 8)
        }
    }
    
    func tapInsets() -> UIEdgeInsets {
        switch self {
        case .sizeS: .init(top: 8, left: 4, bottom: 8, right: 4)
        case .sizeXS: .init(top: 4, left: 4, bottom: 4, right: 4)
        case .size2XS: .init(top: 4, left: 4, bottom: 4, right: 4)
        }
    }
    
    func contentInsets(
        hasLeftView: Bool,
        hasRightView: Bool
    ) -> UIEdgeInsets {
        
        func regularInsets() -> CGFloat {
            switch self {
            case .sizeS: 12
            case .sizeXS: 8
            case .size2XS: 4
            }
        }
        
        func iconInsets() -> CGFloat {
            switch self {
            case .sizeS: 8
            case .sizeXS: 4
            case .size2XS: 0
            }
        }
        
        return .init(
            top: 0,
            left: hasLeftView ? iconInsets() : regularInsets(),
            bottom: 0,
            right: hasRightView ? iconInsets() : regularInsets())
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

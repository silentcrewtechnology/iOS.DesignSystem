import UIKit
import Components

public struct InputMessageViewStyle {
    
    public enum Style {
        case `default`
        case active
        case disabled
    }
    
    private let style: Style
    
    public init(style: Style) {
        self.style = style
    }
    
    public func update(
        viewProperties: inout InputMessageView.ViewProperties
    ) {
        viewProperties.backgroundColor = style.backgroundColor()
        viewProperties.text = viewProperties.text?
            .foregroundColor(style.textColor())
        viewProperties.placeholder = viewProperties.placeholder?
            .foregroundColor(style.placeholderColor())
        viewProperties.border = .init(
            color: style.borderColor(),
            width: 1)
        viewProperties.cornerRadius = 28
        viewProperties.isUserInteractionEnabled = style.isEnabled()
    }
}

public extension InputMessageViewStyle.Style {
    
    func backgroundColor() -> UIColor {
        switch self {
        case .default: .backgroundPrimary
        case .active: .backgroundMain
        case .disabled: .backgroundDisabled
        }
    }
    
    func textColor() -> UIColor {
        switch self {
        case .default: .contentPrimary
        case .active: .contentPrimary
        case .disabled: .contentSecondary
        }
    }
    
    func placeholderColor() -> UIColor {
        switch self {
        case .default: .contentTertiary
        case .active: .contentTertiary
        case .disabled: .contentDisabled
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .default: .clear
        case .active: .borderAction
        case .disabled: .clear
        }
    }
    
    func isEnabled() -> Bool {
        switch self {
        case .default: true
        case .active: true
        case .disabled: false
        }
    }
}

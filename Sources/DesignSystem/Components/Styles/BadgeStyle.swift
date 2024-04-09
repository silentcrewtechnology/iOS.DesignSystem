import UIKit
import Components

public struct BadgeStyle {
    
    public enum State {
        case `default`
        case action
        case neutral
        case disabled
    }
    
    public enum Style {
        case sText
        case xsText
        case icon
    }
    
    private let style: Style
    
    public init(
        style: Style
    ) {
        self.style = style
    }
    
    public func update(
        state: State,
        viewProperties: inout BadgeView.ViewProperties
    ) {
        viewProperties.backgroundColor = state.backgroundColor()
        viewProperties.textColor = state.tintColor()
        viewProperties.image = viewProperties.image?.tinted(with: state.tintColor())
        
        viewProperties.cornerRadius = style.cornerRadius()
        
        if let font = style.fontStyle() {
            viewProperties.text = viewProperties.text?.string.fontStyle(font)
        }
        
        viewProperties.height = style.height()
    }
}

public extension BadgeStyle.State {
    
    func backgroundColor() -> UIColor {
        switch self {
        case .default: .contentError
        case .action: .backgroundSuccess
        case .neutral: .backgroundMainInverse
        case .disabled: .backgroundDisabled
        }
    }
    
    func tintColor() -> UIColor {
        switch self {
        case .default: .contentActionOn
        case .action: .contentActionOn
        case .neutral: .contentActionOn
        case .disabled: .contentDisabled
        }
    }
}

public extension BadgeStyle.Style {
    
    func cornerRadius() -> CGFloat {
        switch self {
        case .sText: 10
        case .xsText: 8
        case .icon: 10
        }
    }
    
    func fontStyle() -> FontStyle? {
        switch self {
        case .sText: .textS_1
        case .xsText: .text3XS_1
        case .icon: nil
        }
    }
    
    func height() -> CGFloat {
        switch self {
        case .sText: 20
        case .xsText: 16
        case .icon: 20
        }
    }
}

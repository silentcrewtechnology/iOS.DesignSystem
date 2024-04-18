import UIKit
import Components

public struct IconButtonStyle {
    
    public enum Style {
        case primary
        case secondary
        case tertiary
        case functional
        case round
    }
    
    public enum Size {
        case size2XS
        case sizeXS
        case sizeM
    }
    
    public enum State {
        case `default`
        case pressed
        case disabled
        case loading
    }
    
    private let style: Style
    private let size: Size
    
    public init(
        style: Style,
        size: Size
    ) {
        self.style = style
        self.size = size
    }
    
    public func update(
        state: State,
        viewProperties: inout IconButton.ViewProperties
    ) {
        viewProperties.isEnabled = state.isEnabled()
        viewProperties.size = size.size()
        viewProperties.cornerRadius = cornerRadius()
        viewProperties.backgroundColor = style.backgroundColor(state: state)
        viewProperties.image = viewProperties.image.withTintColor(style.tintColor(state: state))
        viewProperties.isLoading = state.isLoading()
    }
    
    private func cornerRadius() -> CGFloat {
        if style == .round {
            return size.size() / 2
        } else {
            return size.cornerRadius()
        }
    }
}

public extension IconButtonStyle.Style {
    
    func backgroundColor(
        state: IconButtonStyle.State
    ) -> UIColor {
        switch self {
        case .primary: primaryBackgroundColor(state: state)
        case .secondary: secondaryBackgroundColor(state: state)
        case .tertiary: tertiaryBackgroundColor(state: state)
        case .functional: .clear
        case .round: tertiaryBackgroundColor(state: state)
        }
    }
    
    func tintColor(
        state: IconButtonStyle.State
    ) -> UIColor {
        switch self {
        case .primary: primaryTintColor(state: state)
        case .secondary: secondaryTintColor(state: state)
        case .tertiary: secondaryTintColor(state: state)
        case .functional: secondaryTintColor(state: state)
        case .round: secondaryTintColor(state: state)
        }
    }
    
    private func primaryBackgroundColor(
        state: IconButtonStyle.State
    ) -> UIColor {
        switch state {
        case .default: .backgroundAction
        case .pressed: .backgroundActionPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
    
    private func primaryTintColor(
        state: IconButtonStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentActionOn
        case .pressed: .contentActionOn
        case .disabled: .contentDisabled
        case .loading: .clear
        }
    }
    
    private func secondaryBackgroundColor(
        state: IconButtonStyle.State
    ) -> UIColor {
        switch state {
        case .default: .clear
        case .pressed: .backgroundMainPressed
        case .disabled: .clear
        case .loading: .clear
        }
    }
    
    private func secondaryTintColor(
        state: IconButtonStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentPrimary
        case .pressed: .contentPrimary
        case .disabled: .contentDisabled
        case .loading: .clear
        }
    }
    
    private func tertiaryBackgroundColor(
        state: IconButtonStyle.State
    ) -> UIColor {
        switch state {
        case .default: .backgroundPrimary
        case .pressed: .backgroundPrimaryPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
}

public extension IconButtonStyle.Size {
    
    func size() -> CGFloat {
        switch self {
        case .size2XS: 32
        case .sizeXS: 40
        case .sizeM: 56
        }
    }
    
    func cornerRadius() -> CGFloat {
        switch self {
        case .size2XS: 6
        case .sizeXS: 6
        case .sizeM: 8
        }
    }
}

public extension IconButtonStyle.State {
    
    func isLoading() -> Bool {
        switch self {
        case .loading: true
        default: false
        }
    }
    
    func isEnabled() -> Bool {
        switch self {
        case .default: true
        case .pressed: true
        case .disabled: false
        case .loading: false
        }
    }
}

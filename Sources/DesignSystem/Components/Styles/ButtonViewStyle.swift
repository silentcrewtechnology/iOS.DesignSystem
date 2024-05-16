import UIKit
import Components
import Colors

public struct ButtonViewStyle {
    
    public enum Context {
        case action(Variant)
        case warning(Variant)
        case error(Variant)
        case secondary
        case inverse(Variant)
    }
    
    public enum Variant {
        case contained
        case function
        case ghost
    }
    
    public enum State {
        case `default`
        case pressed
        case disabled
        case loading
    }
    
    public enum Size {
        case sizeXS
        case sizeM
    }
    
    public var context: Context
    public var state: State
    public var size: Size

    public init(
        context: Context,
        state: State,
        size: Size
    ) {
        self.context = context
        self.state = state
        self.size = size
    }
    
    
    public func update(
        viewProperties: inout ButtonView.ViewProperties
    ) {
        viewProperties.isEnabled = state.isEnabled()
        viewProperties.backgroundColor = context.backgroundColor(state: state)
        viewProperties.leftIcon = viewProperties.leftIcon?.withTintColor(context.tintColor(state: state))
        viewProperties.rightIcon = viewProperties.rightIcon?.withTintColor(context.tintColor(state: state))
        viewProperties.insets = size.insets(isLoading: state.isLoading())
        viewProperties.activityIndicator = .init(
            icon: .ic24SpinerLoader.withTintColor(context.loaderColor()),
            size: size.indicatorSize(),
            isAnimating: state.isLoading()
        )
        viewProperties.attributedText = viewProperties.attributedText
            .fontStyle(size.fontStyle())
            .foregroundColor(context.tintColor(state: state))
    }
}

public extension ButtonViewStyle.State {
    
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

public extension ButtonViewStyle.Context {
    
    func backgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch self {
        case .action(.contained): actionBackgroundColor(state: state)
        case .action(.function): .clear
        case .action(.ghost): actionGhostBackgroundColor(state: state)
        case .warning(.contained): warningBackgroundColor(state: state)
        case .warning(.function): .clear
        case .warning(.ghost): warningGhostBackgroundColor(state: state)
        case .error(.contained): errorBackgroundColor(state: state)
        case .error(.function): .clear
        case .error(.ghost): errorGhostBackgroundColor(state: state)
        case .secondary: secondaryBackgroundColor(state: state)
        case .inverse(.contained): inverseBackgroundColor(state: state)
        case .inverse(.function): .clear
        case .inverse(.ghost): inverseGhostBackgroundColor(state: state)
        }
    }

    func tintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch self {
        case .action(.contained): actionTintColor(state: state)
        case .action(.function): actionFunctionTintColor(state: state)
        case .action(.ghost): actionGhostTintColor(state: state)
        case .warning(.contained): actionTintColor(state: state)
        case .warning(.function): warningFunctionTintColor(state: state)
        case .warning(.ghost): warningGhostTintColor(state: state)
        case .error(.contained): actionTintColor(state: state)
        case .error(.function): errorFunctionTintColor(state: state)
        case .error(.ghost): errorGhostTintColor(state: state)
        case .secondary: secondaryTintColor(state: state)
        case .inverse(.contained): secondaryTintColor(state: state)
        case .inverse(.function): inverseTintColor(state: state)
        case .inverse(.ghost): inverseTintColor(state: state)
        }
    }
    
    func loaderColor() -> UIColor {
        switch self {
        case .inverse: .contentPrimaryInverse
        default: .contentDisabled
        }
    }

    private func actionBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .backgroundAction
        case .pressed: .backgroundActionPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
    
    private func actionTintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .backgroundMain
        case .pressed: .backgroundMain
        case .disabled: .contentDisabled
        case .loading: .contentDisabled
        }
    }
    
    private func actionGhostBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .clear
        case .pressed: .backgroundActionLightPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
    
    private func actionGhostTintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentAction
        case .pressed: .contentAction
        case .disabled: .contentDisabled
        case .loading: .contentDisabled
        }
    }
    
    private func actionFunctionTintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentAction
        case .pressed: .contentActionPressed
        case .disabled: .contentDisabled
        case .loading: .contentDisabled
        }
    }
    
    private func warningBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .backgroundWarning
        case .pressed: .backgroundWarningPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
    
    private func warningGhostTintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentWarning
        case .pressed: .contentWarning
        case .disabled: .contentDisabled
        case .loading: .contentDisabled
        }
    }
    
    private func warningGhostBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .clear
        case .pressed: .backgroundWarningLightPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
    
    private func warningFunctionTintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentWarning
        case .pressed: .contentWarningPressed
        case .disabled: .contentDisabled
        case .loading: .contentDisabled
        }
    }
    
    private func errorBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .backgroundError
        case .pressed: .backgroundErrorPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
    
    private func errorFunctionTintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentError
        case .pressed: .contentErrorPressed
        case .disabled: .contentDisabled
        case .loading: .contentDisabled
        }
    }
    
    private func errorGhostBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .clear
        case .pressed: .backgroundErrorLightPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
    
    private func errorGhostTintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentError
        case .pressed: .contentError
        case .disabled: .contentDisabled
        case .loading: .contentDisabled
        }
    }
    
    private func secondaryBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .backgroundSecondary
        case .pressed: .backgroundSecondaryPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
    
    private func secondaryTintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentPrimary
        case .pressed: .contentPrimary
        case .disabled: .contentDisabled
        case .loading: .contentDisabled
        }
    }
    
    private func inverseBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .backgroundMain
        case .pressed: .backgroundMainHover
        case .disabled: .backgroundMainPressed
        case .loading: .backgroundMainPressed
        }
    }
    
    private func inverseGhostBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .clear
        case .pressed: .backgroundGhostPressed
        case .disabled: .backgroundGhostPressed
        case .loading: .clear
        }
    }
    
    private func inverseTintColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .contentActionOn
        case .pressed: .contentActionOn
        case .disabled: .contentDisabled
        case .loading: .contentDisabled
        }
    }
}

public extension ButtonViewStyle.Size {
    
    func fontStyle() -> FontStyle {
        switch self {
        case .sizeXS: .textS
        case .sizeM: .textM
        }
    }
    
    func indicatorSize() -> CGSize {
        switch self {
        case .sizeXS: .init(width: 16, height: 16)
        case .sizeM: .init(width: 24, height: 24)
        }
    }
    
    func insets(
        isLoading: Bool
    ) -> UIEdgeInsets {
        
        func smallInsets() -> UIEdgeInsets {
            switch isLoading {
            case false: .init(top: 12, left: 12, bottom: 12, right: 12)
            case true: .init(top: 12, left: 24, bottom: 12, right: 24)
            }
        }
        
        func largeInsets() -> UIEdgeInsets {
            switch isLoading {
            case false: .init(top: 16, left: 16, bottom: 16, right: 16)
            case true: .init(top: 16, left: 28, bottom: 16, right: 28)
            }
        }
        
        switch self {
        case .sizeXS: return smallInsets()
        case .sizeM: return largeInsets()
        }
    }
}

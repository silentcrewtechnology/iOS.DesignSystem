import UIKit
import Components

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
    
    private let style: Context
    private let size: Size

    public init(
        style: Context,
        size: Size
    ) {
        self.style = style
        self.size = size
    }
    
    
    public func update(
        state: State,
        viewProperties: inout ButtonView.ViewProperties
    ) {
        viewProperties.isEnabled = state.isEnabled()
        viewProperties.backgroundColor = style.backgroundColor(state: state)
        viewProperties.insets = size.insets(isLoading: state.isLoading())
        viewProperties.attributedText = viewProperties.attributedText.fontStyle(size.fontStyle())

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
            
        case .action(let variant):
            switch variant {
                
            case .contained:
               return actionBackgroundColor(state: state)
            case .function:
                return .clear
            case .ghost:
                return actionGhostBackgroundColor(state: state)
            }
            
        case .warning(let variant):
            switch variant {
            case .contained:
                return warningBackgroundColor(state: state)
            case .function:
                return .clear
            case .ghost:
                return  warningGhostBackgroundColor(state: state)
            }
            
        case .error(let variant):
            switch variant {
            case .contained:
                return errorBackgroundColor(state: state)
            case .function:
                return .clear
            case .ghost:
                return errorGhostBackgroundColor(state: state)
            }
            
        case .secondary: return secondaryBackgroundColor(state: state)
            
        case .inverse(let variant):
            switch variant {
            case .contained:
                return inverseBackgroundColor(state: state)
            case .function:
                return .clear
            case .ghost:
                return inverseGhostBackgroundColor(state: state)
            }
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
    
    private func secondaryBackgroundColor(
        state: ButtonViewStyle.State
    ) -> UIColor {
        switch state {
        case .default: .backgroundSecondary
        case .pressed: .backgroundErrorPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
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
    
}

public extension ButtonViewStyle.Size {
    
    func fontStyle() -> FontStyle {
        switch self {
        case .sizeXS: .textS
        case .sizeM: .textM
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

import UIKit
import Components

public class ButtonIconStyle {
    
    public enum Variant {
        case primary
        case secondary
    }
    
    public enum Size {
        case small
        case large
    }
    
    public enum State {
        case `default`
        case pressed
        case disabled
        case loading
    }
    
    public enum Color {
        case light
        case accent
    }
    
    private var variant: Variant
    private var size: Size
    private var state: State
    private var color: Color
    
    public init(
        variant: Variant,
        size: Size,
        state: State,
        color: Color
    ) {
        self.variant = variant
        self.size = size
        self.state = state
        self.color = color
    }
    
    public func update(
        variant: Variant? = nil,
        size: Size? = nil,
        state: State? = nil,
        color: Color? = nil,
        viewProperties: inout ButtonIcon.ViewProperties
    ) {
        if let state {
            self.state = state
            viewProperties.isEnabled = state.isEnabled()
            viewProperties.isLoading = state.isLoading()
        }
        
        if let size {
            self.size = size
            viewProperties.size = size.size()
            viewProperties.cornerRadius = size.cornerRadius()
        }
        
        if let variant {
            self.variant = variant
        }
        
        if let color {
            self.color = color
        }
        
        viewProperties.backgroundColor = backgroundColor()
        viewProperties.image = viewProperties.image.withTintColor(tintColor())
        
        if let size = size,
           let state = state {
            viewProperties.activityIndicator = .init(
                icon: .ic24SpinerLoader.withTintColor(tintColor()),
                size: size.indicatorSize(),
                isAnimating: state.isLoading()
            )
        }
    }
}

// MARK: Background Colors
extension ButtonIconStyle {
    private func backgroundColor() -> UIColor {
        switch color {
        case .accent: backgroundAccentStyleColor()
        case .light: backgroundLightStyleColor()
        }
    }
    
    private func backgroundAccentStyleColor() -> UIColor {
        switch variant {
        case .primary: backgroundAccentPrimaryStateColor()
        case .secondary: backgroundAccentSecondaryStateColor()
        }
    }
    
    private func backgroundLightStyleColor() -> UIColor {
        return backgroundLightStateColor()
    }
    
    private func backgroundAccentPrimaryStateColor() -> UIColor {
        switch state {
        case .default: .backgroundAction
        case .pressed: .backgroundActionPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundAction
        }
    }
    
    private func backgroundAccentSecondaryStateColor() -> UIColor {
        switch state {
        case .default: .backgroundDisabled
        case .pressed: .backgroundSecondaryPressed
        case .disabled: .backgroundDisabled
        case .loading: .backgroundDisabled
        }
    }
    
    private func backgroundLightStateColor() -> UIColor {
        switch state {
        case .default: .backgroundMain
        case .pressed: .backgroundDisabled
        case .disabled: .backgroundDisabled
        case .loading: .backgroundMain
        }
    }
}

// MARK: Tint Colors
extension ButtonIconStyle {
    private func tintColor() -> UIColor {
        switch color {
        case .accent: tintAccentStyleColor()
        case .light: tintLightStyleColor()
        }
    }
    
    private func tintAccentStyleColor() -> UIColor {
        switch variant {
        case .primary: tintAccentPrimaryStyleColor()
        case .secondary: tintAccentSecondaryStyleColor()
        }
    }
    
    private func tintLightStyleColor() -> UIColor {
        return tintLightStateColor()
    }
    
    private func tintAccentPrimaryStyleColor() -> UIColor {
        switch state {
        case .default, .pressed, .loading:
            return .contentActionOn
        case .disabled:
            return .contentDisabled
        }
    }
    
    private func tintAccentSecondaryStyleColor() -> UIColor {
        switch state {
        case .default, .pressed, .loading:
            return .contentPrimary
        case .disabled:
            return .contentDisabled
        }
    }
    
    private func tintLightStateColor() -> UIColor {
        switch state {
        case .default, .pressed, .loading:
            return .contentPrimary
        case .disabled:
            return .contentDisabled
        }
    }
}

public extension ButtonIconStyle.Size {
    func size() -> CGFloat {
        switch self {
        case .small: 32
        case .large: 56
        }
    }
    
    func cornerRadius() -> CGFloat {
        return self.size() / 2
    }
    
    func indicatorSize() -> CGSize {
        switch self {
        case .small: .init(width: 16, height: 16)
        case .large: .init(width: 24, height: 24)
        }
    }
}

public extension ButtonIconStyle.State {
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

import UIKit
import Components
import Colors

public final class ButtonIconStyle {
    
    // MARK: - Properties
    
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
    
    // MARK: - Private properties
    
    private var variant: Variant
    private var size: Size
    private var state: State
    private var color: Color
    
    // MARK: - Init
    
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
    
    // MARK: - Methods
    
    public func update(
        variant: Variant? = nil,
        size: Size? = nil,
        state: State? = nil,
        color: Color? = nil,
        viewProperties: inout ButtonIcon.ViewProperties
    ) {
        if let size {
            self.size = size
        }
        
        if let variant {
            self.variant = variant
        }
        
        if let color {
            self.color = color
        }
        
        if let state {
            self.state = state
        }
        
        viewProperties.backgroundColor = backgroundColor(variant: self.variant, state: self.state, color: self.color)
        viewProperties.margins = getMargins()
        viewProperties.cornerRadius = self.size.cornerRadius()
        viewProperties.isEnabled = self.state.isEnabled()
        viewProperties.image = viewProperties.image?
            .withTintColor(
                tintColor(
                    variant: self.variant,
                    state: self.state,
                    color: self.color
                )
            )
    }
    
    // MARK: - Private methods
    
    private func getMargins() -> ButtonIcon.ViewProperties.Margins {
        return .init(
            insets: size.insets(),
            size: size.imageSize()
        )
    }
}

// MARK: - Background Colors

extension ButtonIconStyle {
    
    private func backgroundColor(
        variant: Variant,
        state: State,
        color: Color
    ) -> UIColor {
        switch color {
        case .accent: backgroundAccentStyleColor(variant: variant, state: state)
        case .light: backgroundLightStyleColor(state: state)
        }
    }
    
    private func backgroundAccentStyleColor(
        variant: Variant,
        state: State
    ) -> UIColor {
        switch variant {
        case .primary: backgroundAccentPrimaryStateColor(state: state)
        case .secondary: backgroundAccentSecondaryStateColor(state: state)
        }
    }
    
    private func backgroundLightStyleColor(state: State) -> UIColor {
        return backgroundLightStateColor(state: state)
    }
    
    private func backgroundAccentPrimaryStateColor(state: State) -> UIColor {
        switch state {
        case .default: .Components.ButtonIcon.Accent.Primary.Background.Color.default
        case .pressed: .Components.ButtonIcon.Accent.Primary.Background.Color.pressed
        case .disabled: .Components.ButtonIcon.Accent.Primary.Background.Color.disabled
        case .loading: .Components.ButtonIcon.Accent.Primary.Background.Color.loading
        }
    }
    
    private func backgroundAccentSecondaryStateColor(state: State) -> UIColor {
        switch state {
        case .default: .Components.ButtonIcon.Accent.Secondary.Background.Color.default
        case .pressed: .Components.ButtonIcon.Accent.Secondary.Background.Color.pressed
        case .disabled: .Components.ButtonIcon.Accent.Secondary.Background.Color.disabled
        case .loading: .Components.ButtonIcon.Accent.Secondary.Background.Color.loading
        }
    }
    
    private func backgroundLightStateColor(state: State) -> UIColor {
        switch state {
        case .default: .Components.ButtonIcon.Light.Primary.Background.Color.default
        case .pressed: .Components.ButtonIcon.Light.Primary.Background.Color.pressed
        case .disabled: .Components.ButtonIcon.Light.Primary.Background.Color.disabled

        case .loading: .Components.ButtonIcon.Light.Primary.Background.Color.loading
        }
    }
}

// MARK: - Tint Colors

extension ButtonIconStyle {
    
    private func tintColor(
        variant: Variant,
        state: State,
        color: Color
    ) -> UIColor {
        switch color {
        case .accent: tintAccentStyleColor(variant: variant, state: state)
        case .light: tintLightStyleColor(state: state)
        }
    }
    
    private func tintAccentStyleColor(
        variant: Variant,
        state: State
    ) -> UIColor {
        switch variant {
        case .primary: tintAccentPrimaryStyleColor(state: state)
        case .secondary: tintAccentSecondaryStyleColor(state: state)
        }
    }
    
    private func tintLightStyleColor(state: State) -> UIColor {
        return tintLightStateColor(state: state)
    }
    
    private func tintAccentPrimaryStyleColor(state: State) -> UIColor {
        switch state {
        case .default:
            return .Components.ButtonIcon.Accent.Primary.Icon.Color.default
        case .pressed:
            return .Components.ButtonIcon.Accent.Primary.Icon.Color.pressed
        case .disabled:
            return .Components.ButtonIcon.Accent.Primary.Icon.Color.disabled
            // TODO: в json от дизайнеров нет Color.loading
        case .loading:
            return .Components.ButtonIcon.Accent.Primary.Icon.Color.default
            
        }
    }
    
    private func tintAccentSecondaryStyleColor(state: State) -> UIColor {
        switch state {
        case .default:
            return .Components.ButtonIcon.Accent.Secondary.Icon.Color.default
        case .pressed:
            return .Components.ButtonIcon.Accent.Secondary.Icon.Color.pressed
        case .disabled:
            return .Components.ButtonIcon.Accent.Secondary.Icon.Color.disabled
            // TODO: в json от дизайнеров нет Color.loading
        case .loading:
            return .Components.ButtonIcon.Accent.Secondary.Icon.Color.default
        }
    }
    
    private func tintLightStateColor(state: State) -> UIColor {
        switch state {
        case .default:
            return .Components.ButtonIcon.Light.Primary.Icon.Color.default
        case .pressed:
            return .Components.ButtonIcon.Light.Primary.Icon.Color.pressed
        case .disabled:
            return .Components.ButtonIcon.Light.Primary.Icon.Color.disabled
            // TODO: в json от дизайнеров нет Color.loading
        case .loading:
            return .Components.ButtonIcon.Light.Primary.Icon.Color.default
        }
    }
}

// MARK: - Loader styles

extension ButtonIconStyle {
    
    public func loaderStyle() -> LoaderViewStyle {
        switch variant {
        case .primary: .init(color: .custom(loaderPrimaryColor()), size: loaderSize())
        case .secondary: .init(color: .custom(loaderSecondaryColor()), size: loaderSize())
        }
    }
    
    private func loaderPrimaryColor() -> UIColor {
        switch color {
        case .light: .Components.ButtonIcon.Light.Primary.Loader.Color.color
        case .accent: .Components.ButtonIcon.Accent.Primary.Loader.Color.color
        }
    }
    
    private func loaderSecondaryColor() -> UIColor {
        switch color {
        // TODO: - Нет цвета в json
        case .light: .Components.Button.Light.Secondary.Loader.Color.loading
        case .accent: .Components.ButtonIcon.Accent.Secondary.Loader.Color.color
        }
    }
    
    private func loaderSize() -> LoaderViewStyle.Size {
        switch size {
        case .large: .m
        case .small: .s
        }
    }
}

// MARK: - ButtonIconStyle.Size Extension

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
    
    func imageSize() -> CGSize {
        switch self {
        case .small: .init(width: 16, height: 16)
        case .large: .init(width: 24, height: 24)
        }
    }
    
    func insets() -> UIEdgeInsets {
        switch self {
        case .small: .init(top: 8, left: 8, bottom: 8, right: 8)
        case .large: .init(top: 16, left: 16, bottom: 16, right: 16)
        }
    }
}

// MARK: - ButtonIconStyle.State Extension

public extension ButtonIconStyle.State {
    
    func isLoading() -> Bool {
        switch self {
        case .loading: true
        default: false
        }
    }
    
    func isEnabled() -> Bool {
        switch self {
        case .default, .pressed: true
        case .disabled, .loading: false
        }
    }
}

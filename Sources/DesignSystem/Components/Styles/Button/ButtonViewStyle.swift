import UIKit
import Components
import Colors

public final class ButtonViewStyle {
    
    // MARK: - Properties

    public enum Size {
        case large
        case small
    }
    
    public enum Color {
        case light
        case accent
    }
    
    public enum Variant {
        case primary
        case secondary
        case tertiary
        case function
    }
    
    public enum State {
        case `default`
        case pressed
        case disabled
        case loading
    }
    
    public enum Icon {
        case without
        case with(UIImage)
    }
    
    // MARK: - Private properties
    
    private var size: Size
    private var color: Color
    private var variant: Variant
    private var state: State
    private var icon: Icon
    
    // MARK: - Init
    
    public init(
        size: Size,
        color: Color,
        variant: Variant,
        state: State,
        icon: Icon
    ) {
        self.size = size
        self.color = color
        self.variant = variant
        self.state = state
        self.icon = icon
    }
    
    // MARK: - Methods

    public func update(
        size: Size? = nil,
        color: Color? = nil,
        variant: Variant? = nil,
        state: State? = nil,
        icon: Icon? = nil,
        viewProperties: inout ButtonView.ViewProperties
    ) {
        if let size {
            self.size = size
        }
        
        if let color {
            self.color = color
        }
        
        if let variant {
            self.variant = variant
        }
        
        if let state {
            self.state = state
        }
        
        if let icon {
            self.icon = icon
        }
        
        viewProperties.backgroundColor = backgroundColor()
        viewProperties.isEnabled = self.state.isEnabled()
        viewProperties.cornerRadius = self.size.cornerRadius()
        viewProperties.margins = self.size.getMargins(isLoading: self.state.isLoading())
        viewProperties.attributedText = viewProperties.attributedText?
            .fontStyle(self.size.fontStyle())
            .foregroundColor(tintColor())
            .alignment(.center)
    
        if case .loading = self.state {
            viewProperties.leftIcon = nil
        } else {
            switch self.icon {
            case .with(let icon):
                viewProperties.leftIcon = icon.withTintColor(tintColor())
            case .without:
                viewProperties.leftIcon = nil
            }
        }
    }
}

// MARK: - Background colors

extension ButtonViewStyle {
    
    private func backgroundColor() -> UIColor {
        switch color {
        case .accent: backgroundAccentColor()
        case .light: backgroundLightColor()
        }
    }
    
    private func backgroundAccentColor() -> UIColor {
        switch variant {
        case .primary: backgroundAccentPrimaryColor()
        case .secondary: backgroundAccentSecondaryColor()
        case .tertiary: backgroundAccentTertiaryColor()
        case .function: backgroundAccentFunctionColor()
        }
    }
    
    private func backgroundAccentPrimaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Primary.Background.Color.default
        case .pressed: .Components.Button.Accent.Primary.Background.Color.pressed
        case .disabled: .Components.Button.Accent.Primary.Background.Color.disabled
        case .loading: .Components.Button.Accent.Primary.Background.Color.loading
        }
    }
    
    private func backgroundAccentSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Secondary.Background.Color.default
        case .pressed: .Components.Button.Accent.Secondary.Background.Color.pressed
        case .disabled: .Components.Button.Accent.Secondary.Background.Color.disabled
        case .loading: .Components.Button.Accent.Secondary.Background.Color.loading
        }
    }
    
    private func backgroundAccentTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Tertiary.Background.Color.default
        case .pressed: .Components.Button.Accent.Tertiary.Background.Color.pressed
        case .disabled: .Components.Button.Accent.Tertiary.Background.Color.disabled
        case .loading: .Components.Button.Accent.Tertiary.Background.Color.loading
        }
    }
    
    private func backgroundAccentFunctionColor() -> UIColor {
        return .clear
    }
    
    private func backgroundLightColor() -> UIColor {
        switch variant {
        case .primary: backgroundLightPrimaryColor()
        case .secondary: backgroundLightSecondaryColor()
        case .tertiary: backgroundLightTertiaryColor()
        case .function: backgroundLightFunctionColor()
        }
    }
    
    private func backgroundLightPrimaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Primary.Background.Color.default
        case .pressed: .Components.Button.Light.Primary.Background.Color.pressed
        case .disabled: .Components.Button.Light.Primary.Background.Color.disabled
        case .loading: .Components.Button.Light.Primary.Background.Color.loading
        }
    }
    
    private func backgroundLightSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Secondary.Background.Color.default
        case .pressed: .Components.Button.Light.Secondary.Background.Color.pressed
        case .disabled: .Components.Button.Light.Secondary.Background.Color.disabled
        case .loading: .Components.Button.Light.Secondary.Background.Color.loading
        }
    }
    
    private func backgroundLightTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Tertiary.Background.Color.default
        case .pressed: .Components.Button.Light.Tertiary.Background.Color.pressed
        case .disabled: .Components.Button.Light.Tertiary.Background.Color.disabled
        case .loading: .Components.Button.Light.Tertiary.Background.Color.loading
        }
    }
    
    private func backgroundLightFunctionColor() -> UIColor {
        return .clear
    }
}

// MARK: - Tint text colors

extension ButtonViewStyle {
    
    private func tintColor() -> UIColor {
        switch color {
        case .accent: tintAccentColor()
        case .light: tintLightColor()
        }
    }
    
    private func tintAccentColor() -> UIColor {
        switch variant {
        case .primary: tintAccentPrimaryColor()
        case .secondary: tintAccentSecondaryColor()
        case .tertiary: tintAccentTertiaryColor()
        case .function: tintAccentFunctionColor()
        }
    }
    
    private func tintAccentPrimaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Primary.Label.Color.default
        case .pressed: .Components.Button.Accent.Primary.Label.Color.pressed
        case .disabled: .Components.Button.Accent.Primary.Label.Color.disabled
        case .loading: .clear
        }
    }
    
    private func tintAccentSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Secondary.Label.Color.default
        case .pressed: .Components.Button.Accent.Secondary.Label.Color.pressed
        case .disabled: .Components.Button.Accent.Secondary.Label.Color.disabled
        case .loading: .clear
        }
    }
    
    private func tintAccentTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Tertiary.Label.Color.default
        case .pressed: .Components.Button.Accent.Tertiary.Label.Color.pressed
        case .disabled: .Components.Button.Accent.Tertiary.Label.Color.disabled
        case .loading: .clear
        }
    }
    
    private func tintAccentFunctionColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Function.Label.Color.default
        case .pressed: .Components.Button.Accent.Function.Label.Color.pressed
        case .disabled: .Components.Button.Accent.Function.Label.Color.disabled
        case .loading: .clear
        }
    }
    
    private func tintLightColor() -> UIColor {
        switch variant {
        case .primary: tintLightPrimaryColor()
        case .secondary: tintLightSecondaryColor()
        case .tertiary: tintLightTertiaryColor()
        case .function: tintLightFunctionColor()
        }
    }
    
    private func tintLightPrimaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Primary.Label.Color.default
        case .pressed: .Components.Button.Light.Primary.Label.Color.pressed
        case .disabled: .Components.Button.Light.Primary.Label.Color.disabled
        case .loading: .clear
        }
    }
    
    private func tintLightSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Secondary.Label.Color.default
        case .pressed: .Components.Button.Light.Secondary.Label.Color.pressed
        case .disabled: .Components.Button.Light.Secondary.Label.Color.disabled
        case .loading: .clear
        }
    }
    
    private func tintLightTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Tertiary.Label.Color.default
        case .pressed: .Components.Button.Light.Tertiary.Label.Color.pressed
        case .disabled: .Components.Button.Light.Tertiary.Label.Color.disabled
        case .loading: .clear
        }
    }
    
    private func tintLightFunctionColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Function.Label.Color.default
        case .pressed: .Components.Button.Light.Function.Label.Color.pressed
        case .disabled: .Components.Button.Light.Function.Label.Color.disabled
        case .loading: .clear
        }
    }
}

// MARK: - Tint icon colors

extension ButtonViewStyle {
    
    private func tintIconColor() -> UIColor {
        switch color {
        case .accent: tintIconAccentColor()
        case .light: tintIconLightColor()
        }
    }
    
    private func tintIconAccentColor() -> UIColor {
        switch variant {
        case .primary: tintIconAccentPrimaryColor()
        case .secondary: tintIconAccentSecondaryColor()
        case .tertiary: tintIconAccentTertiaryColor()
        case .function: tintIconAccentFunctionColor()
        }
    }
    
    private func tintIconAccentPrimaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Primary.Icon.Color.default
        case .pressed: .Components.Button.Accent.Primary.Icon.Color.pressed
        case .disabled: .Components.Button.Accent.Primary.Icon.Color.disabled
        case .loading: .Components.Button.Accent.Primary.Icon.Color.loading
        }
    }
    
    private func tintIconAccentSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Secondary.Icon.Color.default
        case .pressed: .Components.Button.Accent.Secondary.Icon.Color.pressed
        case .disabled: .Components.Button.Accent.Secondary.Icon.Color.disabled
        case .loading: .Components.Button.Accent.Secondary.Icon.Color.loading
        }
    }
    
    private func tintIconAccentTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Tertiary.Icon.Color.default
        case .pressed: .Components.Button.Accent.Tertiary.Icon.Color.pressed
        case .disabled: .Components.Button.Accent.Tertiary.Icon.Color.disabled
        case .loading: .Components.Button.Accent.Tertiary.Icon.Color.loading
        }
    }
    
    private func tintIconAccentFunctionColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Function.Icon.Color.default
        case .pressed: .Components.Button.Accent.Function.Icon.Color.pressed
        case .disabled: .Components.Button.Accent.Function.Icon.Color.disabled
        case .loading: .Components.Button.Accent.Function.Icon.Color.loading
        }
    }
    
    private func tintIconLightColor() -> UIColor {
        switch variant {
        case .primary: tintIconLightPrimaryColor()
        case .secondary: tintIconLightSecondaryColor()
        case .tertiary: tintIconLightTertiaryColor()
        case .function: tintIconLightFunctionColor()
        }
    }
    
    private func tintIconLightPrimaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Primary.Icon.Color.default
        case .pressed: .Components.Button.Light.Primary.Icon.Color.pressed
        case .disabled: .Components.Button.Light.Primary.Icon.Color.disabled
        case .loading: .Components.Button.Light.Primary.Icon.Color.loading
        }
    }
    
    private func tintIconLightSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Secondary.Icon.Color.default
        case .pressed: .Components.Button.Light.Secondary.Icon.Color.pressed
        case .disabled: .Components.Button.Light.Secondary.Icon.Color.disabled
        case .loading: .Components.Button.Light.Secondary.Icon.Color.loading
        }
    }
    
    private func tintIconLightTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Tertiary.Icon.Color.default
        case .pressed: .Components.Button.Light.Tertiary.Icon.Color.pressed
        case .disabled: .Components.Button.Light.Tertiary.Icon.Color.disabled
        case .loading: .Components.Button.Light.Tertiary.Icon.Color.loading
        }
    }
    
    private func tintIconLightFunctionColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Function.Icon.Color.default
        case .pressed: .Components.Button.Light.Function.Icon.Color.pressed
        case .disabled: .Components.Button.Light.Function.Icon.Color.disabled
        case .loading: .Components.Button.Light.Function.Icon.Color.loading
        }
    }
}

// MARK: - Loader styles

public extension ButtonViewStyle {
    
    func loaderStyle() -> LoaderViewStyle {
        switch variant {
        case .primary: .init(color: .custom(loaderPrimaryColor()), size: loaderSize())
        case .secondary: .init(color: .custom(loaderSecondaryColor()), size: loaderSize())
        case .tertiary: .init(color: .custom(loaderTertiaryColor()), size: loaderSize())
        case .function: .init(color: .custom(loaderFunctionColor()), size: loaderSize())
        }
    }
    
    private func loaderPrimaryColor() -> UIColor {
        switch color {
        case .light: .Components.Button.Light.Primary.Loader.Color.loading
        case .accent: .Components.Button.Accent.Primary.Loader.Color.loading
        }
    }
    
    private func loaderSecondaryColor() -> UIColor {
        switch color {
        case .light: .Components.Button.Light.Secondary.Loader.Color.loading
        case .accent: .Components.Button.Accent.Secondary.Loader.Color.loading
        }
    }
    
    private func loaderTertiaryColor() -> UIColor {
        switch color {
        case .light: .Components.Button.Light.Tertiary.Loader.Color.loading
        case .accent: .Components.Button.Accent.Tertiary.Loader.Color.loading
        }
    }
    
    private func loaderFunctionColor() -> UIColor {
        switch color {
        case .light: .Components.Button.Light.Function.Loader.Color.loading
        case .accent: .Components.Button.Accent.Function.Loader.Color.loading
        }
    }
    
    private func loaderSize() -> LoaderViewStyle.Size {
        switch size {
        case .large: .m
        case .small: .s
        }
    }
}

// MARK: - ButtonViewStyle.Size Extension

public extension ButtonViewStyle.Size {

    func fontStyle() -> FontStyle {
        switch self {
        case .large: .textM
        case .small: .textS
        }
    }
    
    func height() -> CGFloat {
        switch self {
        case .large: 56
        case .small: 32
        }
    }
    
    func cornerRadius() -> CGFloat {
        switch self {
        case .large: 8
        case .small: height() / 2
        }
    }
    
    func indicatorFrame() -> CGRect {
        switch self {
        case .large: .init(x: .zero, y: .zero, width: 24, height: 24)
        case .small: .init(x: .zero, y: .zero, width: 16, height: 16)
        }
    }
    
    func getMargins(
        isLoading: Bool
    ) -> ButtonView.ViewProperties.Margins {
        func large() -> ButtonView.ViewProperties.Margins {
            switch isLoading {
            case false: .init(
                imageTop: 16,
                imageBottom: 16,
                top: 16,
                bottom: 16,
                leading: 16,
                trailing: 16,
                spacing: 8,
                height: height()
            )
            case true: .init(
                imageTop: 16,
                imageBottom: 16,
                top: 16,
                bottom: 16,
                leading: 16,
                trailing: 16,
                spacing: 0,
                height: height()
            )
            }
        }
        
        func small() -> ButtonView.ViewProperties.Margins {
            switch isLoading {
            case false: .init(
                imageTop: 6,
                imageBottom: 6,
                top: 6,
                bottom: 6,
                leading: 16,
                trailing: 16,
                spacing: 8,
                height: height()
            )
            case true: .init(
                imageTop: 8,
                imageBottom: 8,
                top: 8,
                bottom: 8,
                leading: 16,
                trailing: 16,
                spacing: 0,
                height: height()
            )
            }
        }
        
        switch self {
        case .large: return large()
        case .small: return small()
        }
    }
}

// MARK: - ButtonViewStyle.State Extension

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

import UIKit
import Components
import Colors

public final class ButtonViewStyle {

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
    
    private var size: Size
    private var color: Color
    private var variant: Variant
    private var state: State
    private var icon: Icon
    
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
        viewProperties.attributedText = viewProperties.attributedText?
            .fontStyle(self.size.fontStyle())
            .foregroundColor(tintColor())
        
        if case .loading = self.state {
            viewProperties.leftIcon = nil
            viewProperties.activityIndicator = .init(
                icon: .ic24SpinerLoader.withTintColor(loaderColor()),
                size: self.size.indicatorSize(),
                isAnimating: self.state.isLoading())
        } else {
            viewProperties.activityIndicator = .init()
        }
        
        if case .with(let icon) = self.icon,
           self.state != .loading {
            viewProperties.leftIcon = icon.withTintColor(tintColor())
        }
        
        viewProperties.isEnabled = self.state.isEnabled()
        viewProperties.cornerRadius = self.size.cornerRadius()

        viewProperties.margins = self.size.getMargins(isLoading: self.state.isLoading())
    }
}

// MARK: Background colors
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
        case .default: .Components.Button.Accent.Primary.Background.default
        case .pressed: .Components.Button.Accent.Primary.Background.pressed
        case .disabled: .Components.Button.Accent.Primary.Background.disabled
        case .loading: .Components.Button.Accent.Primary.Background.loading
        }
    }
    
    private func backgroundAccentSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Secondary.Background.default
        case .pressed: .Components.Button.Accent.Secondary.Background.pressed
        case .disabled: .Components.Button.Accent.Secondary.Background.disabled
        case .loading: .Components.Button.Accent.Secondary.Background.loading
        }
    }
    
    private func backgroundAccentTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Tertiary.Background.default
        case .pressed: .Components.Button.Accent.Tertiary.Background.pressed
        case .disabled: .Components.Button.Accent.Tertiary.Background.disabled
        case .loading: .Components.Button.Accent.Tertiary.Background.loading
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
        case .default: .Components.Button.Light.Primary.Background.default
        case .pressed: .Components.Button.Light.Primary.Background.pressed
        case .disabled: .Components.Button.Light.Primary.Background.disabled
        case .loading: .Components.Button.Light.Primary.Background.loading
        }
    }
    
    private func backgroundLightSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Secondary.Background.default
        case .pressed: .Components.Button.Light.Secondary.Background.pressed
        case .disabled: .Components.Button.Light.Secondary.Background.disabled
        case .loading: .Components.Button.Light.Secondary.Background.loading
        }
    }
    
    private func backgroundLightTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Tertiary.Background.default
        case .pressed: .Components.Button.Light.Tertiary.Background.pressed
        case .disabled: .Components.Button.Light.Tertiary.Background.disabled
        case .loading: .Components.Button.Light.Tertiary.Background.loading
        }
    }
    
    private func backgroundLightFunctionColor() -> UIColor {
        return .clear
    }
}

// MARK: Tint text colors
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
        case .default: .Components.Button.Accent.Primary.Label.default
        case .pressed: .Components.Button.Accent.Primary.Label.pressed
        case .disabled: .Components.Button.Accent.Primary.Label.disabled
        case .loading: .clear
        }
    }
    
    private func tintAccentSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Secondary.Label.default
        case .pressed: .Components.Button.Accent.Secondary.Label.pressed
        case .disabled: .Components.Button.Accent.Secondary.Label.disabled
        case .loading: .clear
        }
    }
    
    private func tintAccentTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Tertiary.Label.default
        case .pressed: .Components.Button.Accent.Tertiary.Label.pressed
        case .disabled: .Components.Button.Accent.Tertiary.Label.disabled
        case .loading: .clear
        }
    }
    
    private func tintAccentFunctionColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Function.Label.default
        case .pressed: .Components.Button.Accent.Function.Label.pressed
        case .disabled: .Components.Button.Accent.Function.Label.disabled
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
        case .default: .Components.Button.Light.Primary.Label.default
        case .pressed: .Components.Button.Light.Primary.Label.pressed
        case .disabled: .Components.Button.Light.Primary.Label.disabled
        case .loading: .clear
        }
    }
    
    private func tintLightSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Secondary.Label.default
        case .pressed: .Components.Button.Light.Secondary.Label.pressed
        case .disabled: .Components.Button.Light.Secondary.Label.disabled
        case .loading: .clear
        }
    }
    
    private func tintLightTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Tertiary.Label.default
        case .pressed: .Components.Button.Light.Tertiary.Label.pressed
        case .disabled: .Components.Button.Light.Tertiary.Label.disabled
        case .loading: .clear
        }
    }
    
    private func tintLightFunctionColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Function.Label.default
        case .pressed: .Components.Button.Light.Function.Label.pressed
        case .disabled: .Components.Button.Light.Function.Label.disabled
        case .loading: .clear
        }
    }
}

// MARK: Tint icon colors
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
        case .default: .Components.Button.Accent.Primary.Icon.default
        case .pressed: .Components.Button.Accent.Primary.Icon.pressed
        case .disabled: .Components.Button.Accent.Primary.Icon.disabled
        case .loading: .Components.Button.Accent.Primary.Icon.loading
        }
    }
    
    private func tintIconAccentSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Secondary.Icon.default
        case .pressed: .Components.Button.Accent.Secondary.Icon.pressed
        case .disabled: .Components.Button.Accent.Secondary.Icon.disabled
        case .loading: .Components.Button.Accent.Secondary.Icon.loading
        }
    }
    
    private func tintIconAccentTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Tertiary.Icon.default
        case .pressed: .Components.Button.Accent.Tertiary.Icon.pressed
        case .disabled: .Components.Button.Accent.Tertiary.Icon.disabled
        case .loading: .Components.Button.Accent.Tertiary.Icon.loading
        }
    }
    
    private func tintIconAccentFunctionColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Accent.Function.Icon.default
        case .pressed: .Components.Button.Accent.Function.Icon.pressed
        case .disabled: .Components.Button.Accent.Function.Icon.disabled
        case .loading: .Components.Button.Accent.Function.Icon.loading
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
        case .default: .Components.Button.Light.Primary.Icon.default
        case .pressed: .Components.Button.Light.Primary.Icon.pressed
        case .disabled: .Components.Button.Light.Primary.Icon.disabled
        case .loading: .Components.Button.Light.Primary.Icon.loading
        }
    }
    
    private func tintIconLightSecondaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Secondary.Icon.default
        case .pressed: .Components.Button.Light.Secondary.Icon.pressed
        case .disabled: .Components.Button.Light.Secondary.Icon.disabled
        case .loading: .Components.Button.Light.Secondary.Icon.loading
        }
    }
    
    private func tintIconLightTertiaryColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Tertiary.Icon.default
        case .pressed: .Components.Button.Light.Tertiary.Icon.pressed
        case .disabled: .Components.Button.Light.Tertiary.Icon.disabled
        case .loading: .Components.Button.Light.Tertiary.Icon.loading
        }
    }
    
    private func tintIconLightFunctionColor() -> UIColor {
        switch state {
        case .default: .Components.Button.Light.Function.Icon.default
        case .pressed: .Components.Button.Light.Function.Icon.pressed
        case .disabled: .Components.Button.Light.Function.Icon.disabled
        case .loading: .Components.Button.Light.Function.Icon.loading
        }
    }
}

// MARK: Activity indicator colors
extension ButtonViewStyle {
    private func loaderColor() -> UIColor {
        switch color {
        case .accent: loaderAccentColor()
        case .light: loaderLightColor()
        }
    }
    
    private func loaderAccentColor() -> UIColor {
        switch variant {
        case .primary: loaderAccentPrimaryColor()
        case .secondary: loaderAccentSecondaryColor()
        case .tertiary: loaderAccentTertiaryColor()
        case .function: loaderAccentFunctionColor()
        }
    }
    
    private func loaderAccentPrimaryColor() -> UIColor {
        switch state {
        case .default, .pressed, .disabled: .clear
        case .loading: .Components.Button.Accent.Primary.Icon.loading
        }
    }
    
    private func loaderAccentSecondaryColor() -> UIColor {
        switch state {
        case .default, .pressed, .disabled: .clear
        case .loading: .Components.Button.Accent.Secondary.Icon.loading
        }
    }
    
    private func loaderAccentTertiaryColor() -> UIColor {
        switch state {
        case .default, .pressed, .disabled: .clear
        case .loading: .Components.Button.Accent.Tertiary.Icon.loading
        }
    }
    
    private func loaderAccentFunctionColor() -> UIColor {
        switch state {
        case .default, .pressed, .disabled: .clear
        case .loading: .Components.Button.Accent.Function.Icon.loading
        }
    }
    
    private func loaderLightColor() -> UIColor {
        switch variant {
        case .primary: loaderLightPrimaryColor()
        case .secondary: loaderLightSecondaryColor()
        case .tertiary: loaderLightTertiaryColor()
        case .function: loaderLightFunctionColor()
        }
    }
    
    private func loaderLightPrimaryColor() -> UIColor {
        switch state {
        case .default, .pressed, .disabled: .clear
        case .loading: .Components.Button.Light.Primary.Icon.loading
        }
    }
    
    private func loaderLightSecondaryColor() -> UIColor {
        switch state {
        case .default, .pressed, .disabled: .clear
        case .loading: .Components.Button.Light.Secondary.Icon.loading
        }
    }
    
    private func loaderLightTertiaryColor() -> UIColor {
        switch state {
        case .default, .pressed, .disabled: .clear
        case .loading: .Components.Button.Light.Tertiary.Icon.loading
        }
    }
    
    private func loaderLightFunctionColor() -> UIColor {
        switch state {
        case .default, .pressed, .disabled: .clear
        case .loading: .Components.Button.Light.Function.Icon.loading
        }
    }
}

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
    
    func indicatorSize() -> CGSize {
        switch self {
        case .large: .init(width: 24, height: 24)
        case .small: .init(width: 16, height: 16)
        }
    }
    
    func getMargins(
        isLoading: Bool
    ) -> ButtonView.ViewProperties.Margins {
        
        func large() -> ButtonView.ViewProperties.Margins {
            switch isLoading {
            case false: .init(imageTop: 16,
                              imageBottom: 16,
                              top: 16,
                              bottom: 16,
                              leading: 16,
                              trailing: 16,
                              spacing: 8,
                              height: height())
            case true: .init(imageTop: 16,
                             imageBottom: 16,
                             top: 16,
                             bottom: 16,
                             leading: 16,
                             trailing: 16,
                             spacing: 0,
                             height: height())
            }
        }
        
        func small() -> ButtonView.ViewProperties.Margins {
            switch isLoading {
            case false: .init(imageTop: 6,
                              imageBottom: 6,
                              top: 6,
                              bottom: 6,
                              leading: 16,
                              trailing: 16,
                              spacing: 8,
                              height: height())
            case true: .init(imageTop: 8,
                             imageBottom: 8,
                             top: 8,
                             bottom: 8,
                             leading: 16,
                             trailing: 16,
                             spacing: 0,
                             height: height())
            }
        }
        
        switch self {
        case .large: return large()
        case .small: return small()
        }
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

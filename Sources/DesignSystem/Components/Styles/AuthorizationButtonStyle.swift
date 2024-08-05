import UIKit
import Components

public final class AuthorizationButtonStyle {
    
    public enum Variant {
        case gosuslugi
        case akbars
    }
    
    public enum State {
        case `default`
        case pressed
    }
    
    public enum Color {
        case accent
        case light
    }
    
    private var variant: Variant
    private var state: State
    private var color: Color
    
    public init(
        variant: Variant,
        state: State,
        color: Color
    ) {
        self.variant = variant
        self.state = state
        self.color = color
    }
    
    public func update(
        variant: Variant? = nil,
        state: State? = nil,
        color: Color? = nil,
        viewProperties: inout AuthorizationButton.ViewProperties
    ) {
        
        if let variant {
            self.variant = variant
        }
        
        if let state {
            self.state = state
        }
        
        if let color {
            self.color = color
        }
        
        viewProperties.cornerRadius = 8
        viewProperties.height = 56
        viewProperties.backgroundColor = backgroundColor()
        viewProperties.title = viewProperties.title
            .fontStyle(.textM)
            .foregroundColor(titleColor())
        
        if case .akbars = self.variant,
           let iconTintColor = iconTintColor() {
            viewProperties.image = viewProperties.image
                .withTintColor(iconTintColor)
        }

        viewProperties.spacing = spacing()
    }
}

// MARK: Background Colors
extension AuthorizationButtonStyle {
    private func backgroundColor() -> UIColor {
        switch variant {
        case .akbars: backgroundAkbarsColor()
        case .gosuslugi: backgroundGosuslugiColor()
        }
    }
    
    private func backgroundAkbarsColor() -> UIColor {
        switch color {
        case .accent: backgroundAkbarsAccentColor()
        case .light: backgroundAkbarsLightColor()
        }
    }
    
    private func backgroundGosuslugiColor() -> UIColor {
        switch color {
        case .accent: backgroundGosuslugiAccentColor()
        case .light: backgroundGosuslugiLightColor()
        }
    }
    
    private func backgroundAkbarsAccentColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Accent.Akbars.Background.default
        case .pressed: .Components.ButtonAuth.Accent.Akbars.Background.pressed
        }
    }
    
    private func backgroundAkbarsLightColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Light.Akbars.Background.default
        case .pressed: .Components.ButtonAuth.Light.Akbars.Background.pressed
        }
    }
    
    private func backgroundGosuslugiAccentColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Accent.Gosuslugi.Background.default
        case .pressed: .Components.ButtonAuth.Accent.Gosuslugi.Background.pressed
        }
    }
    
    private func backgroundGosuslugiLightColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Light.Gosuslugi.Background.default
        case .pressed: .Components.ButtonAuth.Light.Gosuslugi.Background.pressed
        }
    }
}

// MARK: Text Colors
extension AuthorizationButtonStyle {
    private func titleColor() -> UIColor {
        switch variant {
        case .akbars: titleAkbarsColor()
        case .gosuslugi: titleGosuslugiColor()
        }
    }
    
    private func titleAkbarsColor() -> UIColor {
        switch color {
        case .accent: titleAkbarsAccentColor()
        case .light: titleAkbarsLightColor()
        }
    }
    
    private func titleGosuslugiColor() -> UIColor {
        switch color {
        case .accent: titleGosuslugiAccentColor()
        case .light: titleGosuslugiLightColor()
        }
    }
    
    private func titleAkbarsAccentColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Accent.Akbars.Label.default
        case .pressed: .Components.ButtonAuth.Accent.Akbars.Label.pressed
        }
    }
    
    private func titleAkbarsLightColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Light.Akbars.Label.default
        case .pressed: .Components.ButtonAuth.Light.Akbars.Label.pressed
        }
    }
    
    private func titleGosuslugiAccentColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Accent.Gosuslugi.Label.default
        case .pressed: .Components.ButtonAuth.Accent.Gosuslugi.Label.pressed
        }
    }
    
    private func titleGosuslugiLightColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Light.Gosuslugi.Label.default
        case .pressed: .Components.ButtonAuth.Light.Gosuslugi.Label.pressed
        }
    }
}

// MARK: Icon Tint Colors
extension AuthorizationButtonStyle {
    private func iconTintColor() -> UIColor? {
        switch variant {
        case .akbars: iconAkbarsTintColor()
        case .gosuslugi: nil
        }
    }
    
    // TODO: Когда Лена добавит в json, заменить цвета
    private func iconAkbarsTintColor() -> UIColor {
        switch color {
        case .accent: .Components.ButtonAuth.Light.Akbars.Background.default
        case .light: .Components.ButtonAuth.Accent.Akbars.Background.default
        }
    }
}

// MARK: Spacing
extension AuthorizationButtonStyle {
    private func spacing() -> CGFloat {
        switch variant {
        case .akbars: 16
        case .gosuslugi: 8
        }
    }
}


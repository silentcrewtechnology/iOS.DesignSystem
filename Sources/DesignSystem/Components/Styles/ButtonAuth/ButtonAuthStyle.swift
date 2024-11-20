import UIKit
import Components

public final class ButtonAuthStyle {
    
    // MARK: - Properties
    
    public enum Variant {
        case gosuslugi
        case abb
    }
    
    public enum State {
        case `default`
        case pressed
    }
    
    public enum Color {
        case accent
        case light
    }
    
    // MARK: - Private properties
    
    private var variant: Variant
    private var state: State
    private var color: Color
    
    // MARK: - Init
    
    public init(
        variant: Variant,
        state: State,
        color: Color
    ) {
        self.variant = variant
        self.state = state
        self.color = color
    }
    
    // MARK: - Methods
    
    public func update(
        variant: Variant? = nil,
        state: State? = nil,
        color: Color? = nil,
        viewProperties: inout ButtonAuth.ViewProperties
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
        viewProperties.horizontalStackSpacing = spacing()
        viewProperties.text = viewProperties.text
            .fontStyle(.textM)
            .foregroundColor(titleColor())
        
        if case .abb = self.variant,
           let iconTintColor = iconTintColor() {
            viewProperties.image = viewProperties.image
                .withTintColor(iconTintColor)
        }
    }
}

// MARK: - Background Colors

extension ButtonAuthStyle {
    
    private func backgroundColor() -> UIColor {
        switch variant {
        case .abb: backgroundAbbColor()
        case .gosuslugi: backgroundGosuslugiColor()
        }
    }
    
    private func backgroundAbbColor() -> UIColor {
        switch color {
        case .accent: backgroundAbbAccentColor()
        case .light: backgroundAbbLightColor()
        }
    }
    
    private func backgroundGosuslugiColor() -> UIColor {
        switch color {
        case .accent: backgroundGosuslugiAccentColor()
        case .light: backgroundGosuslugiLightColor()
        }
    }
    
    private func backgroundAbbAccentColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Accent.Abb.Background.Color.default
        case .pressed: .Components.ButtonAuth.Accent.Abb.Background.Color.pressed
        }
    }
    
    private func backgroundAbbLightColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Light.Abb.Background.Color.default
        case .pressed: .Components.ButtonAuth.Light.Abb.Background.Color.pressed
        }
    }
    
    private func backgroundGosuslugiAccentColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Accent.Gosuslugi.Background.Color.default
        case .pressed: .Components.ButtonAuth.Accent.Gosuslugi.Background.Color.pressed
        }
    }
    
    private func backgroundGosuslugiLightColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Light.Gosuslugi.Background.Color.default
        case .pressed: .Components.ButtonAuth.Light.Gosuslugi.Background.Color.pressed
        }
    }
}

// MARK: - Text Colors

extension ButtonAuthStyle {
    
    private func titleColor() -> UIColor {
        switch variant {
        case .abb: titleAbbColor()
        case .gosuslugi: titleGosuslugiColor()
        }
    }
    
    private func titleAbbColor() -> UIColor {
        switch color {
        case .accent: titleAbbAccentColor()
        case .light: titleAbbLightColor()
        }
    }
    
    private func titleGosuslugiColor() -> UIColor {
        switch color {
        case .accent: titleGosuslugiAccentColor()
        case .light: titleGosuslugiLightColor()
        }
    }
    
    private func titleAbbAccentColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Accent.Abb.Label.Color.default
        case .pressed: .Components.ButtonAuth.Accent.Abb.Label.Color.pressed
        }
    }
    
    private func titleAbbLightColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Light.Abb.Label.Color.default
        case .pressed: .Components.ButtonAuth.Light.Abb.Label.Color.pressed
        }
    }
    
    private func titleGosuslugiAccentColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Accent.Gosuslugi.Label.Color.default
        case .pressed: .Components.ButtonAuth.Accent.Gosuslugi.Label.Color.pressed
        }
    }
    
    private func titleGosuslugiLightColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Light.Gosuslugi.Label.Color.default
        case .pressed: .Components.ButtonAuth.Light.Gosuslugi.Label.Color.pressed
        }
    }
}

// MARK: - Icon Tint Colors

extension ButtonAuthStyle {
    
    private func iconTintColor() -> UIColor? {
        switch variant {
        case .abb: iconAbbTintColor()
        case .gosuslugi: nil
        }
    }
    
    private func iconAbbTintColor() -> UIColor {
        switch color {
        case .accent: iconAbbTintAccentColor()
        case .light: iconAbbTintLightColor()
        }
    }
    
    private func iconAbbTintAccentColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Accent.Abb.Logo.Color.default
        case .pressed: .Components.ButtonAuth.Accent.Abb.Logo.Color.pressed
        }
    }
    
    private func iconAbbTintLightColor() -> UIColor {
        switch state {
        case .default: .Components.ButtonAuth.Light.Abb.Logo.Color.default
        case .pressed: .Components.ButtonAuth.Light.Abb.Logo.Color.pressed
        }
    }
}

// MARK: - Spacing

extension ButtonAuthStyle {
    
    private func spacing() -> CGFloat {
        switch variant {
        case .abb: 16
        case .gosuslugi: 8
        }
    }
}

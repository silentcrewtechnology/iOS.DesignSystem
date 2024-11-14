import UIKit
import Components
import Colors

public final class BadgeStyle {
    
    // MARK: - Properties
    
    public enum Color {
        case neutral
        case accent
        case accentBrand
        case accentInfo
    }
    
    public enum Size {
        case small
        case large
    }
    
    public enum Set {
        case simple
        case basic
        case full
    }
    
    // MARK: - Private properties
    
    private var color: Color
    private var size: Size
    private var set: Set
    
    // MARK: - Init
    
    public init(
        color: Color,
        size: Size,
        set: Set
    ) {
        self.color = color
        self.size = size
        self.set = set
    }
    
    // MARK: - Methods
    
    public func update(
        newColor: Color? = nil,
        newSize: Size? = nil,
        newSet: Set? = nil,
        viewProperties: inout BadgeView.ViewProperties
    ) {
        if let newColor {
            self.color = newColor
        }
        
        if let newSize {
            self.size = newSize
        }
        
        if let newSet {
            self.set = newSet
        }
        
        set.changePropertiesFromSet(properties: &viewProperties)
        
        viewProperties.backgroundColor = color.backgroundColor()
        viewProperties.textColor = color.textTintColor()
        viewProperties.image = viewProperties.image?.withTintColor(color.imageTintColor())
        viewProperties.text = viewProperties.text?.string.fontStyle(size.fontStyle())
        viewProperties.cornerRadius = cornerRadius()
        viewProperties.margins = BadgeView.ViewProperties.Margins(
            imageTop: size.imageMargins(),
            imageBottom: size.imageMargins(),
            leading: 4,
            trailing: 4,
            top: 0,
            bottom: 0,
            spacing: 2,
            height: getHeight()
        )
    }
    
    // MARK: - Private methods
    
    private func getHeight() -> CGFloat {
        switch set {
        case .basic, .full:
            return size.height()
        case .simple:
            return 6
        }
    }
    
    private func cornerRadius() -> CGFloat {
        return getHeight() / 2
    }
}

// MARK: - BadgeStyle.Set Extension

public extension BadgeStyle.Set {
    
    func changePropertiesFromSet(properties: inout BadgeView.ViewProperties) {
        switch self {
        case .simple:
            properties.isTextHidden = true
            properties.isImageHidden = true
        case .basic:
            properties.isTextHidden = false
            properties.isImageHidden = true
        case .full:
            properties.isTextHidden = false
            properties.isImageHidden = false
        }
    }
}

// MARK: - BadgeStyle.Color Extension

public extension BadgeStyle.Color {
    
    func backgroundColor() -> UIColor {
        switch self {
        case .neutral: .Components.Badge.Neutral.Background.Color.color
        case .accent: .Components.Badge.Accent.Background.Color.color
        case .accentBrand: .Components.Badge.AccentBrand.Background.Color.color
        case .accentInfo: .Components.Badge.Info.Background.Color.color
        }
    }
    
    func textTintColor() -> UIColor {
        switch self {
        case .neutral: .Components.Badge.Neutral.Label.Color.color
        case .accent: .Components.Badge.Accent.Label.Color.color
        case .accentBrand: .Components.Badge.AccentBrand.Label.Color.color
        case .accentInfo: .Components.Badge.Info.Label.Color.color
        }
    }
    
    func imageTintColor() -> UIColor {
        switch self {
        case .neutral: .Components.Badge.Neutral.Icon.Color.color
        case .accent: .Components.Badge.Accent.Icon.Color.color
        case .accentBrand: .Components.Badge.AccentBrand.Icon.Color.color
        case .accentInfo: .Components.Badge.Info.Icon.Color.color
        }
    }
}

// MARK: - BadgeStyle.Size Extension

public extension BadgeStyle.Size {
    
    func fontStyle() -> FontStyle {
        switch self {
        case .small: .text2XS_1
        case .large: .textS_1
        }
    }
    
    func height() -> CGFloat {
        switch self {
        case .small: 16
        case .large: 20
        }
    }
    
    func imageMargins() -> CGFloat {
        switch self {
        case .small: 0
        case .large: 2
        }
    }
}

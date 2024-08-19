import UIKit
import Components
import Colors
import ImagesService

public struct BannerViewStyle {
    
    // MARK: - Properties

    public enum Variant {
        case neutral
        case warning
        case error
        case success
    }
    
    // MARK: - Private properties
    
    private let variant: Variant
    
    // MARK: - Life cycle
    
    public init(variant: Variant) {
        self.variant = variant
    }
    
    // MARK: - Methods
    
    public func update(
        with viewProperties: inout BannerView.ViewProperties
    ) {
        viewProperties.backgroundColor = variant.backgroundColor()
        viewProperties.cornerRadius = 8
        viewProperties.stackViewInsets = .init(top: 12, left: 16, bottom: 12, right: 16)
        viewProperties.containerViewInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        viewProperties.height = 88
        viewProperties.spacerViewProperties = .init(size: .init(width: 4, height: 4))
        viewProperties.icon = .init(
            image: variant.icon(),
            size: .init(width: 16, height: 20)
        )
        viewProperties.title = viewProperties.title?
            .fontStyle(.textS_1)
            .foregroundColor(variant.titleTintColor())
        viewProperties.subtitle = viewProperties.subtitle?
            .fontStyle(.textS)
            .foregroundColor(variant.subtitleTintColor())
        
        if let actionButton = viewProperties.bottomButton {
            viewProperties.bottomButton?.text = actionButton.text?
                .fontStyle(.textS)
                .foregroundColor(variant.bottomButtonTintColor())
        }
    }
}

// MARK: - BannerViewStyle.Variant Extension

public extension BannerViewStyle.Variant {
    
    func icon() -> UIImage {
        func imageView() -> UIImage {
            switch self {
            case .neutral: .ic16InfoCircleOutline
            case .warning: .ic16WarningTriangleOutline
            case .error: .ic16WarningCircleOutline
            case .success: .ic16CheckCircleOutline
            }
        }
        
        func imageViewTintColor() -> UIColor {
            switch self {
            case .neutral: .Components.Banner.Neutral.Icon.color
            case .warning: .Components.Banner.Warning.Icon.color
            case .error: .Components.Banner.Error.Icon.color
            case .success: .Components.Banner.Success.Icon.color
            }
        }
        
        return imageView().withTintColor(imageViewTintColor())
    }
    
    func titleTintColor() -> UIColor {
        switch self {
        case .neutral: .Components.Banner.Neutral.Title.color
        case .warning: .Components.Banner.Warning.Title.color
        case .error: .Components.Banner.Error.Title.color
        case .success: .Components.Banner.Success.Title.color
        }
    }
    
    func subtitleTintColor() -> UIColor {
        switch self {
        case .neutral: .Components.Banner.Neutral.Subtitle.color
        case .warning: .Components.Banner.Warning.Subtitle.color
        case .error: .Components.Banner.Error.Subtitle.color
        case .success: .Components.Banner.Success.Subtitle.color
        }
    }
    
    func bottomButtonTintColor() -> UIColor {
        switch self {
        case .neutral: .Components.Banner.Neutral.ButtonLabel.color
        case .warning: .Components.Banner.Warning.ButtonLabel.color
        case .error: .Components.Banner.Error.ButtonLabel.color
        case .success: .Components.Banner.Success.ButtonLabel.color
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .neutral: .Components.Banner.Neutral.Background.color
        case .warning: .Components.Banner.Warning.Background.color
        case .error: .Components.Banner.Error.Background.color
        case .success: .Components.Banner.Success.Background.color
        }
    }
}

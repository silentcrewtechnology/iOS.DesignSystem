import UIKit
import Components
import Colors
import ImagesService

public struct SectionMessageStyle {
    
    public enum Style {
        case info
        case warning
        case success
        case error
        case neutral
    }
    
    public enum Size {
        case sizeS
        case sizeM
    }
    
    private let style: Style
    private let size: Size
    
    public init(
        style: Style,
        size: Size
    ) {
        self.style = style
        self.size = size
    }
    
    public func update(
        with viewProperties: inout SectionMessageView.ViewProperties
    ) {
        viewProperties.icon = .init(
            image: style.icon(size: size),
            size: size.iconSize())
        viewProperties.backgroundColor = style.backgroundColor()
        let fontStyles = size.fontStyles()
        viewProperties.title = viewProperties.title?
            .fontStyle(fontStyles.title)
            .foregroundColor(style.textColor())
        viewProperties.subtitle = viewProperties.subtitle?
            .fontStyle(fontStyles.content)
            .foregroundColor(style.textColor())
        if let actionButton = viewProperties.bottomButton {
            viewProperties.bottomButton?.text = actionButton.text?
                .fontStyle(fontStyles.action)
                .foregroundColor(style.actionColor())
        }
        viewProperties.cornerRadius = 8
        viewProperties.insets = .init(top: 14, left: 16, bottom: 14, right: 16)
    }
}

public extension SectionMessageStyle.Style {
    
    func icon(size: SectionMessageStyle.Size) -> UIImage {
        
        func smallIcon() -> UIImage {
            switch self {
            case .info: .ic16InfoCircleOutline
            case .warning: .ic16WarningTriangleOutline
            case .success: .ic16CheckCircleOutline
            case .error: .ic16InfoCircleOutline
            case .neutral: .ic16InfoCircleOutline
            }
        }
        
        func mediumIcon() -> UIImage {
            switch self {
            case .info: .ic24InfoCircleOutline
            case .warning: .ic24WarningTriangleOutline
            case .success: .ic24CheckCircleOutline
            case .error: .ic24InfoCircleOutline
            case .neutral: .ic24InfoCircleOutline
            }
        }
        
        func iconTintColor() -> UIColor {
            switch self {
            case .info: .contentInfo
            case .warning: .contentWarning
            case .success: .contentSuccess
            case .error: .contentError
            case .neutral: .contentPrimary
            }
        }
        
        switch size {
        case .sizeS: return smallIcon().tinted(with: iconTintColor())
        case .sizeM: return mediumIcon().tinted(with: iconTintColor())
        }
    }
    
    func textColor() -> UIColor { .contentPrimary }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .info: .backgroundInfoLight
        case .warning: .backgroundWarningLight
        case .success: .backgroundSuccessLight
        case .error: .backgroundErrorLight
        case .neutral: .backgroundSecondary
        }
    }
    
    func actionColor() -> UIColor {
        switch self {
        case .info: .contentInfo
        case .warning: .contentWarning
        case .success: .contentSuccess
        case .error: .contentError
        case .neutral: .contentSuccess
        }
    }
}

public extension SectionMessageStyle.Size {
    
    func fontStyles() -> (title: FontStyle, content: FontStyle, action: FontStyle) {
        switch self {
        case .sizeS: (title: .textS_1, content: .textS, action: .textS)
        case .sizeM: (title: .textM_1, content: .textM, action: .textM)
        }
    }
    
    func iconSize() -> CGSize {
        switch self {
        case .sizeS: .init(width: 16, height: 20)
        case .sizeM: .init(width: 24, height: 24)
        }
    }
}

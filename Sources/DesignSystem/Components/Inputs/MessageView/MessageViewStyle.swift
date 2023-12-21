import UIKit

public enum MessageViewStyle {
    
    public enum Style {
        case active
        case disabled
        case `default`
    }
    
    public static func updateStyle(
        style: Style,
        viewProperties: MessageView.ViewProperties
    ) -> MessageView.ViewProperties {
        var viewProperties = viewProperties
        switch style {
        case .active:
            viewProperties.backgroundColor = .backgroundMain
            viewProperties.attributedText = viewProperties.attributedText?.foregroundColor(.contentPrimary)
            viewProperties.attributedPlaceholder = viewProperties.attributedPlaceholder?.foregroundColor(.contentTertiary)
            viewProperties.borderColor = .borderAction
        case .disabled:
            viewProperties.backgroundColor = .backgroundDisabled
            viewProperties.attributedText = viewProperties.attributedText?.foregroundColor(.contentSecondary)
            viewProperties.attributedPlaceholder = viewProperties.attributedPlaceholder?.foregroundColor(.contentDisabled)
            viewProperties.isUserInteractionEnabled = false
        case .`default`:
            viewProperties.backgroundColor = .backgroundPrimary
            viewProperties.attributedText = viewProperties.attributedText?.foregroundColor(.contentPrimary)
            viewProperties.attributedPlaceholder = viewProperties.attributedPlaceholder?.foregroundColor(.contentTertiary)
        }
        return viewProperties
    }
}

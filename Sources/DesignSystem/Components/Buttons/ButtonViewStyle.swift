import UIKit

public enum ButtonViewStyle {
    
    public enum Style {
        case action
        case secondary
        case ghost
    }
    
    public static func updateStyle(
        style: Style,
        viewProperties: ButtonView.ViewProperties
    ) -> ButtonView.ViewProperties {
        var viewProperties = viewProperties
        switch style {
        case .action:
            viewProperties.backgroundColor = .backgroundAction
            viewProperties.higlightColor = .backgroundActionPressed
            viewProperties.leftIcon = viewProperties.leftIcon?.tinted(with: .contentActionOn)
            viewProperties.rightIcon = viewProperties.rightIcon?.tinted(with: .contentActionOn)
            viewProperties.attributedText = viewProperties.attributedText
                .fontStyle(.textM)
                .foregroundColor(.contentActionOn)
        case .secondary:
            viewProperties.backgroundColor = .backgroundSecondary
            viewProperties.higlightColor = .backgroundSecondaryPressed
            viewProperties.leftIcon = viewProperties.leftIcon?.tinted(with: .contentPrimary)
            viewProperties.rightIcon = viewProperties.rightIcon?.tinted(with: .contentPrimary)
            viewProperties.attributedText = viewProperties.attributedText
                .fontStyle(.textM)
                .foregroundColor(.contentPrimary)
        case .ghost:
            viewProperties.backgroundColor = .clear
            viewProperties.higlightColor = .backgroundActionLightPressed
            viewProperties.leftIcon = viewProperties.leftIcon?.tinted(with: .contentAction)
            viewProperties.rightIcon = viewProperties.rightIcon?.tinted(with: .contentAction)
            viewProperties.attributedText = viewProperties.attributedText
                .fontStyle(.textM)
                .foregroundColor(.contentAction)
        }
        
        return viewProperties
    }
}

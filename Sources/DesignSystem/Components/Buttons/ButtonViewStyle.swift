import UIKit

public enum ButtonViewStyle {
    
    public enum Style {
        case action
        case secondary
        case clear
    }
    
    public static func updateStyle(
        style: Style,
        viewProperties: ButtonView.ViewProperties
    ) -> ButtonView.ViewProperties {
        var viewProperties = viewProperties
        switch style {
        case .action:
            viewProperties.backgroundColor = .backgroundAction
            viewProperties.loaderImage = .ic24SpinerLoader.tinted(with: .contentPrimaryInverse)
            viewProperties.attributedText = viewProperties.attributedText
                .fontStyle(.textM)
                .foregroundColor(.contentActionOn)
        case .secondary:
            viewProperties.backgroundColor = .backgroundSecondary
            viewProperties.loaderImage = .ic24SpinerLoader.tinted(with: .contentDisabled)
            viewProperties.attributedText = viewProperties.attributedText
                .fontStyle(.textM)
                .foregroundColor(.contentPrimary)
        case .clear:
            viewProperties.backgroundColor = .clear
            viewProperties.loaderImage = .ic24SpinerLoader.tinted(with: .contentDisabled)
            viewProperties.attributedText = viewProperties.attributedText
                .fontStyle(.textM)
                .foregroundColor(.contentAction)
        }
        
        return viewProperties
    }
}

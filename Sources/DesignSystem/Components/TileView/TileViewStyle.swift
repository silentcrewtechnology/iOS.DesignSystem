import UIKit

public enum TileViewStyle {
    
    public enum Size {
        case small
        case large
    }
    
    public enum Style {
        case action
        case primary
        case main
    }
    
    public static func resize(
        size: Size,
        viewProperties: TileView.ViewProperties
    ) -> TileView.ViewProperties {
        var viewProperties = viewProperties
        switch size {
        case .small:
            viewProperties.width = 80
            viewProperties.textWidth = 72
            viewProperties.text = viewProperties.text.fontStyle(.text2XS)
        case .large:
            viewProperties.width = 96
            viewProperties.textWidth = 80
            viewProperties.text = viewProperties.text.fontStyle(.textXS)
        }
        return viewProperties
    }
    
    public static func restyle(
        style: Style,
        viewProperties: TileView.ViewProperties
    ) -> TileView.ViewProperties {
        var viewProperties = viewProperties
        switch style {
        case .action:
            viewProperties.backgroundColor = .backgroundAction
            viewProperties.text = viewProperties.text.foregroundColor(.contentActionOn)
        case .primary:
            viewProperties.backgroundColor = .backgroundPrimary
            viewProperties.text = viewProperties.text.foregroundColor(.contentPrimary)
        case .main:
            viewProperties.backgroundColor = .backgroundMain
            viewProperties.text = viewProperties.text.foregroundColor(.contentPrimary)
        }
        viewProperties.icon = restyleIcon(style: style, icon: viewProperties.icon)
        return viewProperties
    }
    
    private static func restyleIcon(
        style: Style,
        icon: TileView.ViewProperties.Icon
    ) -> TileView.ViewProperties.Icon {
        var icon = icon
        switch icon.variant {
        case .icon(let image):
            icon.variant = .icon(image.tinted(with: .contentPrimary))
            switch style {
            case .action:
                icon.backgroundColor = .backgroundMain
            case .primary:
                icon.backgroundColor = .backgroundMain
            case .main:
                icon.backgroundColor = .backgroundPrimary
            }
        case .image:
            icon.backgroundColor = .clear
        }
        return icon
    }
}

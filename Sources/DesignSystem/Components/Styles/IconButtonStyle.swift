import UIKit
import Components

public enum IconButtonStyle {
    
    public enum Style {
        case primary
        case secondary
        case tertiary
        case functional
        case round
    }
    
    public enum Size {
        case size2XS
        case sizeXS
        case sizeM
    }
    
    public enum State {
        case `default`(UIImage)
        case pressed(UIImage)
        case disabled(UIImage)
        case loading
    }
    
    public static func update(
        style: Style,
        size: Size,
        state: State,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        var viewProperties = viewProperties
        viewProperties = updateSize(size: size, viewProperties: viewProperties)
        viewProperties = updateCornerRadius(style: style, size: size, viewProperties: viewProperties)
        viewProperties = updateColors(style: style, state: state, viewProperties: viewProperties)
        viewProperties = updateEnabled(state: state, viewProperties: viewProperties)
        return viewProperties
    }
    
    private static func updateSize(
        size: Size,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        var viewProperties = viewProperties
        switch size {
        case .size2XS:
            viewProperties.size = 32
        case .sizeXS:
            viewProperties.size = 40
        case .sizeM:
            viewProperties.size = 56
        }
        return viewProperties
    }
    
    private static func updateCornerRadius(
        style: Style,
        size: Size,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        if style == .round {
            return updateRoundCornerRadius(size: size, viewProperties: viewProperties)
        }
        var viewProperties = viewProperties
        switch size {
        case .size2XS:
            viewProperties.cornerRadius = 6
        case .sizeXS:
            viewProperties.cornerRadius = 6
        case .sizeM:
            viewProperties.cornerRadius = 8
        }
        return viewProperties
    }
    
    private static func updateRoundCornerRadius(
        size: IconButtonStyle.Size,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        var viewProperties = viewProperties
        switch size {
        case .size2XS:
            viewProperties.cornerRadius = 16
        case .sizeXS:
            viewProperties.cornerRadius = 20
        case .sizeM:
            viewProperties.cornerRadius = 28
        }
        return viewProperties
    }
    
    private static func updateColors(
        style: Style,
        state: State,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        switch style {
        case .primary:
            return updatePrimaryColors(state: state, viewProperties: viewProperties)
        case .secondary:
            return updateSecondaryColors(state: state, viewProperties: viewProperties)
        case .tertiary:
            return updateTertiaryColors(state: state, viewProperties: viewProperties)
        case .functional:
            return updateFunctionalColors(state: state, viewProperties: viewProperties)
        case .round:
            return updateRoundColors(state: state, viewProperties: viewProperties)
        }
    }
    
    private static func updateEnabled(
        state: State,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        var viewProperties = viewProperties
        switch state {
        case .default:
            viewProperties.isEnabled = true
        case .pressed:
            viewProperties.isEnabled = true
        case .disabled:
            viewProperties.isEnabled = false
        case .loading:
            viewProperties.isEnabled = false
        }
        return viewProperties
    }
    
    private static func updatePrimaryColors(
        state: IconButtonStyle.State,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        var viewProperties = viewProperties
        switch state {
        case .default(let image):
            viewProperties.backgroundColor = .backgroundAction
            viewProperties.icon = .image(image.tinted(with: .contentActionOn))
        case .pressed(let image):
            viewProperties.backgroundColor = .backgroundActionPressed
            viewProperties.icon = .image(image.tinted(with: .contentActionOn))
        case .disabled(let image):
            viewProperties.backgroundColor = .backgroundDisabled
            viewProperties.icon = .image(image.tinted(with: .contentDisabled))
        case .loading:
            viewProperties.backgroundColor = .backgroundDisabled
            viewProperties.icon = .loader
        }
        return viewProperties
    }
    
    private static func updateSecondaryColors(
        state: IconButtonStyle.State,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        var viewProperties = viewProperties
        switch state {
        case .default(let image):
            viewProperties.backgroundColor = .clear
            viewProperties.icon = .image(image.tinted(with: .contentPrimary))
        case .pressed(let image):
            viewProperties.backgroundColor = .backgroundMainPressed
            viewProperties.icon = .image(image.tinted(with: .contentPrimary))
        case .disabled(let image):
            viewProperties.backgroundColor = .clear
            viewProperties.icon = .image(image.tinted(with: .contentDisabled))
        case .loading:
            viewProperties.backgroundColor = .clear
            viewProperties.icon = .loader
        }
        return viewProperties
    }
    
    private static func updateTertiaryColors(
        state: IconButtonStyle.State,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        var viewProperties = viewProperties
        switch state {
        case .default(let image):
            viewProperties.backgroundColor = .backgroundPrimary
            viewProperties.icon = .image(image.tinted(with: .contentPrimary))
        case .pressed(let image):
            viewProperties.backgroundColor = .backgroundPrimaryPressed
            viewProperties.icon = .image(image.tinted(with: .contentPrimary))
        case .disabled(let image):
            viewProperties.backgroundColor = .backgroundDisabled
            viewProperties.icon = .image(image.tinted(with: .contentDisabled))
        case .loading:
            viewProperties.backgroundColor = .backgroundDisabled
            viewProperties.icon = .loader
        }
        return viewProperties
    }
    
    private static func updateFunctionalColors(
        state: IconButtonStyle.State,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        var viewProperties = viewProperties
        switch state {
        case .default(let image):
            viewProperties.backgroundColor = .clear
            viewProperties.icon = .image(image.tinted(with: .contentPrimary))
        case .pressed(let image):
            viewProperties.backgroundColor = .clear
            viewProperties.icon = .image(image.tinted(with: .contentPrimary))
        case .disabled(let image):
            viewProperties.backgroundColor = .clear
            viewProperties.icon = .image(image.tinted(with: .contentDisabled))
        case .loading:
            viewProperties.backgroundColor = .clear
            viewProperties.icon = .loader
        }
        return viewProperties
    }
    
    private static func updateRoundColors(
        state: IconButtonStyle.State,
        viewProperties: IconButton.ViewProperties
    ) -> IconButton.ViewProperties {
        return updateTertiaryColors(state: state, viewProperties: viewProperties)
    }
}

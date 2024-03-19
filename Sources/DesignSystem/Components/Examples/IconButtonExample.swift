import UIKit

private class Example {
    
    private let view = IconButton()
    private var viewProperties = IconButton.ViewProperties()
    
    func exampleAnyStyle() {
        let style = IconButtonStyle.Style.primary
        let size = IconButtonStyle.Size.sizeXS
        let image = UIImage.ic16Book
        viewProperties.onHighlighted = { [weak self] isHighlighted in
            guard let self else { return }
            self.viewProperties = IconButtonStyle.update(
                style: style,
                size: size,
                state: isHighlighted ? .pressed(image) : .default(image),
                viewProperties: self.viewProperties)
            self.view.update(with: self.viewProperties)
        }
        viewProperties.onTap = { print("tapped") }
        // MARK: Default state
        viewProperties = IconButtonStyle.update(style: style, size: size, state: .default(image), viewProperties: viewProperties)
        view.update(with: viewProperties)
        // MARK: Disabled state
        viewProperties = IconButtonStyle.update(style: style, size: size, state: .disabled(image), viewProperties: viewProperties)
        view.update(with: viewProperties)
        // MARK: Loading state
        viewProperties = IconButtonStyle.update(style: style, size: size, state: .loading, viewProperties: viewProperties)
        view.update(with: viewProperties)
    }
}

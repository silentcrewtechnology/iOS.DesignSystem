import UIKit
import Components

private class Example {
    
    private let view = IconButton()
    private var viewProperties = IconButton.ViewProperties()
    private let style = IconButtonStyle(style: .primary, size: .sizeXS)
    
    func exampleAnyStyle() {
        viewProperties.image = .ic16Book
        viewProperties.onHighlighted = { [weak self] isHighlighted in
            guard let self else { return }
            self.style.update(
                state: isHighlighted ? .pressed : .default,
                viewProperties: &self.viewProperties)
            self.view.update(with: self.viewProperties)
        }
        viewProperties.onTap = { print("tapped") }
        // MARK: Default state
        style.update(state: .default, viewProperties: &viewProperties)
        view.update(with: viewProperties)
        // MARK: Disabled state
        style.update(state: .disabled, viewProperties: &viewProperties)
        view.update(with: viewProperties)
        // MARK: Loading state
        style.update(state: .loading, viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}

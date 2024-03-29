import UIKit
import ImagesService
import Colors

private func example() {
    let view = ButtonView()
    var viewProperties = ButtonView.ViewProperties(
        attributedText: "Example".attributed,
        leftIcon: .ic24Book,
        rightIcon: .ic24FilledBook,
        activityIndicator: .init(
            icon: .ic24SpinerLoader.tinted(with: .contentDisabled),
            size: .init(width: 24, height: 24),
            isAnimating: false),
        action: {
            print("Example")
        })
    viewProperties = ButtonViewStyle.updateStyle(style: .action, viewProperties: viewProperties)
    view.update(with: viewProperties)
    viewProperties = ButtonViewStyle.updateStyle(style: .secondary, viewProperties: viewProperties)
    view.update(with: viewProperties)
    viewProperties = ButtonViewStyle.updateStyle(style: .ghost, viewProperties: viewProperties)
    view.update(with: viewProperties)
    
    viewProperties.activityIndicator.isAnimating = true
    view.update(with: viewProperties)
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        viewProperties.activityIndicator.isAnimating = false
        view.update(with: viewProperties)
    }
}

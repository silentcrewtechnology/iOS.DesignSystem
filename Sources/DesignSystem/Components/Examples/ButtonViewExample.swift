import UIKit

private func example() {
    let view = ButtonView()
    var viewProperties = ButtonView.ViewProperties(
        attributedText: "Example".attributed,
        leftIcon: .ic24Book,
        rightIcon: .ic24FilledBook,
        action: {
            print("Example")
        })
    
    view.create(with: viewProperties)
    viewProperties = ButtonViewStyle.updateStyle(style: .action, viewProperties: viewProperties)
    view.update(with: viewProperties)
    viewProperties = ButtonViewStyle.updateStyle(style: .secondary, viewProperties: viewProperties)
    view.update(with: viewProperties)
    viewProperties = ButtonViewStyle.updateStyle(style: .ghost, viewProperties: viewProperties)
    view.update(with: viewProperties)
    
    view.startLoading()
    view.stopLoading()
}

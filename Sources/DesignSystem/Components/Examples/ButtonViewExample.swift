import UIKit
import ImagesService
import Colors
import Components

private func example() {
    let view = ButtonView()
    var viewProperties = ButtonView.ViewProperties()
    
    var style = ButtonViewStyle(
        context: .action(.contained),
        state: .default,
        size: .sizeM
    )
    
    viewProperties.attributedText = "Example".attributed
    viewProperties.leftIcon = .ic24Book
    viewProperties.rightIcon = .ic24FilledBook
    viewProperties.onHighlighted = {  isHighlighted in
        style.state = isHighlighted ? .pressed : .default
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    viewProperties.onTap = ({ print("Example") })
    
    style.state = .disabled
    style.update(viewProperties: &viewProperties)
    view.update(with: viewProperties)
    
    viewProperties.activityIndicator.isAnimating = true
    view.update(with: viewProperties)
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        viewProperties.activityIndicator.isAnimating = false
        view.update(with: viewProperties)
    }
}

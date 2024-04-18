import UIKit
import Components
import ImagesService
import Colors

private func example() {
    let indicator = ActivityIndicatorView()
    var viewProperties: ActivityIndicatorView.ViewProperties = .init(
        icon: .ic24SpinerLoader.withTintColor(.contentAction),
        size: .init(width: 24, height: 24),
        isAnimating: true)
    indicator.update(with: viewProperties)
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        viewProperties.isAnimating = false
        indicator.update(with: viewProperties)
    }
}

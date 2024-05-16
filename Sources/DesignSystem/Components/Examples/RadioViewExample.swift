import UIKit
import Components

private func example() {
    let view = RadioView()
    var viewProperties = RadioView.ViewProperties()
    var style = RadioViewStyle(
        size: .large,
        action: .on,
        state: .default
    )
    style.update(viewProperties: &viewProperties)
    view.update(with: viewProperties)
    
    style.action = .off
    style.update(viewProperties: &viewProperties)
    view.update(with: viewProperties)
}

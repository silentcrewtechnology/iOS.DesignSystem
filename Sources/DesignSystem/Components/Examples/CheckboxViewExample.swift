import UIKit
import Components

private func example() {
    let view = CheckboxView()
    var viewProperties = CheckboxView.ViewProperties()
    var style = CheckboxViewStyle(
        size: .sizeS,
        state: .default,
        action: .on
    )
    style.update(viewProperties: &viewProperties)
    view.update(with: viewProperties)
    
    style = CheckboxViewStyle(
        size: .sizeS,
        state: .default,
        action: .off
    )
    style.update(viewProperties: &viewProperties)
    view.update(with: viewProperties)
}

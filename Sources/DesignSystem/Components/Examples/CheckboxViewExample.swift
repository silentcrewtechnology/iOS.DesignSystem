import UIKit
import Components

private func example() {
    let view = CheckboxView()
    var viewProperties = CheckboxView.ViewProperties()
    let style = CheckboxViewStyle(size: .sizeS)
    style.update(state: .default, action: .on, viewProperties: &viewProperties)
    view.update(with: viewProperties)
    style.update(state: .default, action: .off, viewProperties: &viewProperties)
    view.update(with: viewProperties)
}
